import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import 'player_detail_screen.dart';

class PlayerSearchScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const PlayerSearchScreen({super.key, required this.dbService, required this.userTeam});

  @override
  State<PlayerSearchScreen> createState() => _PlayerSearchScreenState();
}

class _PlayerSearchScreenState extends State<PlayerSearchScreen> {
  List<Player> _results = [];
  final TextEditingController _controller = TextEditingController();
  String _position = 'ALL';
  bool _onlyYoungBets = false;
  String _sort = 'value_desc';

  @override
  void initState() {
    super.initState();
    _onSearch('');
  }

  void _onSearch(String query) async {
    final all = await widget.dbService.getAllPlayers();
    final q = query.trim().toLowerCase();

    final results = all.where((p) {
      if (p.teamApiId == widget.userTeam.apiId) return false;
      if (q.isNotEmpty && !p.name.toLowerCase().contains(q)) return false;
      if (_position != 'ALL' && p.position != _position) return false;
      if (_onlyYoungBets && !(p.age <= 20 && p.potential >= 86)) return false;
      return true;
    }).toList();

    results.sort((a, b) {
      switch (_sort) {
        case 'avg_desc':
          return b.average.compareTo(a.average);
        case 'age_asc':
          return a.age.compareTo(b.age);
        case 'potential_desc':
          return b.potential.compareTo(a.potential);
        case 'value_asc':
          return a.marketValue.compareTo(b.marketValue);
        case 'value_desc':
        default:
          return b.marketValue.compareTo(a.marketValue);
      }
    });

    setState(() => _results = results.take(60).toList());
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
          : Column(
              children: [
                _filtersBar(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: _results.length,
                    itemBuilder: (context, index) => _buildPlayerTile(_results[index]),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _filtersBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          _chip('Todos', 'ALL'),
          _chip('POR', 'GK'),
          _chip('DEF', 'DEF'),
          _chip('MED', 'MID'),
          _chip('DEL', 'FWD'),
          FilterChip(
            selected: _onlyYoungBets,
            label: const Text('Apuestas de futuro'),
            onSelected: (v) {
              setState(() => _onlyYoungBets = v);
              _onSearch(_controller.text);
            },
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              _sort = v;
              _onSearch(_controller.text);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'value_desc', child: Text('Valor: mayor')),
              PopupMenuItem(value: 'value_asc', child: Text('Valor: menor')),
              PopupMenuItem(value: 'avg_desc', child: Text('Media: mayor')),
              PopupMenuItem(value: 'potential_desc', child: Text('Potencial: mayor')),
              PopupMenuItem(value: 'age_asc', child: Text('Edad: menor')),
            ],
            child: const Chip(label: Text('Ordenar')),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, String value) {
    return ChoiceChip(
      selected: _position == value,
      label: Text(label),
      onSelected: (_) {
        setState(() => _position = value);
        _onSearch(_controller.text);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 60, color: Colors.white.withOpacity(0.05)),
          const SizedBox(height: 15),
          const Text("Escribe un nombre o usa filtros",
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
          "${p.age} años • MED ${p.average.toStringAsFixed(0)} • POT ${p.potential} • ${(p.marketValue / 1000000).toStringAsFixed(1)}M €",
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
                userTeam: widget.userTeam,
              ),
            ),
          );
        },
      ),
    );
  }
}