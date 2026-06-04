import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../core/game_session_service.dart';
import '../models/league_standing.dart';
import '../models/team.dart';

class LeagueTableScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const LeagueTableScreen({super.key, required this.dbService, required this.userTeam});

  @override
  State<LeagueTableScreen> createState() => _LeagueTableScreenState();
}

class _LeagueTableScreenState extends State<LeagueTableScreen> {
  Map<int, String> _teamNames = {};

  @override
  void initState() {
    super.initState();
    _loadTeamNames();
  }

  Future<void> _loadTeamNames() async {
    final teams = await widget.dbService.getAllTeams();
    if (!mounted) return;
    setState(() {
      _teamNames = {for (final t in teams) t.apiId: t.name};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text("CLASIFICACIÓN", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<LeagueStanding>>(
        stream: widget.dbService.isar.leagueStandings.where().watch(fireImmediately: true),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)));
          }

          final standings = List<LeagueStanding>.from(snap.data!)
            ..sort((a, b) {
              if (b.points != a.points) return b.points.compareTo(a.points);
              if (b.goalDifference != a.goalDifference) {
                return b.goalDifference.compareTo(a.goalDifference);
              }
              return b.goalsFor.compareTo(a.goalsFor);
            });

          return Column(
            children: [
              _headerRow(),
              Expanded(
                child: ListView.builder(
                  itemCount: standings.length,
                  itemBuilder: (_, i) {
                    final s = standings[i];
                    final name = _teamNames[s.teamApiId] ?? "Equipo ${s.teamApiId}";
                    return _dataRow(
                      pos: i + 1,
                      name: name,
                      standing: s,
                      isUser: s.teamApiId == widget.userTeam.apiId,
                    );
                  },
                ),
              ),
              FutureBuilder(
                future: GameSessionService(widget.dbService.isar).getSave(),
                builder: (context, saveSnap) {
                  final save = saveSnap.data;
                  if (save == null) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Próxima jornada: ${save.currentMatchday} / ${save.totalMatchdays}",
                      style: const TextStyle(color: Colors.white38, letterSpacing: 1),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _headerRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF0F172A),
      child: const Row(
        children: [
          SizedBox(width: 28, child: Text("#", style: TextStyle(color: Colors.white38, fontSize: 11))),
          Expanded(child: Text("EQUIPO", style: TextStyle(color: Colors.white38, fontSize: 11))),
          SizedBox(width: 24, child: Text("PJ", style: TextStyle(color: Colors.white38, fontSize: 11))),
          SizedBox(width: 36, child: Text("GF:GC", style: TextStyle(color: Colors.white38, fontSize: 10))),
          SizedBox(width: 28, child: Text("PT", style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _dataRow({
    required int pos,
    required String name,
    required LeagueStanding standing,
    required bool isUser,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: isUser ? const Color(0xFFDEFF9A).withValues(alpha: 0.08) : null,
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text("$pos", style: TextStyle(color: isUser ? const Color(0xFFDEFF9A) : Colors.white54, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(
              name.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isUser ? const Color(0xFFDEFF9A) : Colors.white,
                fontWeight: isUser ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(width: 24, child: Text("${standing.played}", style: const TextStyle(color: Colors.white54))),
          SizedBox(
            width: 36,
            child: Text("${standing.goalsFor}:${standing.goalsAgainst}", style: const TextStyle(color: Colors.white54, fontSize: 11)),
          ),
          SizedBox(width: 28, child: Text("${standing.points}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
