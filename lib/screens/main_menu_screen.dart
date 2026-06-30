import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:isar/isar.dart';
import '../core/calendar_service.dart';
import '../core/database_service.dart';
import '../core/game_calendar.dart';
import '../core/game_session_service.dart';
import '../core/lineup_guard.dart';
import '../core/message_service.dart';
import '../core/responsive.dart';
import '../models/finance_model.dart';
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
import 'secretary_screen.dart';
import 'squad_screen.dart';
import 'stadium_screen.dart';
import 'president_screen.dart';
import 'staff_screen.dart';
import 'training_screen.dart';
import 'transfer_offers_screen.dart';
import 'transfer_market_screen.dart';
import 'advanced_tactics_screen.dart';

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
    final next = GameCalendar.nextAfterAdvance(
      matchday: currentMatchday,
      dayOfWeek: currentDay,
    );

    setState(() {
      _isAdvancingDay = true;
      _animatingDayLabel = GameCalendar.formatAdvanceOverlay(
        seasonNumber: save.seasonNumber,
        matchday: next.matchday,
        dayOfWeek: next.dayOfWeek,
      );
    });

    await _calendarController.forward();

    final calendarService = CalendarService(widget.dbService.isar);
    await calendarService.advanceDay(widget.userTeam.apiId);

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
              LayoutBuilder(
                builder: (context, constraints) {
                  final hPad = Responsive.horizontalPadding(context);
                  return SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPad),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          _buildHeader(save),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: Responsive.maxContentWidth(context),
                                ),
                                child: _buildGrid(context),
                              ),
                            ),
                          ),
                          Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: Responsive.maxContentWidth(context),
                              ),
                              child: _buildNextMatchBar(save),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (_isAdvancingDay) _buildCalendarOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: Responsive.gridColumns(context, min: 2, max: 5),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: Responsive.gridAspectRatio(context),
      children: [
        _card("PLANTILLA", FontAwesomeIcons.users, () => _go(SquadScreen(team: widget.userTeam, dbService: widget.dbService))),
        _card("ALINEACIÓN", FontAwesomeIcons.listOl, () => _go(LineupScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("TÁCTICAS", FontAwesomeIcons.chessBoard, () => _go(AdvancedTacticsScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("ENTRENO", FontAwesomeIcons.dumbbell, () => _go(TrainingScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("MERCADO", FontAwesomeIcons.handshake, () => _go(TransferMarketScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("OFERTAS", FontAwesomeIcons.fileContract, () => _go(TransferOffersScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("OJEADOR", FontAwesomeIcons.globe, () => _go(InternationalScoutScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("EDITOR", FontAwesomeIcons.penToSquare, () => _go(EditorScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("FINANZAS", FontAwesomeIcons.chartLine, () => _go(FinanceScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("ESTADIO", FontAwesomeIcons.landmark, () => _go(StadiumScreen(dbService: widget.dbService, team: widget.userTeam))),
        _card("STAFF", FontAwesomeIcons.usersCog, () => _go(StaffScreen(dbService: widget.dbService, team: widget.userTeam))),
        _card("CALENDARIO", FontAwesomeIcons.calendarDays, () => _go(FullCalendarScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("CLUB", FontAwesomeIcons.briefcase, () => _go(ClubManagementScreen(dbService: widget.dbService, team: widget.userTeam))),
        _card("PRESIDENTE", FontAwesomeIcons.userTie, () => _go(PresidentScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("CLASIFIC.", FontAwesomeIcons.rankingStar, () => _go(LeagueTableScreen(dbService: widget.dbService, userTeam: widget.userTeam))),
        _card("MENSAJES", FontAwesomeIcons.envelope, () async {
          await _go(SecretaryScreen(dbService: widget.dbService));
          _refreshUnread();
        }, badge: _unread),
      ],
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
                    ..setEntry(3, 2, 0.0015)
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
                                  style: const TextStyle(color: Color(0xFF0F172A), fontSize: 22, fontWeight: FontWeight.w900, height: 1.1),
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
                if (save != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFDEFF9A), borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      "T${save.seasonNumber}",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                if (save != null) const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFFDEFF9A).withValues(alpha: 0.18), borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    save != null ? "J${save.currentMatchday}/${save.totalMatchdays}" : "2026",
                    style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
                const SizedBox(width: 8),
                if (save != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      GameCalendar.formatHeader(
                        seasonNumber: save.seasonNumber,
                        matchday: save.currentMatchday,
                        dayOfWeek: save.currentDay,
                      ),
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
              _buildBoardAcceptanceBar(save),
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

  Widget _buildBoardAcceptanceBar(GameSave save) {
    final v = save.boardAcceptance;
    final color = v >= 70
        ? const Color(0xFFDEFF9A)
        : v >= 45
            ? Colors.amber
            : Colors.redAccent;
    final feedback = save.boardLastFeedback.isNotEmpty
        ? save.boardLastFeedback
        : 'La directiva evaluará tu trabajo al cerrar cada jornada.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'CONFIANZA DIRECTIVA: $v%',
              style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: v / 100,
                  minHeight: 4,
                  backgroundColor: Colors.white10,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          feedback,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white38, fontSize: 8, height: 1.2),
        ),
      ],
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
      // La cadena automática de temporadas no debería dejarnos aquí, pero
      // mantenemos esta pantalla como salvaguarda por si algo falla
      // (p. ej. despido antes de la última jornada o error en cadena).
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
              onPressed: () async {
                await _session.startNextSeason(widget.userTeam);
                if (mounted) setState(() {});
              },
              child: const Text("REINTENTAR NUEVA TEMPORADA", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      );
    }

    final isMatchdayDay = save?.currentDay == 7;

    return StreamBuilder<ClubFinance?>(
      stream: widget.dbService.isar.clubFinances.watchObject(1, fireImmediately: true),
      builder: (context, financeSnap) {
        final ticketPrice = financeSnap.data?.ticketPrice;

        return FutureBuilder<List<LeagueFixture>>(
          future: CalendarService(widget.dbService.isar).getUserPendingFixtures(widget.userTeam.apiId),
          builder: (context, fixSnap) {
            final fixtures = fixSnap.data ?? [];
            final hasHomeFixture = fixtures.any(
              (f) => CalendarService(widget.dbService.isar).userIsHome(f, widget.userTeam.apiId),
            );

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
                  if (hasHomeFixture && isMatchdayDay)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _ticketReminderBanner(ticketPrice),
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
                              seasonNumber: save.seasonNumber,
                              matchday: save.currentMatchday,
                              ticketPrice: ticketPrice,
                              onEditTickets: isHome && isMatchdayDay
                                  ? () => _go(FinanceScreen(dbService: widget.dbService, userTeam: widget.userTeam))
                                  : null,
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
      },
    );
  }

  Widget _ticketReminderBanner(double? ticketPrice) {
    return GestureDetector(
      onTap: () => _go(FinanceScreen(dbService: widget.dbService, userTeam: widget.userTeam)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFDEFF9A).withValues(alpha: 0.35)),
        ),
        child: Row(
          children: [
            const Icon(Icons.confirmation_number_outlined, color: Color(0xFFDEFF9A), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                ticketPrice != null
                    ? 'Partido LOCAL: entradas a ${ticketPrice.toStringAsFixed(0)} €. Toca para ajustar precio.'
                    : 'Partido LOCAL: revisa el precio de las entradas en Finanzas.',
                style: const TextStyle(color: Colors.white70, fontSize: 10, height: 1.3),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white24, size: 18),
          ],
        ),
      ),
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
    required int seasonNumber,
    required int matchday,
    required VoidCallback? onTap,
    double? ticketPrice,
    VoidCallback? onEditTickets,
    Color accent = const Color(0xFFDEFF9A),
    Color textColor = Colors.black,
    bool isLocked = false,
  }) {
    final venueLabel = isHome ? 'LOCAL' : 'VISITANTE';
    final venueColor = isHome ? const Color(0xFF22C55E) : const Color(0xFF64748B);

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(label, style: TextStyle(color: textColor.withValues(alpha: 0.7), fontSize: 9, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isLocked ? Colors.white10 : venueColor.withValues(alpha: isHome ? 0.25 : 0.35),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isLocked ? Colors.white24 : venueColor.withValues(alpha: 0.8),
                          ),
                        ),
                        child: Text(
                          venueLabel,
                          style: TextStyle(
                            color: isLocked ? Colors.white38 : Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text("VS ${opponent.toUpperCase()}", style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w900)),
                  if (isLocked)
                    Text(
                      'BLOQUEADO HASTA EL ${GameCalendar.formatMatchdaySunday(seasonNumber: seasonNumber, matchday: matchday).toUpperCase()}',
                      style: const TextStyle(
                        color: Colors.white24,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else if (isHome) ...[
                    Text(
                      ticketPrice != null
                          ? "Taquilla: ${ticketPrice.toStringAsFixed(0)} €/entrada"
                          : "Partido en tu estadio — cobras taquilla",
                      style: TextStyle(color: textColor.withValues(alpha: 0.65), fontSize: 10),
                    ),
                    if (onEditTickets != null)
                      GestureDetector(
                        onTap: onEditTickets,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "Ajustar precio entradas →",
                            style: TextStyle(
                              color: textColor.withValues(alpha: 0.85),
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: textColor.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
                  ] else
                    Text(
                      "Sin taquilla (visitante)",
                      style: TextStyle(color: textColor.withValues(alpha: 0.55), fontSize: 10),
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
    if (!await _session.meetsMinimumSquad(widget.userTeam.apiId)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plantilla insuficiente.')),
      );
      return;
    }

    final lineupOk = await LineupGuard.ensureBeforeMatch(
      context: context,
      isar: widget.dbService.isar,
      userTeam: widget.userTeam,
    );
    if (!lineupOk || !mounted) return;

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