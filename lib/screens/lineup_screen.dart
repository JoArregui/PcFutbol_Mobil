import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../core/lineup_service.dart';
import '../core/tactics_service.dart';
import '../models/player_model.dart';
import '../models/team.dart';

class LineupScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;
  final bool fromMatchDay;

  const LineupScreen({
    super.key,
    required this.dbService,
    required this.userTeam,
    this.fromMatchDay = false,
  });

  @override
  State<LineupScreen> createState() => _LineupScreenState();
}

class _LineupScreenState extends State<LineupScreen> {
  late final LineupService _lineup;
  List<Player> _squad = [];
  final Set<int> _starters = {};
  final Set<int> _bench = {};
  bool _loading = true;
  bool _pickingStarters = true;
  String _formation = '4-4-2';

  @override
  void initState() {
    super.initState();
    _lineup = LineupService(widget.dbService.isar);
    _load(restoreSaved: true);
  }

  int _positionPriority(String pos) {
    switch (pos.toUpperCase()) {
      case 'GK':
        return 1;
      case 'DEF':
        return 2;
      case 'MID':
        return 3;
      case 'FWD':
        return 4;
      default:
        return 5;
    }
  }

  Future<void> _load({required bool restoreSaved}) async {
    final squad = await widget.dbService
        .getPlayersByTeam(widget.userTeam.apiId, professionalsOnly: true);

    squad.sort((a, b) {
      final posCompare =
          _positionPriority(a.position).compareTo(_positionPriority(b.position));
      if (posCompare != 0) return posCompare;
      return b.average.compareTo(a.average);
    });

    final lineup = await _lineup.getLineup();

    setState(() {
      _squad = squad;
      _formation = lineup.formation;
      _loading = false;
      _starters.clear();
      _bench.clear();
      if (restoreSaved) {
        _starters.addAll(lineup.starterPlayerIds);
        _bench.addAll(lineup.benchPlayerIds);
      }
    });
  }

  void _togglePlayer(Player p) {
    if (p.injuredDays > 0 || p.suspendedMatches > 0) return;

    setState(() {
      if (_starters.contains(p.id)) {
        _starters.remove(p.id);
        return;
      }
      if (_bench.contains(p.id)) {
        _bench.remove(p.id);
        return;
      }

      if (_pickingStarters) {
        if (_starters.length < LineupService.requiredStarters) {
          _starters.add(p.id);
        }
      } else if (_bench.length < LineupService.requiredBench) {
        _bench.add(p.id);
      }
    });
  }

  Future<void> _save() async {
    if (_starters.length != LineupService.requiredStarters) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Selecciona ${LineupService.requiredStarters} titulares (ahora: ${_starters.length}).',
          ),
        ),
      );
      return;
    }

    if (_bench.length != LineupService.requiredBench) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Convoca ${LineupService.requiredBench} suplentes (ahora: ${_bench.length}).',
          ),
        ),
      );
      return;
    }

    final gkCount = _squad
        .where((p) => _starters.contains(p.id) && p.position == 'GK')
        .length;
    if (gkCount < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El once titular debe incluir un portero.')),
      );
      return;
    }

    await _lineup.saveLineup(
      starterIds: _starters.toList(),
      benchIds: _bench.toList(),
      formation: _formation,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Convocatoria guardada: 11 titulares + 7 suplentes.'),
        backgroundColor: Color(0xFFDEFF9A),
      ),
    );

    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }

  Color? _playerColor(int id) {
    if (_starters.contains(id)) return const Color(0xFFDEFF9A);
    if (_bench.contains(id)) return Colors.amber;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text(
          'ALINEACIÓN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          TextButton(
            onPressed: () async {
              await _lineup.autoPickMatchdaySquad(widget.userTeam.apiId);
              await _load(restoreSaved: true);
            },
            child: const Text(
              'AUTO',
              style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold),
            ),
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
                      Row(
                        children: [
                          Expanded(
                            child: _roleChip(
                              label: 'TITULARES ${_starters.length}/${LineupService.requiredStarters}',
                              active: _pickingStarters,
                              color: const Color(0xFFDEFF9A),
                              onTap: () => setState(() => _pickingStarters = true),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _roleChip(
                              label: 'SUPLENTES ${_bench.length}/${LineupService.requiredBench}',
                              active: !_pickingStarters,
                              color: Colors.amber,
                              onTap: () => setState(() => _pickingStarters = false),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _pickingStarters
                            ? 'Toca jugadores para el 11 inicial. Toca de nuevo para quitar.'
                            : 'Toca jugadores para los 7 convocados al banquillo.',
                        style: const TextStyle(color: Colors.white38, fontSize: 10),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'TÁCTICA',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        children: TacticsService.formations.map((f) {
                          final sel = _formation == f;
                          return ChoiceChip(
                            label: Text(
                              f,
                              style: TextStyle(
                                color: sel ? Colors.black : Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            selected: sel,
                            selectedColor: const Color(0xFFDEFF9A),
                            backgroundColor: const Color(0xFF0F172A),
                            onSelected: (_) => setState(() => _formation = f),
                          );
                        }).toList(),
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
                      final roleColor = _playerColor(p.id);
                      final unavailable =
                          p.injuredDays > 0 || p.suspendedMatches > 0;

                      return ListTile(
                        onTap: unavailable ? null : () => _togglePlayer(p),
                        leading: CircleAvatar(
                          backgroundColor: roleColor ?? const Color(0xFF0F172A),
                          child: Text(
                            p.position,
                            style: TextStyle(
                              fontSize: 10,
                              color: roleColor != null ? Colors.black : Colors.white54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          p.name.toUpperCase(),
                          style: TextStyle(
                            color: unavailable
                                ? Colors.white24
                                : (roleColor ?? Colors.white),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: unavailable
                            ? Text(
                                p.injuredDays > 0
                                    ? 'Lesionado (${p.injuredDays}d)'
                                    : 'Sancionado (${p.suspendedMatches}p)',
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 10,
                                ),
                              )
                            : Text(
                                _starters.contains(p.id)
                                    ? 'Titular'
                                    : _bench.contains(p.id)
                                        ? 'Suplente'
                                        : 'Sin convocar',
                                style: const TextStyle(color: Colors.white24, fontSize: 10),
                              ),
                        trailing: Text(
                          p.average.toStringAsFixed(0),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _save,
                    child: const Text(
                      'GUARDAR CONVOCATORIA (11+7)',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _roleChip({
    required String label,
    required bool active,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active ? color.withValues(alpha: 0.15) : const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: active ? color : Colors.white12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: active ? color : Colors.white38,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
