import 'package:flutter/material.dart';
import '../core/calendar_service.dart';
import '../core/database_service.dart';
import '../models/league_fixture.dart';
import '../models/team.dart';

class FullCalendarScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const FullCalendarScreen({
    super.key,
    required this.dbService,
    required this.userTeam,
  });

  @override
  State<FullCalendarScreen> createState() => _FullCalendarScreenState();
}

class _FullCalendarScreenState extends State<FullCalendarScreen> {
  late final CalendarService _calendar;
  List<LeagueFixture> _fixtures = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _calendar = CalendarService(widget.dbService.isar);
    _load();
  }

  Future<void> _load() async {
    final list = await _calendar.getFullUserCalendar(widget.userTeam.apiId);
    if (!mounted) return;
    setState(() {
      _fixtures = list;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text('CALENDARIO COMPLETO', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)))
          : _fixtures.isEmpty
              ? const Center(
                  child: Text('No hay partidos en el calendario.', style: TextStyle(color: Colors.white38)),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _fixtures.length,
                  itemBuilder: (_, i) => _fixtureTile(_fixtures[i]),
                ),
    );
  }

  Widget _fixtureTile(LeagueFixture f) {
    final isHome = f.homeTeamApiId == widget.userTeam.apiId;
    final rivalId = isHome ? f.awayTeamApiId : f.homeTeamApiId;
    final comp = f.competition == 'copa' ? 'COPA' : 'LIGA';
    final rivalFuture = widget.dbService.getAllTeams().then((teams) {
      for (final t in teams) {
        if (t.apiId == rivalId) return t;
      }
      return null;
    });

    return FutureBuilder<Team?>(
      future: rivalFuture,
      builder: (context, snap) {
        final rival = snap.data?.name ?? 'Rival';
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: f.competition == 'copa'
                  ? const Color(0xFFDEFF9A).withValues(alpha: 0.35)
                  : Colors.white10,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('J${f.matchday}', style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)),
                    Text(comp, style: const TextStyle(color: Colors.white38, fontSize: 10)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${isHome ? 'vs' : '@'} ${rival.toUpperCase()}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      isHome ? 'EN CASA · Día 7' : 'FUERA · Día 7',
                      style: const TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (f.played)
                Text(
                  '${f.homeGoals}-${f.awayGoals}',
                  style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 16),
                )
              else
                const Text('PEND.', style: TextStyle(color: Colors.white24, fontSize: 11)),
            ],
          ),
        );
      },
    );
  }
}

