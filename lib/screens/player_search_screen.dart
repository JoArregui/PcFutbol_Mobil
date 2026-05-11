import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../core/database_service.dart';
import '../models/player_model.dart';
import 'player_detail_screen.dart';

class PlayerSearchScreen extends StatefulWidget {
  final DatabaseService dbService;
  const PlayerSearchScreen({super.key, required this.dbService});

  @override
  State<PlayerSearchScreen> createState() => _PlayerSearchScreenState();
}

class _PlayerSearchScreenState extends State<PlayerSearchScreen> {
  List<Player> _results = [];
  final TextEditingController _controller = TextEditingController();

  void _onSearch(String query) async {
    if (query.isEmpty) {
      setState(() => _results = []);
      return;
    }

    final results = await widget.dbService.isar.players
        .filter()
        .nameContains(query, caseSensitive: false)
        .limit(30)
        .findAll();

    setState(() => _results = results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617), // Color oscuro del menú
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Buscar entre 15.000 jugadores...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white38),
          ),
          onChanged: _onSearch,
          style: const TextStyle(color: Color(0xFFDEFF9A)),
        ),
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Color(0xFFDEFF9A)),
      ),
      body: _results.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final player = _results[index];
                return _buildPlayerTile(player);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 60, color: Colors.white.withOpacity(0.05)),
          const SizedBox(height: 15),
          const Text("Escribe un nombre (ej. 'Gavi')",
              style: TextStyle(color: Colors.white24, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPlayerTile(Player p) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFDEFF9A).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFDEFF9A).withOpacity(0.2)),
          ),
          child: Center(
            child: Text(
              p.position,
              style: const TextStyle(
                  color: Color(0xFFDEFF9A),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Text(
          p.name.toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          "ID: ${p.teamId} • VALOR: ${(p.marketValue / 1000000).toStringAsFixed(1)}M €",
          style: const TextStyle(color: Colors.white38, fontSize: 11),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFDEFF9A), size: 16),
        onTap: () {
          // CORRECCIÓN: Ahora pasamos tanto 'player' como 'dbService'
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayerDetailScreen(
                player: p,
                dbService: widget.dbService,
              ),
            ),
          );
        },
      ),
    );
  }
}