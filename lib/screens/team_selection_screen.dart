import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import '../core/api_service.dart';
import '../core/database_service.dart';
import '../core/game_session_service.dart';
import '../core/responsive.dart';
import '../models/team.dart';
import 'main_menu_screen.dart';

/// =============================================================================
/// PANTALLA DE SELECCIÓN DE EQUIPO:
/// -----------------------------------------------------------------------------
/// FLUJO COMPLETO:
/// 1. PRIMERA VEZ / REINICIO:
///    - resetCareer() borra TODO (equipos, jugadores, partida...)
///    - Se sincroniza API -> BD (datos frescos)
///    - Usuario elige equipo
///
/// 2. DURANTE LA PARTIDA:
///    - NUNCA se consulta la API
///    - TODO se lee/escribe en la BD local
/// =============================================================================
class TeamSelectionScreen extends StatefulWidget {
  final DatabaseService dbService;
  const TeamSelectionScreen({super.key, required this.dbService});

  @override
  State<TeamSelectionScreen> createState() => _TeamSelectionScreenState();
}

class _TeamSelectionScreenState extends State<TeamSelectionScreen>
    with TickerProviderStateMixin {
  Team? selectedTeam;
  bool _loadingSquad = false;

  // Usamos apiId como clave para que los controllers sean estables
  // aunque la lista se filtre/reordene (evita leak por índice).
  int _flippedTeamApiId = -1;

  final Map<int, AnimationController> _controllers = {};
  final Map<int, Animation<double>> _animations = {};

  void _initController(int teamApiId) {
    if (_controllers.containsKey(teamApiId)) return;
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controllers[teamApiId] = controller;
    _animations[teamApiId] = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
  }

  void _flipCard(Team team) {
    final key = team.apiId;
    _initController(key);

    if (_flippedTeamApiId != -1 && _flippedTeamApiId != key) {
      _controllers[_flippedTeamApiId]?.reverse();
    }

    if (_flippedTeamApiId == key) {
      _controllers[key]!.reverse();
      setState(() => _flippedTeamApiId = -1);
    } else {
      _controllers[key]!.forward();
      setState(() => _flippedTeamApiId = key);
    }
    HapticFeedback.lightImpact();
  }

  void _selectTeam(Team team) {
    setState(() => selectedTeam = team);
    _controllers[team.apiId]?.reverse();
    setState(() => _flippedTeamApiId = -1);
    HapticFeedback.mediumImpact();
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: Text(
          'ELIGE TU DESTINO',
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: const Color(0xFFDEFF9A),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFDEFF9A)),
            onPressed: () => setState(() {}),
          )
        ],
      ),
      body: StreamBuilder<List<Team>>(
        stream: widget.dbService.isar.teams
            .where()
            .watchLazy(fireImmediately: true)
            .asyncMap((_) => widget.dbService.isar.teams.where().findAll()),
        builder: (context, snapshot) {
          final teams = snapshot.data ?? [];

          debugPrint("Snapshot State: ${snapshot.connectionState} | Teams: ${teams.length}");

          if (teams.isEmpty) {
            return FutureBuilder<List<Team>>(
              future: widget.dbService.getAllTeams(),
              builder: (context, futureSnapshot) {
                if (futureSnapshot.hasData && futureSnapshot.data!.isNotEmpty) {
                  return _buildTeamList(futureSnapshot.data!);
                }
                return _buildLoadingState();
              },
            );
          }

          return _buildTeamList(teams);
        },
      ),
    );
  }

  Widget _buildTeamList(List<Team> teams) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth(context)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 2),
              child: Text(
                "Toca una tarjeta para ver el contrato",
                style: GoogleFonts.urbanist(
                  color: Colors.white24,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  final isSelected = selectedTeam?.apiId == team.apiId;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _buildFlipCard(team, isSelected),
                  );
                },
              ),
            ),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFlipCard(Team team, bool isSelected) {
    _initController(team.apiId);
    final animation = _animations[team.apiId]!;

    return GestureDetector(
      onTap: () => _flipCard(team),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final angle = animation.value * pi;
          final isBack = angle >= pi / 2;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
child: isBack
                    ? Transform(
                        transform: Matrix4.identity()..rotateY(pi),
                        alignment: Alignment.center,
                        child: _buildCardBack(team),
                      )
                    : _buildCardFront(team, isSelected),
          );
        },
      ),
    );
  }

  Widget _buildCardFront(Team team, bool isSelected) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFDEFF9A).withOpacity(0.08)
            : Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? const Color(0xFFDEFF9A)
              : Colors.white.withOpacity(0.08),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          _buildLogo(team.logoUrl),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  team.name.toUpperCase(),
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  team.stadium,
                  style: GoogleFonts.urbanist(
                    color: Colors.white38,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_circle_rounded,
                color: Color(0xFFDEFF9A), size: 22)
          else
            const Icon(Icons.rotate_right_rounded,
                color: Colors.white12, size: 18),
        ],
      ),
    );
  }

  Widget _buildCardBack(Team team) {
    final info = team.expectations;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFDEFF9A).withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildLogo(team.logoUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.name.toUpperCase(),
                      style: GoogleFonts.urbanist(
                        color: const Color(0xFFDEFF9A),
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      "OFERTA DE EMPLEO",
                      style: GoogleFonts.urbanist(
                        color: Colors.white38,
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _flipCard(team),
                child: const Icon(Icons.close_rounded,
                    color: Colors.white24, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDivider(),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.account_balance_wallet_outlined,
              "PRESUPUESTO", team.formattedBudget),
          const SizedBox(height: 10),
          _buildInfoRow(Icons.flag_outlined, "OBJETIVO", info["objetivo"]!),
          const SizedBox(height: 10),
          _buildInfoRow(Icons.bolt_outlined, "EXIGENCIA", info["exigencia"]!),
          const SizedBox(height: 14),
          _buildDivider(),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _selectTeam(team),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDEFF9A),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text(
                "ELEGIR ESTE CLUB",
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white24, size: 14),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.urbanist(
                  color: Colors.white24,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.urbanist(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 0.5,
      color: Colors.white.withOpacity(0.08),
    );
  }

  Widget _buildLogo(String url) {
    return Container(
      width: 44,
      height: 44,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        shape: BoxShape.circle,
      ),
      child: Image.network(
        url,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.shield, color: Colors.white24, size: 20),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFFDEFF9A)),
          const SizedBox(height: 20),
          Text(
            "CARGANDO LIGA...",
            style: GoogleFonts.urbanist(color: Colors.white, letterSpacing: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          onPressed: selectedTeam == null || _loadingSquad
    ? null
    : () async {
        setState(() => _loadingSquad = true);

        final session = GameSessionService(widget.dbService.isar);

        // 🔒 1. SINCRONIZAMOS API -> BD (solo si la BD está vacía;
        //    syncLeagueTeams ya comprueba esto internamente)
        debugPrint("🔄 SINCRONIZANDO DATOS DESDE API...");
        final apiService = ApiService();
        await apiService.syncLeagueTeams(140, widget.dbService);

        // 🔒 2. INICIAMOS LA PARTIDA
        await session.startSeason(selectedTeam!, {});

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainMenuScreen(
              userTeam: selectedTeam!,
              dbService: widget.dbService,
            ),
          ),
        );

        if (mounted) setState(() => _loadingSquad = false);
      },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDEFF9A),
            foregroundColor: Colors.black,
            disabledBackgroundColor: Colors.white.withOpacity(0.06),
            disabledForegroundColor: Colors.white24,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)),
            elevation: 0,
          ),
          child: Text(
            _loadingSquad ? 'SINCRONIZANDO DATOS…' : 'TOMAR LAS RIENDAS',
            style: GoogleFonts.urbanist(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}