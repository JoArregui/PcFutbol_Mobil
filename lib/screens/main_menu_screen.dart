import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:isar/isar.dart';
import '../core/calendar_service.dart';
import '../core/database_service.dart';
import '../core/game_session_service.dart';
import '../core/lineup_service.dart';
import '../core/message_service.dart';
import '../models/game_save.dart';
import '../models/league_fixture.dart';
import '../models/league_standing.dart';
import '../models/team.dart';
import 'club_management_screen.dart';
import 'editor_screen.dart';
import 'finance_screen.dart';
import 'full_calendar_screen.dart';
import 'international_scout_screen.dart';
import 'league_table_screen.dart';
import 'lineup_screen.dart';
import 'match_day_screen.dart';
import 'player_search_screen.dart';
import 'secretary_screen.dart';
import 'squad_screen.dart';
import 'stadium_screen.dart';
import 'staff_screen.dart';
import 'training_screen.dart';
import 'transfer_offers_screen.dart';

class MainMenuScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const MainMenuScreen({super.key, required this.dbService, required this.userTeam});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> with TickerProviderStateMixin {
  late final GameSessionService _session;
  int _unread = 0;

  // Controladores de animación para el calendario interactivo
  bool _isAdvancingDay = false;
  String _animatingDayLabel = "";
  late AnimationController _calendarController;
  late Animation<double> _flipAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _session = GameSessionService(widget.dbService.isar);
    _refreshUnread();

    // Configuración de la animación del paso de hoja
    _calendarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _flipAnimation = Tween<double>(begin: 0.0, end: -0.5).animate(
      CurvedAnimation(parent: _calendarController, curve: Curves.easeInBack),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _calendarController, curve: Curves.easeInBack),
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Future<void> _refreshUnread() async {
    final n = await MessageService(widget.dbService.isar).unreadCount();
    if (mounted) setState(() => _unread = n);
  }

