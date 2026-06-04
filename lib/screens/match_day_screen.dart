import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import '../widgets/match_substitution_sheet.dart';

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

  StreamSubscription<MatchEvent>? _subscription;

  List<Player> _userOnField = [];
  List<Player> _userBench = [];
  List<Player> _opponentOnField = [];

  int _homeScore = 0;
  int _awayScore = 0;
  int _currentMinute = 0;
  int _substitutionsUsed = 0;

  bool _matchStarted = false;
  bool _matchFinished = false;
  bool _loadingSquad = true;
  bool _isPaused = false;
  bool _halftimeBreak = false;
  bool _firstHalfDone = false;
  bool _awaitingSecondHalf = false;

  String _userFormation = '4-4-2';
  double _medicoLevel = 1;
  String _matchMode = 'resumen';

  static const int _maxSubstitutions = 5;

  Team get _home => widget.userIsHome ? widget.userTeam : widget.opponent;
  Team get _away => widget.userIsHome ? widget.opponent : widget.userTeam;

  int get _userScore => widget.userIsHome ? _homeScore : _awayScore;
  int get _opponentScore => widget.userIsHome ? _awayScore : _homeScore;

  List<Player> get _homePlayers =>
      _home.apiId == widget.userTeam.apiId ? _userOnField : _opponentOnField;

  List<Player> get _awayPlayers =>
      _away.apiId == widget.userTeam.apiId ? _userOnField : _opponentOnField;

  String get _homeFormation =>
      _home.apiId == widget.userTeam.apiId ? _userFormation : '4-3-3';

  String get _awayFormation =>
      _away.apiId == widget.userTeam.apiId ? _userFormation : '4-3-3';

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

    final starters = await lineup.getStarters(widget.userTeam.apiId);
    final bench = await lineup.getBench(widget.userTeam.apiId);
    _userOnField = List<Player>.from(starters);
    _userBench = List<Player>.from(bench);

    var opponentPlayers =
        await widget.dbService.getPlayersByTeam(widget.opponent.apiId, professionalsOnly: true);
    opponentPlayers.sort((a, b) => b.average.compareTo(a.average));
    _opponentOnField = opponentPlayers.take(11).toList();
    if (_opponentOnField.isEmpty) _opponentOnField = _placeholderSquad();

    if (_userOnField.isEmpty) _userOnField = _placeholderSquad();

    if (_matchMode == 'resultado') {
      final timeline = _engine.simulateMatch(
        home: _home,
        away: _away,
        homePlayers: _homePlayers,
        awayPlayers: _awayPlayers,
        homeFormation: _homeFormation,
        awayFormation: _awayFormation,
        medicoLevel: _medicoLevel,
      );
      _fullTimeline.addAll(timeline);
      final last = timeline.lastWhere((e) => e.isFullTime, orElse: () => timeline.last);
      _homeScore = last.homeScore ?? 0;
      _awayScore = last.awayScore ?? 0;
    }

    if (!mounted) return;

    setState(() {
      _loadingSquad = false;
      if (_matchMode == 'resultado') {
        _matchStarted = true;
        _matchFinished = false;
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
    if (_matchStarted || _matchMode == 'resultado') return;
    setState(() {
      _matchStarted = true;
      _isPaused = false;
      _history.clear();
      _fullTimeline.clear();
      _homeScore = 0;
      _awayScore = 0;
      _currentMinute = 0;
      _firstHalfDone = false;
      _halftimeBreak = false;
      _awaitingSecondHalf = false;
      _substitutionsUsed = 0;
    });
    _playFirstHalf();
  }

  void _playFirstHalf() {
    _subscription?.cancel();
    final stream = _engine.playPeriod(
      home: _home,
      away: _away,
      homePlayers: _homePlayers,
      awayPlayers: _awayPlayers,
      homeFormation: _homeFormation,
      awayFormation: _awayFormation,
      medicoLevel: _medicoLevel,
      startMinute: 1,
      endMinute: 45,
      initialHomeScore: 0,
      initialAwayScore: 0,
      kickoffMessage: "¡Arranca el partido! ${_home.name} recibe a ${_away.name}.",
    );

    _subscription = stream.listen(
      _onMatchEvent,
      onDone: () {
        if (!_firstHalfDone && mounted && !_matchFinished) {
          _onHalftimeReached();
        }
      },
    );
  }

  void _playSecondHalf() {
    _subscription?.cancel();
    setState(() {
      _awaitingSecondHalf = false;
      _halftimeBreak = false;
      _isPaused = false;
    });

    final stream = _engine.playPeriod(
      home: _home,
      away: _away,
      homePlayers: _homePlayers,
      awayPlayers: _awayPlayers,
      homeFormation: _homeFormation,
      awayFormation: _awayFormation,
      medicoLevel: _medicoLevel,
      startMinute: 46,
      endMinute: 90,
      initialHomeScore: _homeScore,
      initialAwayScore: _awayScore,
      kickoffMessage: "¡Comienza la 2ª parte con formación $_userFormation!",
    );

    _subscription = stream.listen(
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

  void _onHalftimeReached() {
    if (_firstHalfDone || _matchFinished) return;
    _subscription?.cancel();
    setState(() {
      _firstHalfDone = true;
      _halftimeBreak = true;
      _isPaused = true;
      _awaitingSecondHalf = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _openSubstitutionMenu(isHalftime: true);
    });
  }

  void _togglePause() {
    if (_matchFinished || _awaitingSecondHalf) return;
    if (_isPaused) {
      setState(() => _isPaused = false);
      _subscription?.resume();
    } else {
      _subscription?.pause();
      setState(() => _isPaused = true);
      _openSubstitutionMenu(isHalftime: false);
    }
  }

  Future<void> _openSubstitutionMenu({required bool isHalftime}) async {
    final result = await showModalBottomSheet<MatchSubstitutionResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => MatchSubstitutionSheet(
        onField: _userOnField,
        bench: _userBench,
        formation: _userFormation,
        substitutionsUsed: _substitutionsUsed,
        maxSubstitutions: _maxSubstitutions,
        isHalftime: isHalftime,
        resumeLabel: isHalftime ? 'COMENZAR 2ª PARTE' : 'REANUDAR PARTIDO',
      ),
    );

    if (!mounted || result == null) {
      if (isHalftime && _awaitingSecondHalf) {
        setState(() => _isPaused = true);
      }
      return;
    }

    setState(() {
      _userOnField = List<Player>.from(result.onField);
      _userBench = List<Player>.from(result.bench);
      _userFormation = result.formation;
      _substitutionsUsed = result.substitutionsUsed;
      _isPaused = false;
    });

    await LineupService(widget.dbService.isar).saveFormation(_userFormation);

    if (isHalftime && _awaitingSecondHalf) {
      _playSecondHalf();
    } else if (!_awaitingSecondHalf) {
      _subscription?.resume();
    }
  }

  void _onMatchEvent(MatchEvent e) {
    if (!mounted || _matchFinished) return;

    _fullTimeline.add(e);

    setState(() {
      _currentMinute = e.minute;
      _homeScore = e.homeScore ?? _homeScore;
      _awayScore = e.awayScore ?? _awayScore;
      if (e.description.isNotEmpty) {
        _history.insert(0, e);
      }
    });

    if (e.isHalftime) {
      _onHalftimeReached();
      return;
    }

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
        title: Text(
          "FINAL — $comp",
          style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.w900),
        ),
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
            child: const Text(
              "VOLVER AL DESPACHO",
              style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold),
            ),
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
        actions: [
          if (_matchStarted && !_matchFinished && _matchMode != 'resultado' && !_awaitingSecondHalf)
            IconButton(
              icon: Icon(
                _isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                color: const Color(0xFFDEFF9A),
                size: 28,
              ),
              onPressed: _togglePause,
            ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _buildScoreboard(),
              if (_loadingSquad)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(color: Color(0xFFDEFF9A)),
                )
              else if (!_matchStarted && _matchMode != 'resultado')
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Convocatoria: 11 titulares + ${_userBench.length} suplentes · $_userFormation',
                        style: const TextStyle(color: Colors.white38, fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDEFF9A),
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: _startMatch,
                        icon: const Icon(Icons.play_arrow_rounded, color: Colors.black),
                        label: const Text(
                          "¡A JUGAR! (RESUMEN)",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                )
              else if (_awaitingSecondHalf)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'DESCANSO — Ajusta cambios y táctica',
                        style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDEFF9A),
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        onPressed: () => _openSubstitutionMenu(isHalftime: true),
                        child: const Text(
                          'ÁREA TÉCNICA',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(child: _matchStarted ? _buildTicker() : _buildPreMatch()),
            ],
          ),
          if (_matchStarted && !_matchFinished && _isPaused && !_awaitingSecondHalf)
            Positioned(
              bottom: 24,
              left: 20,
              right: 20,
              child: FloatingActionButton.extended(
                backgroundColor: const Color(0xFF1E293B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFDEFF9A), width: 1),
                ),
                onPressed: () => _openSubstitutionMenu(isHalftime: false),
                icon: const Icon(FontAwesomeIcons.userGear, size: 16, color: Color(0xFFDEFF9A)),
                label: const Text(
                  "REALIZAR CAMBIOS / TÁCTICA",
                  style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
              ),
            ),
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
              widget.userIsHome
                  ? "En casa · $_userFormation · ${_userBench.length} suplentes"
                  : "Fuera · $_userFormation · ${_userBench.length} suplentes",
              style: const TextStyle(color: Colors.white38, fontSize: 12),
              textAlign: TextAlign.center,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isPaused && !_matchFinished)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    _halftimeBreak ? Icons.free_breakfast_rounded : Icons.pause_circle_filled_rounded,
                    color: _halftimeBreak ? Colors.amber : Colors.amber,
                    size: 16,
                  ),
                ),
              Text(
                _awaitingSecondHalf
                    ? "DESCANSO"
                    : (_matchStarted ? "$_currentMinute'" : "PREVIA"),
                style: TextStyle(
                  color: _isPaused || _awaitingSecondHalf ? Colors.amber : const Color(0xFFDEFF9A),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _teamCol(_home.name, _homeScore, widget.userIsHome)),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "$_homeScore - $_awayScore",
                  style: const TextStyle(color: Colors.white38, fontSize: 14, fontWeight: FontWeight.bold),
                ),
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
      return Center(
        child: Text(
          _awaitingSecondHalf ? "Descanso. Prepara la 2ª parte..." : "El partido está en marcha...",
          style: const TextStyle(color: Colors.white38),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(left: 14, right: 14, top: 14, bottom: _isPaused && !_awaitingSecondHalf ? 85 : 14),
      itemCount: _history.length,
      itemBuilder: (_, i) {
        final e = _history[i];
        final isGoal = e.type == EventType.goal;
        final isCard = e.type == EventType.card;
        final isInjury = e.type == EventType.injury;
        final isBreak = e.isHalftime || e.isFullTime;

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
                    ? const Color(0xFF1E293B)
                    : Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: border ?? Colors.transparent),
          ),
          child: Text(
            "${e.minute}'   ${e.description}",
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
