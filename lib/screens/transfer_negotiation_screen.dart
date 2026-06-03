import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/database_service.dart';
import '../core/finance_service.dart';
import '../core/message_service.dart';
import '../models/game_message.dart';
import '../models/player_model.dart';
import '../models/team.dart';

// ─── Cláusulas opcionales ────────────────────────────────────────────────────
enum NegotiationClause { none, buyOption, sellOnFee }

extension NegotiationClauseLabel on NegotiationClause {
  String get label {
    switch (this) {
      case NegotiationClause.none:
        return "Sin cláusula";
      case NegotiationClause.buyOption:
        return "Opción de compra (+15%)";
      case NegotiationClause.sellOnFee:
        return "20% venta futura";
    }
  }

  String get description {
    switch (this) {
      case NegotiationClause.none:
        return "";
      case NegotiationClause.buyOption:
        return "El club vendedor puede recuperarlo pagando un 15% extra sobre tu oferta.";
      case NegotiationClause.sellOnFee:
        return "El club vendedor recibe el 20% si lo vendes en el futuro. Reduce la exigencia del agente.";
    }
  }
}

// ─── Estados de la negociación ───────────────────────────────────────────────
enum _NegotiationPhase { ongoing, accepted, broken }

class TransferNegotiationScreen extends StatefulWidget {
  final Player player;
  final Team userTeam;
  final DatabaseService dbService;

  const TransferNegotiationScreen({
    super.key,
    required this.player,
    required this.userTeam,
    required this.dbService,
  });

  @override
  State<TransferNegotiationScreen> createState() =>
      TransferNegotiationScreenState();
}