  Future<void> _handleAdvanceDay(GameSave? save) async {
    if (_isAdvancingDay || save == null) return;

    final currentDay = save.currentDay;
    final currentMatchday = save.currentMatchday;

    setState(() {
      _isAdvancingDay = true;
      _animatingDayLabel = "DÍA $currentDay\nJORNADA $currentMatchday";
    });

    // Lanzamos la animación del desprendimiento de la hoja de calendario
    await _calendarController.forward();

    // Ejecutamos el procesamiento del backend.
    final calendarService = CalendarService(widget.dbService.isar);
    await calendarService.advanceDay(widget.userTeam.apiId);

    // Tras pasar el día, verificamos si estábamos en Domingo (Día 7) y ya se jugó el partido.
    if (currentDay == 7) {
      final pending = await calendarService.getUserPendingFixtures(widget.userTeam.apiId);
      if (pending.isEmpty) {
        await _session.checkAndAdvanceMatchday(widget.userTeam);
      }
    }

    if (!mounted) return;

    setState(() {
      _isAdvancingDay = false;
      _calendarController.reset();
    });
    
    _refreshUnread();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: StreamBuilder<GameSave?>(
        stream: widget.dbService.isar.gameSaves.watchObject(1, fireImmediately: true),
        builder: (context, saveSnap) {
          final save = saveSnap.data;
          return Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.05,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1574629810360-7efbbe195018?q=80&w=2000',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      _buildHeader(save),
                      const SizedBox(height: 28),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.95,
                          children: [
                            _card("PLANTILLA", FontAwesomeIcons.users, () => _go(SquadScreen(team: widget.userTeam, dbService: widget.dbService))),
                            _card("ALINEACIÓN", FontAwesomeIcons.listOl, () => _go(LineupScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
                            _card("ENTRENO", FontAwesomeIcons.dumbbell, () => _go(TrainingScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
                            _card("MERCADO", FontAwesomeIcons.handshake, () => _go(PlayerSearchScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
                            _card("OFERTAS", FontAwesomeIcons.fileContract, () => _go(TransferOffersScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
                            _card("OJEADOR", FontAwesomeIcons.globe, () => _go(InternationalScoutScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
                            _card("EDITOR", FontAwesomeIcons.penToSquare, () => _go(EditorScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
                            _card("FINANZAS", FontAwesomeIcons.chartLine, () => _go(FinanceScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
                            _card("ESTADIO", FontAwesomeIcons.landmark, () => _go(StadiumScreen(dbService: widget.dbService, team: widget.userTeam))),
                            _card("STAFF", FontAwesomeIcons.usersCog, () => _go(StaffScreen(dbService: widget.dbService, team: widget.userTeam))),
                            _card("CALENDARIO", FontAwesomeIcons.calendarDays, () => _go(FullCalendarScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
                            _card("CLUB", FontAwesomeIcons.briefcase, () => _go(ClubManagementScreen(dbService: widget.dbService, team: widget.userTeam))),
                            _card("CLASIFIC.", FontAwesomeIcons.rankingStar, () => _go(LeagueTableScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
                            _card("MENSAJES", FontAwesomeIcons.envelope, () async {
                              await _go(SecretaryScreen(dbService: widget.dbService));
                              _refreshUnread();
                            }, badge: _unread),
                          ],
                        ),
                      ),
                      _buildNextMatchBar(save),
                    ],
                  ),
                ),
              ),
              if (_isAdvancingDay) _buildCalendarOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCalendarOverlay() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          color: Colors.black.withValues(alpha: 0.6),
          child: Center(
            child: AnimatedBuilder(
              animation: _calendarController,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0015) // Perspectiva 3D
                    ..rotateX(_flipAnimation.value)
                    ..scale(_scaleAnimation.value),
                  alignment: Alignment.center,
                  child: Container(
                    width: 200,
                    height: 240,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFDEFF9A).withValues(alpha: 0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDC2626),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "CALENDARIO",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _animatingDayLabel.split('\n')[0],
                                  style: const TextStyle(color: Color(0xFF0F172A), fontSize: 28, fontWeight: FontWeight.w900, height: 1.1),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Container(height: 2, color: Colors.grey.withValues(alpha: 0.2), width: 60),
                                const SizedBox(height: 12),
                                Text(
                                  _animatingDayLabel.split('\n')[1],
                                  style: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Icon(Icons.fast_forward_rounded, color: const Color(0xFF0F172A).withValues(alpha: 0.3), size: 24),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(GameSave? save) {
    return StreamBuilder<List<LeagueStanding>>(
      stream: widget.dbService.isar.leagueStandings
          .filter()
          .teamApiIdEqualTo(widget.userTeam.apiId)
          .watch(fireImmediately: true),
      builder: (context, standSnap) {
        final st = standSnap.data?.isNotEmpty == true ? standSnap.data!.first : null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("PC FÚTBOL", style: TextStyle(color: Color(0xFFDEFF9A), fontSize: 38, fontWeight: FontWeight.w900, letterSpacing: -1)),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFFDEFF9A), borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    save != null ? "J${save.currentMatchday}/${save.totalMatchdays}" : "2026",
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
                const SizedBox(width: 8),
                if (save != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      "D${save.currentDay}/7",
                      style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(widget.userTeam.name.toUpperCase(), overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                if (st != null)
                  Text("${st.points} PT", style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.w900, fontSize: 13)),
              ],
            ),
            if (st != null)
              Text("${st.wins}V ${st.draws}E ${st.losses}D · ${st.goalsFor}:${st.goalsAgainst}", style: const TextStyle(color: Colors.white38, fontSize: 10)),
            if (save?.seasonFinished == true)
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text("TEMPORADA FINALIZADA", style: TextStyle(color: Color(0xFFDEFF9A), fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            if (save != null && !save.seasonFinished) ...[
              const SizedBox(height: 6),
              Text(
                'Objetivo: ${save.boardObjectiveLabel}',
                style: const TextStyle(color: Colors.white38, fontSize: 9),
              ),
              if (save.consecutiveRedWeeks > 0)
                Text(
                  'Números rojos: ${save.consecutiveRedWeeks}/3 semanas',
                  style: const TextStyle(color: Colors.redAccent, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 6),
              _buildMatchModeChip(save),
            ],
            if (save?.financiallyDismissed == true)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('DESPEDIDO — No puedes continuar', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
          ],
        );
      },
    );
  }

  Widget _card(String title, IconData icon, VoidCallback onTap, {int badge = 0}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: const Color(0xFFDEFF9A), size: 28),
                  const SizedBox(height: 8),
                  Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9, letterSpacing: 0.5)),
                ],
              ),
            ),
            if (badge > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Text("$badge", style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchModeChip(GameSave save) {
    final isResumen = save.matchMode != 'resultado';
    return GestureDetector(
      onTap: () async {
        save.matchMode = isResumen ? 'resultado' : 'resumen';
        await widget.dbService.isar.writeTxn(() => widget.dbService.isar.gameSaves.put(save));
        if (mounted) setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "PARTIDO: ${isResumen ? 'RESUMEN' : 'RESULTADO'} (tocar)",
          style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildNextMatchBar(GameSave? save) {
    if (save?.financiallyDismissed == true) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: Text(
          'Has sido despedido. Inicia nueva partida desde el título.',
          style: TextStyle(color: Colors.redAccent, fontSize: 11),
        ),
      );
    }

    if (save?.seasonFinished == true) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            const Text("Temporada completada.", style: TextStyle(color: Colors.white38, fontSize: 11)),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDEFF9A),
                minimumSize: const Size(double.infinity, 52),
              ),
              onPressed: save?.financiallyDismissed == true
                  ? null
                  : () async {
                      await _session.startNextSeason(widget.userTeam);
                      if (mounted) setState(() {});
                    },
              child: const Text("NUEVA TEMPORADA", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      );
    }

    // El partido solo es jugable el Día 7 (Domingo)
    final isMatchdayDay = save?.currentDay == 7;

    return FutureBuilder<List<LeagueFixture>>(
      future: CalendarService(widget.dbService.isar).getUserPendingFixtures(widget.userTeam.apiId),
      builder: (context, fixSnap) {
        final fixtures = fixSnap.data ?? [];
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (fixtures.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'JORNADA ${save!.currentMatchday} — ${fixtures.length} partido(s)',
                  style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              ...fixtures.map((f) => FutureBuilder<Team?>(
                    future: CalendarService(widget.dbService.isar).opponentFor(f, widget.userTeam.apiId),
                    builder: (context, oppSnap) {
                      final opp = oppSnap.data;
                      final isHome = CalendarService(widget.dbService.isar).userIsHome(f, widget.userTeam.apiId);
                      final isCup = f.competition == 'copa';
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _matchBar(
                          label: isCup ? 'COPA DEL REY' : 'LIGA',
                          opponent: opp?.name ?? '—',
                          isHome: isHome,
                          onTap: (opp == null || !isMatchdayDay) 
                              ? null 
                              : () => _playMatch(opp, isHome, f),
                          accent: !isMatchdayDay 
                              ? const Color(0xFF1E293B).withValues(alpha: 0.4)
                              : (isCup ? const Color(0xFF1E293B) : const Color(0xFFDEFF9A)),
                          textColor: !isMatchdayDay 
                              ? Colors.white24 
                              : (isCup ? const Color(0xFFDEFF9A) : Colors.black),
                          isLocked: !isMatchdayDay,
                        ),
                      );
                    },
                  )),
            ] else ...[
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text('Sin partidos pendientes en esta jornada.', style: TextStyle(color: Colors.white38, fontSize: 11)),
              ),
            ],
            const SizedBox(height: 4),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 42),
                side: const BorderSide(color: Colors.white24),
              ),
              onPressed: (isMatchdayDay && fixtures.isNotEmpty)
                  ? null 
                  : () => _handleAdvanceDay(save),
              icon: const Icon(Icons.fast_forward, color: Color(0xFFDEFF9A), size: 18),
              label: Text(
                (isMatchdayDay && fixtures.isNotEmpty)
                    ? 'DEBES JUGAR EL PARTIDO'
                    : 'PASAR DÍA',
                style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  Future<void> _go(Widget screen) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    if (mounted) {
      setState(() {});
      _refreshUnread();
    }
  }

  Widget _matchBar({
    required String label,
    required String opponent,
    required bool isHome,
    required VoidCallback? onTap,
    Color accent = const Color(0xFFDEFF9A),
    Color textColor = Colors.black,
    bool isLocked = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.circular(18),
          border: isLocked ? Border.all(color: Colors.white10) : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(color: textColor.withValues(alpha: 0.7), fontSize: 9, fontWeight: FontWeight.bold)),
                  Text("VS ${opponent.toUpperCase()}", style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w900)),
                  Text(
                    isLocked ? "BLOQUEADO HASTA EL DOMINGO (D7)" : (isHome ? "EN CASA" : "FUERA"),
                    style: TextStyle(
                      color: isLocked ? Colors.white24 : textColor.withValues(alpha: 0.55), 
                      fontSize: 10, 
                      fontWeight: isLocked ? FontWeight.bold : FontWeight.normal
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isLocked ? Icons.lock_outline_rounded : Icons.play_arrow_rounded,
              color: textColor,
              size: 36,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _playMatch(Team opponent, bool userIsHome, LeagueFixture fixture) async {
    // 1. Control de plantilla mínima global (Regla PC Fútbol)
    if (!await _session.meetsMinimumSquad(widget.userTeam.apiId)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Plantilla insuficiente: mínimo 16 jugadores (regla PC Fútbol 7).")),
      );
      return;
    }

    // 2. INTERCEPCIÓN TÁCTICA: Validación rigurosa del 11 inicial guardado
    final lineup = LineupService(widget.dbService.isar);
    final isValid = await lineup.hasValidLineup(widget.userTeam.apiId);

    if (!isValid) {
      if (!mounted) return;
      
      // Diálogo persistente e informativo para advertir de la obligación del once inicial
      await showDialog(
        context: context,
        barrierDismissible: false, 
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF0F172A),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text(
              "⚙️ AVISO DEL SEGUNDO ENTRENADOR", 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5)
            ),
            content: const Text(
              "No has seleccionado los 11 titulares para el encuentro de hoy.\n\nEs obligatorio configurar tu estrategia y designar un guardameta profesional apto antes de saltar al terreno de juego.",
              style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "ESTABLECER ALINEACIÓN", 
                  style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)
                ),
              ),
            ],
          );
        },
      );

      // Redirección inmediata y automatizada a la pizarra táctica para facilitar la gestión
      await _go(LineupScreen(dbService: widget.dbService, userTeam: widget.userTeam));
      
      // Segunda comprobación post-retorno para verificar si el usuario completó la tarea o canceló
      final stillInvalid = !await lineup.hasValidLineup(widget.userTeam.apiId);
      if (stillInvalid) return; 
    }

    // 3. El mánager ha cumplido las exigencias del cuerpo técnico: Arrancamos el partido
    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MatchDayScreen(
          dbService: widget.dbService,
          userTeam: widget.userTeam,
          opponent: opponent,
          userIsHome: userIsHome,
          fixture: fixture,
        ),
      ),
    );
    if (mounted) setState(() {});
  }
}