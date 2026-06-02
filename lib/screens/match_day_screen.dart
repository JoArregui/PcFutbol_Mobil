import 'dart:async';
import 'package:flutter/material.dart';
import '../core/calendar_service.dart';
import '../core/database_service.dart';
import '../core/game_session_service.dart';
import '../models/league_fixture.dart';
import '../core/lineup_service.dart';
import '../core/match_discipline_service.dart';
import '../core/match_engine.dart';
import '../models/match_event.dart';
import '../models/player_model.dart';
import '../models/team.dart';

class MatchDayScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;
  final Team opponent;
  final bool userIsHome;
  final LeagueFixture fixture;

  const MatchDayScreen({
    super.key,
    required this.dbService,
    required this.userTeam,
    required this.opponent,
    required this.userIsHome,
    required this.fixture,
  });

  @override
  State<MatchDayScreen> createState() => _MatchDayScreenState();
}

class _MatchDayScreenState extends State<MatchDayScreen> {
  final MatchEngine _engine = MatchEngine();
  final List<MatchEvent> _history = [];
  final List<MatchEvent> _fullTimeline = [];

  Stream<MatchEvent>? _matchStream;
  StreamSubscription<MatchEvent>? _subscription;

  int _homeScore = 0;
  int _awayScore = 0;
  int _currentMinute = 0;
  bool _matchStarted = false;
  bool _matchFinished = false;
  bool _loadingSquad = true;
  String _userFormation = '4-4-2';
  double _medicoLevel = 1;
  String _matchMode = 'resumen';

  Team get _home => widget.userIsHome ? widget.userTeam : widget.opponent;
  Team get _away => widget.userIsHome ? widget.opponent : widget.userTeam;

  int get _userScore => widget.userIsHome ? _homeScore : _awayScore;
  int get _opponentScore => widget.userIsHome ? _awayScore : _homeScore;

