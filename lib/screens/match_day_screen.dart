import 'package:flutter/material.dart';
import '../core/match_engine.dart';
import '../models/match_event.dart';

class MatchDayScreen extends StatefulWidget {
  const MatchDayScreen({super.key});

  @override
  State<MatchDayScreen> createState() => _MatchDayScreenState();
}

class _MatchDayScreenState extends State<MatchDayScreen> {
  final MatchEngine _engine = MatchEngine();
  final List<MatchEvent> _history = [];
  int _homeScore = 0;
  int _awayScore = 0;
  int _currentMinute = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildScoreboard(),
          Expanded(child: _buildLiveTicker()),
        ],
      ),
    );
  }

  Widget _buildScoreboard() {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 30),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Text("$_currentMinute'", style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _teamInfo("LOCAL", _homeScore),
              const Text("-", style: TextStyle(fontSize: 40, color: Colors.white24)),
              _teamInfo("VISITANTE", _awayScore),
            ],
          ),
        ],
      ),
    );
  }

  Widget _teamInfo(String name, int score) {
    return Column(
      children: [
        Text(name, style: const TextStyle(color: Colors.white54, letterSpacing: 2)),
        Text("$score", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildLiveTicker() {
    return StreamBuilder<MatchEvent>(
      stream: _engine.playMatch(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final event = snapshot.data!;
          if (event.description.isNotEmpty && (_history.isEmpty || _history.first.description != event.description)) {
             _history.insert(0, event);
             if (event.type == EventType.goal) {
               event.isHomeTeam ? _homeScore++ : _awayScore++;
             }
          }
          _currentMinute = event.minute;
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: _history.length,
          itemBuilder: (context, index) {
            final e = _history[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: e.type == EventType.goal ? Colors.green.withOpacity(0.1) : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: e.type == EventType.goal ? const Color(0xFFDEFF9A) : Colors.transparent),
              ),
              child: Text("${e.minute}' - ${e.description}", style: TextStyle(color: e.type == EventType.goal ? const Color(0xFFDEFF9A) : Colors.white70)),
            );
          },
        );
      },
    );
  }
}