class TransferNegotiationScreenState
    extends State<TransferNegotiationScreen> {
  late double _offer;
  late double _agentTarget; // precio que el agente quiere conseguir realmente
  late double _agentAsk;    // contraoferta visible al jugador
  double _patience = 1.0;
  int _rounds = 0;

  String _agentLine = "";
  String _agentSubLine = "";
  _NegotiationPhase _phase = _NegotiationPhase.ongoing;
  NegotiationClause _clause = NegotiationClause.none;
  bool _showClausePanel = false;

  final _rng = Random();

  // ── Prestigio del club usuario (0‑3) ────────────────────────────────────
  // 0 = modesto, 1 = medio, 2 = grande, 3 = élite
  late int _userPrestige;

  @override
  void initState() {
    super.initState();
    _userPrestige = _calcPrestige(widget.userTeam.name);
    _agentTarget = widget.player.marketValue * _personalityFactor();
    // El agente ajusta su target DOWN si el club es de élite (intimidación inversa:
    // saben que pueden exigir más a equipos ricos, pero también cierran más rápido)
    _agentTarget *= _prestigeAgentMultiplier();
    _agentAsk = _agentTarget * 1.10; // el agente siempre pide un 10% más de lo que acepta
    _offer = _agentTarget * 0.72;
    _agentLine = _openingLine();
    _agentSubLine = "Valor de mercado: ${_fmt(widget.player.marketValue)}";
  }

  // ── Helpers de cálculo ───────────────────────────────────────────────────

  int _calcPrestige(String name) {
    final n = name.toLowerCase();
    if (n.contains('madrid') || n.contains('barcelona') || n.contains('city') ||
        n.contains('united') || n.contains('psg') || n.contains('bayern')) return 3;
    if (n.contains('atlético') || n.contains('atletico') || n.contains('sevilla') ||
        n.contains('liverpool') || n.contains('arsenal') || n.contains('chelsea') ||
        n.contains('juventus') || n.contains('milan') || n.contains('inter')) return 2;
    if (n.contains('valencia') || n.contains('betis') || n.contains('sociedad') ||
        n.contains('villarreal') || n.contains('napoli') || n.contains('roma')) return 1;
    return 0;
  }

  double _personalityFactor() {
    switch (widget.player.personality) {
      case Personality.greedy:
        return 1.30; // quiere mucho dinero
      case Personality.ambitious:
        return 1.10; // quiere un club grande
      case Personality.loyal:
        return 0.85; // acepta menos si confía
      case Personality.professional:
        return 1.00;
    }
  }

  // El agente pide más a clubes ricos porque saben que pueden pagar
  double _prestigeAgentMultiplier() {
    switch (_userPrestige) {
      case 3:
        return 1.18;
      case 2:
        return 1.08;
      case 1:
        return 1.00;
      default:
        return 0.92; // al modesto le dan algo de descuento (prefieren trato cerrado)
    }
  }

  // Clausulas reducen el target efectivo del agente
  double _clauseDiscount() {
    switch (_clause) {
      case NegotiationClause.sellOnFee:
        return 0.90; // 10% menos exigente si hay % de futura venta
      case NegotiationClause.buyOption:
        return 0.95;
      case NegotiationClause.none:
        return 1.0;
    }
  }

  double get _effectiveTarget => _agentTarget * _clauseDiscount();

  String _fmt(double v) => "${(v / 1e6).toStringAsFixed(2)} M€";

  // ── Frases del agente ────────────────────────────────────────────────────

  String _openingLine() {
    switch (widget.player.personality) {
      case Personality.greedy:
        return "Mi cliente no se mueve por menos de lo que vale. Sorpréndenos.";
      case Personality.ambitious:
        return "Le interesa el proyecto, pero el dinero también importa.";
      case Personality.loyal:
        return "No es fácil sacarle de donde está. Haz una oferta seria.";
      case Personality.professional:
        return "El agente espera tu primera oferta.";
    }
  }

  String _reactionLine(double ratio) {
    if (_patience <= 0.15) return "Estamos perdiendo el tiempo. Última oportunidad.";
    if (ratio < 0.70) {
      return widget.player.personality == Personality.greedy
          ? "¿Una broma? Mi cliente gana eso en tres meses."
          : "Esa oferta no merece respuesta.";
    }
    if (ratio < 0.85) {
      return widget.player.personality == Personality.ambitious
          ? "El proyecto le atrae, pero la cifra no está cerca."
          : "Demasiado lejos. Suban.";
    }
    if (ratio < 0.95) {
      return widget.player.personality == Personality.loyal
          ? "Cerca, pero necesita ver más compromiso."
          : "Casi. Un esfuerzo más y cerramos.";
    }
    return "Interesante. Pero podemos hacer algo mejor.";
  }

  // ── Lógica principal ─────────────────────────────────────────────────────

  Future<void> _submitOffer() async {
    if (_phase != _NegotiationPhase.ongoing) return;
    _rounds++;

    final ratio = _offer / _effectiveTarget;

    // ── ACEPTADO ────────────────────────────────────────────────────────────
    if (ratio >= 0.98) {
      final finance = FinanceService(widget.dbService.isar);
      final msg = await finance.signPlayer(
          widget.player, _offer, widget.userTeam.apiId);
      await MessageService(widget.dbService.isar).add(
        title: "Fichaje cerrado",
        body:
            "${widget.player.name} firma por tu club. ${_clause != NegotiationClause.none ? 'Cláusula: ${_clause.label}.' : ''}",
        type: MessageType.transfer,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
          backgroundColor: const Color(0xFF1E293B)));
      setState(() {
        _phase = _NegotiationPhase.accepted;
        _agentLine = "Trato hecho. ${_clause == NegotiationClause.sellOnFee ? 'Recordad el 20%.' : 'Bienvenido a bordo.'}";
        _agentSubLine = "Firmado por ${_fmt(_offer)}";
      });
      return;
    }

    // ── ROTURA ──────────────────────────────────────────────────────────────
    final patDrop = ratio < 0.70
        ? 0.38
        : ratio < 0.85
            ? 0.22
            : 0.12;

    // Los jugadores ambiciosos son más impacientes si el club es modesto
    final personalityPatDrop =
        (widget.player.personality == Personality.ambitious &&
                _userPrestige < 2)
            ? patDrop * 1.25
            : patDrop;

    setState(() {
      _patience -= personalityPatDrop;

      if (_patience <= 0) {
        _phase = _NegotiationPhase.broken;
        _agentLine = "Negociación rota. El agente cuelga el teléfono.";
        _agentSubLine = "";
        return;
      }

      // ── Contraoferta del agente ──────────────────────────────────────────
      // El agente baja su ask progresivamente según rondas y paciencia
      final agentFlexibility = (1 - _patience) * 0.15 + (_rounds * 0.02);
      _agentAsk = (_effectiveTarget * (1.10 - agentFlexibility))
          .clamp(_effectiveTarget, _effectiveTarget * 1.15);

      // Pequeña bajada aleatoria del target (el agente cede un poco)
      if (_rng.nextDouble() > 0.55) {
        _agentTarget *= 0.975;
      }

      _agentLine = _reactionLine(ratio);
      _agentSubLine = "Contraoferta del agente: ${_fmt(_agentAsk)}";
    });
  }

  // ── UI ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: Text(
          widget.player.name.toUpperCase(),
          style: GoogleFonts.urbanist(
              fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildAgentArea()),
            _buildClauseToggle(),
            if (_showClausePanel) _buildClausePanel(),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("NEGOCIACIÓN",
                  style: GoogleFonts.urbanist(
                      color: const Color(0xFFDEFF9A),
                      letterSpacing: 3,
                      fontWeight: FontWeight.w900,
                      fontSize: 11)),
              _buildPrestigeBadge(),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _patience.clamp(0.0, 1.0),
              backgroundColor: Colors.white10,
              color: _patience > 0.5
                  ? const Color(0xFFDEFF9A)
                  : _patience > 0.25
                      ? Colors.orange
                      : Colors.red,
              minHeight: 5,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Paciencia del agente",
                  style: GoogleFonts.urbanist(
                      color: Colors.white38, fontSize: 10)),
              Text(_personalityTag(),
                  style: GoogleFonts.urbanist(
                      color: Colors.white38,
                      fontSize: 10,
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrestigeBadge() {
    final labels = ["Modesto", "Medio", "Grande", "Élite"];
    final colors = [Colors.white24, Colors.blue, Colors.orange, const Color(0xFFDEFF9A)];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: colors[_userPrestige].withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        labels[_userPrestige],
        style: GoogleFonts.urbanist(
            color: colors[_userPrestige], fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }

  String _personalityTag() {
    switch (widget.player.personality) {
      case Personality.greedy:
        return "Jugador ambicioso 💰";
      case Personality.ambitious:
        return "Busca un gran club 🏆";
      case Personality.loyal:
        return "Jugador leal ❤️";
      case Personality.professional:
        return "Profesional 📋";
    }
  }

  Widget _buildAgentArea() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAgentAvatar(),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _agentLine,
                key: ValueKey(_agentLine),
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                    color: _phase == _NegotiationPhase.accepted
                        ? const Color(0xFFDEFF9A)
                        : _phase == _NegotiationPhase.broken
                            ? Colors.red
                            : Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.4),
              ),
            ),
            if (_agentSubLine.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                _agentSubLine,
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                    color: Colors.white38, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAgentAvatar() {
    final phase = _phase;
    Color ringColor = Colors.white12;
    IconData icon = Icons.person_outline_rounded;
    if (phase == _NegotiationPhase.accepted) {
      ringColor = const Color(0xFFDEFF9A);
      icon = Icons.handshake_outlined;
    } else if (phase == _NegotiationPhase.broken) {
      ringColor = Colors.red;
      icon = Icons.phone_disabled_rounded;
    } else if (_patience < 0.3) {
      ringColor = Colors.orange;
    }

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ringColor, width: 2),
        color: Colors.white.withOpacity(0.04),
      ),
      child: Icon(icon, size: 36, color: ringColor),
    );
  }

  Widget _buildClauseToggle() {
    if (_phase != _NegotiationPhase.ongoing) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: GestureDetector(
        onTap: () => setState(() => _showClausePanel = !_showClausePanel),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: _clause != NegotiationClause.none
                    ? const Color(0xFFDEFF9A).withOpacity(0.4)
                    : Colors.white10),
          ),
          child: Row(
            children: [
              Icon(Icons.description_outlined,
                  color: _clause != NegotiationClause.none
                      ? const Color(0xFFDEFF9A)
                      : Colors.white38,
                  size: 16),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _clause == NegotiationClause.none
                      ? "Añadir cláusula al contrato"
                      : _clause.label,
                  style: GoogleFonts.urbanist(
                      color: _clause != NegotiationClause.none
                          ? const Color(0xFFDEFF9A)
                          : Colors.white38,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Icon(_showClausePanel ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white24, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClausePanel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 6),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: NegotiationClause.values.map((c) {
            final selected = _clause == c;
            return InkWell(
              onTap: () => setState(() {
                _clause = c;
                _showClausePanel = false;
              }),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                child: Row(
                  children: [
                    Icon(
                      selected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: selected
                          ? const Color(0xFFDEFF9A)
                          : Colors.white24,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.label,
                              style: GoogleFonts.urbanist(
                                  color: selected
                                      ? const Color(0xFFDEFF9A)
                                      : Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                          if (c.description.isNotEmpty)
                            Text(c.description,
                                style: GoogleFonts.urbanist(
                                    color: Colors.white38,
                                    fontSize: 10,
                                    height: 1.3)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    final isDone = _phase != _NegotiationPhase.ongoing;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isDone) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tu oferta",
                    style: GoogleFonts.urbanist(
                        color: Colors.white38, fontSize: 11)),
                Text(_fmt(_offer),
                    style: GoogleFonts.urbanist(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900)),
              ],
            ),
            Slider(
              value: _offer.clamp(500000, widget.player.marketValue * 2.2),
              min: 500000,
              max: widget.player.marketValue * 2.2,
              onChanged: (v) => setState(() => _offer = v),
              activeColor: const Color(0xFFDEFF9A),
              inactiveColor: Colors.white10,
            ),
            // Marcador de contraoferta del agente
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Pide el agente: ",
                    style: GoogleFonts.urbanist(
                        color: Colors.white24, fontSize: 10)),
                Text(_fmt(_agentAsk),
                    style: GoogleFonts.urbanist(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 14),
          ],
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDone
                    ? (_phase == _NegotiationPhase.accepted
                        ? const Color(0xFFDEFF9A)
                        : Colors.red.withOpacity(0.8))
                    : const Color(0xFFDEFF9A),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              onPressed: isDone ? () => Navigator.pop(context, _phase == _NegotiationPhase.accepted) : _submitOffer,
              child: Text(
                isDone
                    ? (_phase == _NegotiationPhase.accepted
                        ? "CERRADO · VOLVER"
                        : "NEGOCIACIÓN ROTA · VOLVER")
                    : "ENVIAR OFERTA",
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}