  @override
  void initState() {
    super.initState();
    _prepareMatch();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _prepareMatch() async {
    setState(() => _loadingSquad = true);

    final save = await GameSessionService(widget.dbService.isar).getSave();
    _matchMode = save?.matchMode ?? 'resumen';
    _medicoLevel = (save?.staffMedicoLevel ?? 1).toDouble();

    final lineup = LineupService(widget.dbService.isar);
    _userFormation = await lineup.getFormation();

    var homePlayers = await widget.dbService.getPlayersByTeam(_home.apiId, professionalsOnly: true);
    var awayPlayers = await widget.dbService.getPlayersByTeam(_away.apiId, professionalsOnly: true);

    final starters = await lineup.getStarters(widget.userTeam.apiId);
    if (starters.isNotEmpty) {
      if (_home.apiId == widget.userTeam.apiId) {
        homePlayers = starters;
      } else if (_away.apiId == widget.userTeam.apiId) {
        awayPlayers = starters;
      }
    }

    if (homePlayers.isEmpty) homePlayers = _placeholderSquad();
    if (awayPlayers.isEmpty) awayPlayers = _placeholderSquad();

    final timeline = _engine.simulateMatch(
      home: _home,
      away: _away,
      homePlayers: homePlayers,
      awayPlayers: awayPlayers,
      homeFormation: _home.apiId == widget.userTeam.apiId ? _userFormation : '4-4-2',
      awayFormation: _away.apiId == widget.userTeam.apiId ? _userFormation : '4-3-3',
      medicoLevel: _medicoLevel,
    );
    _fullTimeline.addAll(timeline);
    final last = timeline.lastWhere((e) => e.isFullTime, orElse: () => timeline.last);
    _homeScore = last.homeScore ?? 0;
    _awayScore = last.awayScore ?? 0;

    if (!mounted) return;
    setState(() {
      _loadingSquad = false;
      if (_matchMode == 'resultado') {
        _matchStarted = true;
        _matchFinished = false;
      } else {
        _matchStream = _engine.playMatch(
          home: _home,
          away: _away,
          homePlayers: homePlayers,
          awayPlayers: awayPlayers,
          homeFormation: _home.apiId == widget.userTeam.apiId ? _userFormation : '4-4-2',
          awayFormation: '4-3-3',
          medicoLevel: _medicoLevel,
        );
      }
    });

    if (_matchMode == 'resultado') {
      WidgetsBinding.instance.addPostFrameCallback((_) => _finishQuickResult());
    }
  }

  List<Player> _placeholderSquad() {
    return List.generate(
      11,
      (i) => Player()
        ..name = "Jugador ${i + 1}"
        ..position = i == 0 ? 'GK' : (i < 5 ? 'DEF' : (i < 9 ? 'MID' : 'FWD'))
        ..age = 25
        ..stats = [70, 70, 70, 70, 70]
        ..teamApiId = 0
        ..teamId = ''
        ..marketValue = 1
        ..salary = 1
        ..personality = Personality.professional,
    );
  }

  Future<void> _finishQuickResult() async {
    await _onFullTime();
  }

  void _startMatch() {
    if (_matchStream == null || _matchStarted) return;

    setState(() {
      _matchStarted = true;
      _history.clear();
      _homeScore = 0;
      _awayScore = 0;
      _currentMinute = 0;
    });

    _subscription?.cancel();
    _subscription = _matchStream!.listen(
      _onMatchEvent,
      onDone: () {
        if (!_matchFinished && mounted) {
          _onMatchEvent(MatchEvent(
            minute: 90,
            type: EventType.comment,
            description: "FINAL — ${_home.name} $_homeScore - $_awayScore ${_away.name}",
            homeScore: _homeScore,
            awayScore: _awayScore,
            isFullTime: true,
          ));
        }
      },
    );
  }

  void _onMatchEvent(MatchEvent e) {
    if (!mounted || _matchFinished) return;

    setState(() {
      _currentMinute = e.minute;
      _homeScore = e.homeScore ?? _homeScore;
      _awayScore = e.awayScore ?? _awayScore;

      if (e.description.isNotEmpty) {
        _history.insert(0, e);
      }
    });

    if (e.isFullTime) {
      _onFullTime();
    }
  }

  Future<void> _onFullTime() async {
    if (_matchFinished) return;
    _matchFinished = true;
    await _subscription?.cancel();

    await MatchDisciplineService(widget.dbService.isar)
        .applyFromEvents(_fullTimeline, widget.userTeam.apiId);

    await CalendarService(widget.dbService.isar).recordUserMatch(
      fixture: widget.fixture,
      userTeamApiId: widget.userTeam.apiId,
      userGoals: _userScore,
      opponentGoals: _opponentScore,
      userWasHome: widget.userIsHome,
      userTeam: widget.userTeam,
    );

    if (!mounted) return;

    final homeLabel = widget.userIsHome ? widget.userTeam.name : widget.opponent.name;
    final awayLabel = widget.userIsHome ? widget.opponent.name : widget.userTeam.name;
    final comp = widget.fixture.competition == 'copa' ? 'COPA DEL REY' : 'LIGA';

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        title: Text("FINAL — $comp", style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.w900)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$homeLabel $_homeScore - $_awayScore $awayLabel",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Tu resultado: $_userScore - $_opponentScore",
              style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(_resultLine(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context, true);
            },
            child: const Text("VOLVER AL DESPACHO", style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  String _resultLine() {
    if (_userScore > _opponentScore) return "Victoria. La afición lo celebra.";
    if (_userScore == _opponentScore) {
      return widget.fixture.competition == 'copa'
          ? "Empate. Tanda de penaltis simulada en la copa."
          : "Empate. Un punto en la clasificación.";
    }
    return "Derrota. Hay que mejorar en el entrenamiento.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: Text(
          widget.fixture.competition == 'copa' ? 'COPA DEL REY' : 'JORNADA DE LIGA',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildScoreboard(),
          if (_loadingSquad)
            const Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(color: Color(0xFFDEFF9A)))
          else if (!_matchStarted && _matchMode != 'resultado')
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Formación: $_userFormation',
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDEFF9A),
                      minimumSize: const Size(double.infinity, 52),
                    ),
                    onPressed: _matchStream == null ? null : _startMatch,
                    child: const Text("¡A JUGAR! (RESUMEN)", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ),
          Expanded(child: _matchStarted ? _buildTicker() : _buildPreMatch()),
        ],
      ),
    );
  }

  Widget _buildPreMatch() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_home.name, style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("vs", style: TextStyle(color: Colors.white24)),
            Text(_away.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              widget.userIsHome ? "En casa · $_userFormation" : "Fuera · $_userFormation",
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
            if (_matchMode == 'resultado')
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Modo RESULTADO (PC Fútbol 7)', style: TextStyle(color: Color(0xFFDEFF9A), fontSize: 11)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreboard() {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 20, left: 12, right: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Text(
            _matchStarted ? "$_currentMinute'" : "PREVIA",
            style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _teamCol(_home.name, _homeScore, widget.userIsHome)),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text("$_homeScore - $_awayScore", style: const TextStyle(color: Colors.white38, fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: _teamCol(_away.name, _awayScore, !widget.userIsHome)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _teamCol(String name, int score, bool highlight) {
    return Column(
      children: [
        Text(
          name.toUpperCase(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: highlight ? const Color(0xFFDEFF9A) : Colors.white54,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text("$score", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
      ],
    );
  }

  Widget _buildTicker() {
    if (_matchMode == 'resultado' && _matchFinished) {
      return const Center(child: Text('Partido registrado.', style: TextStyle(color: Colors.white38)));
    }
    if (_history.isEmpty) {
      return const Center(child: Text("El partido está en marcha...", style: TextStyle(color: Colors.white38)));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: _history.length,
      itemBuilder: (_, i) {
        final e = _history[i];
        final isGoal = e.type == EventType.goal;
        final isCard = e.type == EventType.card;
        final isInjury = e.type == EventType.injury;
        final isBreak = e.minute == 45 || e.isFullTime;

        Color? border;
        if (isGoal) border = const Color(0xFFDEFF9A).withValues(alpha: 0.35);
        if (isCard) border = Colors.amber.withValues(alpha: 0.35);
        if (isInjury) border = Colors.red.withValues(alpha: 0.35);

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isGoal
                ? const Color(0xFFDEFF9A).withValues(alpha: 0.1)
                : isBreak
                    ? const Color(0xFF1e293b)
                    : Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: border ?? Colors.transparent),
          ),
          child: Text(
            "${e.minute}'  ${e.description}",
            style: TextStyle(
              color: isGoal || isCard || isInjury ? const Color(0xFFDEFF9A) : Colors.white70,
              fontWeight: isGoal || isBreak ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }
}
