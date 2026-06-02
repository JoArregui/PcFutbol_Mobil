import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/database_service.dart';
import '../core/youth_service.dart';
import '../models/player_model.dart';
import '../models/team.dart';

class YouthAcademyScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team team;

  const YouthAcademyScreen({super.key, required this.dbService, required this.team});

  @override
  State<YouthAcademyScreen> createState() => _YouthAcademyScreenState();
}

class _YouthAcademyScreenState extends State<YouthAcademyScreen> {
  late final YouthService _youth;
  List<Player> _players = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _youth = YouthService(widget.dbService.isar);
    _load();
  }

  Future<void> _load() async {
    final list = await _youth.getYouthSquad(widget.team.apiId);
    list.sort((a, b) => b.average.compareTo(a.average));
    if (mounted) {
      setState(() {
        _players = list;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text('CUIDAD DEPORTIVA / CANTERA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFDEFF9A),
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            await _youth.scoutYouth(widget.team.apiId);
                            await _load();
                          },
                          icon: const Icon(FontAwesomeIcons.binoculars, size: 16),
                          label: const Text('OJEADOR', style: TextStyle(fontWeight: FontWeight.w900)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _players.isEmpty
                      ? const Center(
                          child: Text(
                            'Sin promesas en cantera.\nPulsa OJEADOR para traer juveniles.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white38),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _players.length,
                          itemBuilder: (_, i) {
                            final p = _players[i];
                            return Card(
                              color: const Color(0xFF0F172A),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text(p.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                  '${p.position} · ${p.age} años · Media ${p.average.toStringAsFixed(0)}',
                                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                                ),
                                trailing: TextButton(
                                  onPressed: () async {
                                    final msg = await _youth.promoteToFirstTeam(p, widget.team.apiId);
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                                    await _load();
                                  },
                                  child: const Text('PROMOVER', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
