import 'package:flutter/material.dart';
import '../core/squad_service.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import '../core/database_service.dart';
import 'player_detail_screen.dart'; // <--- IMPORTANTE: Importamos la pantalla de detalle

class SquadScreen extends StatefulWidget {
  final Team team;
  final DatabaseService dbService;

  const SquadScreen({super.key, required this.team, required this.dbService});

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  // CAMBIO 1: Eliminamos 'late' e inicializamos con un Future nulo
  Future<List<Player>>? _squadFuture;

  @override
  void initState() {
    super.initState();
    _loadSquad();
  }

  Future<void> _loadSquad() async {
    final squad = SquadService.fromDatabase(widget.dbService);
    final players = await squad.ensureSquad(widget.team.apiId);
    final pros = players.where((p) => !p.isYouth).toList();
    if (mounted) {
      setState(() {
        _squadFuture = Future.value(pros);
      });
    }
  }

  Color _getPositionColor(String pos) {
    switch (pos.toUpperCase()) {
      case 'GK': return Colors.orangeAccent;
      case 'DEF': return Colors.blueAccent;
      case 'MID': return const Color(0xFFDEFF9A);
      case 'FWD': return Colors.redAccent;
      default: return Colors.white54;
    }
  }

  int _positionPriority(String pos) {
    if (pos.contains('GK')) return 1;
    if (pos.contains('DEF')) return 2;
    if (pos.contains('MID')) return 3;
    if (pos.contains('FWD')) return 4;
    return 5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617), // Aseguramos el fondo oscuro coherente
      appBar: AppBar(
        title: Text(widget.team.name.toUpperCase(), 
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFDEFF9A)),
            tooltip: 'Actualizar plantilla',
            onPressed: () async {
              setState(() => _squadFuture = null);
              await SquadService.fromDatabase(widget.dbService).ensureSquad(widget.team.apiId, tryApiFirst: true);
              await _loadSquad();
            },
          ),
        ],
      ),
      // CAMBIO 2: Manejamos el estado inicial nulo del Future
      body: _squadFuture == null 
        ? const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)))
        : FutureBuilder<List<Player>>(
            future: _squadFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)));
              }

              final players = snapshot.data ?? [];
              
              if (players.isEmpty) {
                return const Center(
                  child: Text("NO SE ENCONTRARON JUGADORES.\nDESCARGANDO DATOS REALES...", 
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white24)),
                );
              }

              players.sort((a, b) => _positionPriority(a.position).compareTo(_positionPriority(b.position)));

              return Column(
                children: [
                  _buildTeamHeader(players),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(flex: 5, child: Text("JUGADOR", style: TextStyle(color: Colors.white38, fontSize: 12))),
                        Expanded(flex: 1, child: Text("EDAD", style: TextStyle(color: Colors.white38, fontSize: 12))),
                        Expanded(flex: 1, child: Text("MED", textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 12))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: players.length,
                      itemBuilder: (context, index) => _buildPlayerRow(context, players[index]),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

 Widget _buildTeamHeader(List<Player> players) {
  if (players.isEmpty) return const SizedBox();
  double avg = players.map((p) => p.average).reduce((a, b) => a + b) / players.length;

  return Container(
    margin: const EdgeInsets.all(20),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF1e293b),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFDEFF9A).withOpacity(0.3)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        Image.network(
          widget.team.logoUrl, 
          height: 50, 
          errorBuilder: (_, __, ___) => const Icon(Icons.shield, size: 40, color: Colors.white24)
        ),
        
        const SizedBox(width: 15),

        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("MEDIA", 
                style: TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1)),
              Text(avg.toStringAsFixed(1), 
                style: const TextStyle(
                  color: Color(0xFFDEFF9A), 
                  fontSize: 28, 
                  fontWeight: FontWeight.bold
                )),
            ],
          ),
        ),

        const Spacer(),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("JUG.", 
              style: TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1)),
            Text("${players.length}", 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        )
      ],
    ),
  );
}

  Widget _buildPlayerRow(BuildContext context, Player player) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerDetailScreen(
              player: player,
              dbService: widget.dbService,
              userTeam: widget.team,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: _getPositionColor(player.position).withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _getPositionColor(player.position).withOpacity(0.5)),
              ),
              child: Text(player.position, 
                textAlign: TextAlign.center,
                style: TextStyle(color: _getPositionColor(player.position), fontWeight: FontWeight.bold, fontSize: 10)),
            ),
            const SizedBox(width: 15),
            Expanded(
              flex: 5,
              child: Text(
                player.name.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: (player.age <= 20 && player.potential >= 88)
                      ? const Color(0xFFDEFF9A)
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text("${player.age}", style: const TextStyle(color: Colors.white54)),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFDEFF9A),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(player.average.toStringAsFixed(0), 
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}