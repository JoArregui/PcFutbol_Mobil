import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../core/lineup_service.dart';
import '../core/tactics_service.dart';
import '../models/player_model.dart';
import '../models/team.dart';

class LineupScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const LineupScreen({super.key, required this.dbService, required this.userTeam});

  @override
  State<LineupScreen> createState() => _LineupScreenState();
}

class _LineupScreenState extends State<LineupScreen> {
  late final LineupService _lineup;
  List<Player> _squad = [];
  final Set<int> _selected = {};
  bool _loading = true;
  String _formation = '4-4-2';

  @override
  void initState() {
    super.initState();
    _lineup = LineupService(widget.dbService.isar);
    _load();
  }

  Future<void> _load() async {
    final squad = await widget.dbService.getPlayersByTeam(widget.userTeam.apiId, professionalsOnly: true);
    squad.sort((a, b) => b.average.compareTo(a.average));
    final lineup = await _lineup.getLineup();
    setState(() {
      _squad = squad;
      _formation = lineup.formation;
      _selected.clear();
      _selected.addAll(lineup.starterPlayerIds);
      _loading = false;
    });
  }

  Future<void> _save() async {
    if (_selected.length != LineupService.requiredStarters) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Debes seleccionar exactamente 11 jugadores.")),
      );
      return;
    }
    final gkCount = _squad.where((p) => _selected.contains(p.id) && p.position == 'GK').length;
    if (gkCount < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tu once debe incluir al menos un portero.")),
      );
      return;
    }
    await _lineup.saveLineup(_selected.toList(), formation: _formation);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Alineación guardada."), backgroundColor: Color(0xFFDEFF9A)),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text("ALINEACIÓN", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () async {
              await _lineup.autoPickBest11(widget.userTeam.apiId);
              await _load();
            },
            child: const Text("AUTO", style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TITULARES: ${_selected.length}/${LineupService.requiredStarters}",
                        style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                      const SizedBox(height: 8),
                      const Text("TÁCTICA", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        children: TacticsService.formations.map((f) {
                          final sel = _formation == f;
                          return ChoiceChip(
                            label: Text(f, style: TextStyle(color: sel ? Colors.black : Colors.white70, fontWeight: FontWeight.bold)),
                            selected: sel,
                            selectedColor: const Color(0xFFDEFF9A),
                            backgroundColor: const Color(0xFF0F172A),
                            onSelected: (_) => setState(() => _formation = f),
                          );
                        }).toList(),
                      ),
                      Text(
                        TacticsService.label(_formation),
                        style: const TextStyle(color: Colors.white24, fontSize: 10),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _squad.length,
                    itemBuilder: (_, i) {
                      final p = _squad[i];
                      final on = _selected.contains(p.id);
                      final unavailable = p.injuredDays > 0 || p.suspendedMatches > 0;
                      return ListTile(
                        onTap: unavailable
                            ? null
                            : () {
                          setState(() {
                            if (on) {
                              _selected.remove(p.id);
                            } else if (_selected.length < LineupService.requiredStarters) {
                              _selected.add(p.id);
                            }
                          });
                        },
                        leading: CircleAvatar(
                          backgroundColor: on ? const Color(0xFFDEFF9A) : const Color(0xFF0F172A),
                          child: Text(p.position, style: TextStyle(fontSize: 10, color: on ? Colors.black : Colors.white54, fontWeight: FontWeight.bold)),
                        ),
                        title: Text(
                          p.name,
                          style: TextStyle(color: unavailable ? Colors.white24 : (on ? const Color(0xFFDEFF9A) : Colors.white)),
                        ),
                        subtitle: unavailable
                            ? Text(
                                p.injuredDays > 0 ? 'Lesionado (${p.injuredDays}d)' : 'Sancionado (${p.suspendedMatches}p)',
                                style: const TextStyle(color: Colors.redAccent, fontSize: 10),
                              )
                            : null,
                        trailing: Text(p.average.toStringAsFixed(0), style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDEFF9A),
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    onPressed: _save,
                    child: const Text("GUARDAR ONCE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
    );
  }
}
