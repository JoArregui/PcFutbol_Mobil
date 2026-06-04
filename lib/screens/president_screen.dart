import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/board_service.dart';
import '../core/database_service.dart';
import '../core/league_service.dart';
import '../models/game_save.dart';
import '../models/team.dart';

class PresidentScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const PresidentScreen({
    super.key,
    required this.dbService,
    required this.userTeam,
  });

  @override
  State<PresidentScreen> createState() => _PresidentScreenState();
}

class _PresidentScreenState extends State<PresidentScreen> {
  late final BoardService _board;

  @override
  void initState() {
    super.initState();
    _board = BoardService(widget.dbService.isar);
  }

  Color _acceptanceColor(int v) {
    if (v >= 70) return const Color(0xFFDEFF9A);
    if (v >= 45) return Colors.amber;
    return Colors.redAccent;
  }

  Future<void> _requestAudience(GameSave save) async {
    if (save.financiallyDismissed) return;

    final league = LeagueService(widget.dbService.isar);
    await league.loadStandingsCachePublic();
    final pos = league.userPositionFromCachePublic(widget.userTeam.apiId) ?? 10;

    final report = await _board.evaluateWeeklyAcceptance(
      save: save,
      userTeam: widget.userTeam,
      leaguePosition: pos,
      finishedMatchday: save.currentMatchday > 1 ? save.currentMatchday - 1 : 1,
    );

    await widget.dbService.isar.writeTxn(() => widget.dbService.isar.gameSaves.put(save));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Confianza actualizada: ${report.acceptance}%')),
    );
    setState(() {});
  }

  Future<void> _confirmDismissal(GameSave save) async {
    final dismissed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text(
          '¿Cesar al entrenador?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'La confianza es del ${save.boardAcceptance}%. '
          'Si confirmas, el consejo te cesará y la partida terminará.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('CANCELAR', style: TextStyle(color: Colors.white38)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('DESPEDIR', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (dismissed != true || !mounted) return;

    final fired = await _board.presidentDismissesManager(save, widget.userTeam);
    if (fired && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El presidente ha puesto fin a tu contrato.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text('PRESIDENTE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<GameSave?>(
        stream: widget.dbService.isar.gameSaves.watchObject(1, fireImmediately: true),
        builder: (context, snap) {
          final save = snap.data;
          if (save == null) {
            return const Center(child: Text('Sin partida activa', style: TextStyle(color: Colors.white38)));
          }

          final acceptance = save.boardAcceptance;
          final feedback = save.boardLastFeedback.isNotEmpty
              ? save.boardLastFeedback
              : 'Aún no hay informe semanal. Juega la primera jornada para recibir valoración.';

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _acceptanceColor(acceptance).withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(FontAwesomeIcons.userTie, color: Color(0xFFDEFF9A), size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.userTeam.name.toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'CONFIANZA DE LA DIRECTIVA',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '$acceptance%',
                          style: TextStyle(color: _acceptanceColor(acceptance), fontSize: 36, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: acceptance / 100,
                              minHeight: 10,
                              backgroundColor: Colors.white10,
                              color: _acceptanceColor(acceptance),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      feedback,
                      style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.45),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _infoTile('Objetivo', save.boardObjectiveLabel, FontAwesomeIcons.bullseye),
              if (save.consecutiveRedWeeks > 0)
                _infoTile(
                  'Tesorería',
                  '${save.consecutiveRedWeeks}/3 semanas en rojo',
                  FontAwesomeIcons.wallet,
                  accent: Colors.redAccent,
                ),
              const SizedBox(height: 24),
              if (!save.financiallyDismissed) ...[
                OutlinedButton.icon(
                  onPressed: () => _requestAudience(save),
                  icon: const Icon(Icons.forum_outlined, color: Color(0xFFDEFF9A), size: 18),
                  label: const Text(
                    'SOLICITAR AUDIENCIA',
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: const BorderSide(color: Colors.white24),
                  ),
                ),
                if (acceptance <= 35) ...[
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade900,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: acceptance <= 20 ? () => _confirmDismissal(save) : null,
                    icon: const Icon(Icons.gavel, color: Colors.white),
                    label: Text(
                      acceptance <= 20
                          ? 'EL PRESIDENTE PUEDE DESPEDIRTE'
                          : 'RIESGO DE DESPIDO — MEJORA RESULTADOS',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ] else
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Has sido despedido. Vuelve al menú principal para iniciar una nueva partida.',
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _infoTile(String label, String value, IconData icon, {Color? accent}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent ?? Colors.white38, size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(), style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
                Text(value, style: TextStyle(color: accent ?? Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
