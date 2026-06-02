import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/database_service.dart';
import '../core/league_service.dart';
import '../models/game_save.dart';
import '../models/team.dart';

class TrophyRoomScreen extends StatelessWidget {
  final DatabaseService dbService;
  final Team team;

  const TrophyRoomScreen({super.key, required this.dbService, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text('SALA DE TROFEOS', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<GameSave?>(
        stream: dbService.isar.gameSaves.watchObject(1, fireImmediately: true),
        builder: (context, saveSnap) {
          final save = saveSnap.data;
          final trophies = save?.trophies ?? [];

          return FutureBuilder(
            future: LeagueService(dbService.isar).getUserLeaguePosition(team.apiId),
            builder: (context, posSnap) {
              final pos = posSnap.data;

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFDEFF9A).withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        const Icon(FontAwesomeIcons.trophy, color: Color(0xFFDEFF9A), size: 48),
                        const SizedBox(height: 12),
                        Text(
                          team.name.toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                        if (save != null)
                          Text(
                            'Temporada ${save.seasonNumber}',
                            style: const TextStyle(color: Colors.white38, fontSize: 12),
                          ),
                        if (pos != null && save?.seasonFinished != true)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Posición actual: $posº',
                              style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'PALMARÉS',
                    style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 12),
                  if (trophies.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Aún no hay trofeos. Gana la liga o la Copa del Rey.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white38),
                      ),
                    )
                  else
                    ...trophies.map(
                      (t) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1e293b),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.emoji_events, color: Color(0xFFDEFF9A)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
