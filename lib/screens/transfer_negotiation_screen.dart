import 'dart:math';
import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../core/finance_service.dart';
import '../core/message_service.dart';
import '../models/game_message.dart';
import '../models/player_model.dart';
import '../models/team.dart';

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
  State<TransferNegotiationScreen> createState() => TransferNegotiationScreenState();
}

class TransferNegotiationScreenState extends State<TransferNegotiationScreen> {
  late double _offer;
  late double _minAccept;
  double _patience = 1.0;
  String _agentLine = "El agente espera tu primera oferta.";
  bool _done = false;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _minAccept = widget.player.marketValue * _personalityFactor();
    _offer = _minAccept * 0.75;
  }

  double _personalityFactor() {
    switch (widget.player.personality) {
      case Personality.greedy:
        return 1.25;
      case Personality.ambitious:
        return 1.1;
      case Personality.loyal:
        return 0.9;
      case Personality.professional:
        return 1.0;
    }
  }

  Future<void> _submitOffer() async {
    if (_done) return;

    final ratio = _offer / _minAccept;
    if (ratio >= 0.98) {
      final finance = FinanceService(widget.dbService.isar);
      final msg = await finance.signPlayer(widget.player, _offer, widget.userTeam.apiId);
      await MessageService(widget.dbService.isar).add(
        title: "Fichaje cerrado",
        body: "${widget.player.name} firma por tu club.",
        type: MessageType.transfer,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: const Color(0xFFDEFF9A)));
      setState(() {
        _done = true;
        _agentLine = "Trato hecho. Bienvenido a bordo.";
      });
      return;
    }

    setState(() {
      _patience -= ratio < 0.7 ? 0.35 : 0.18;
      if (_patience <= 0) {
        _done = true;
        _agentLine = "Negociación rota. El agente cuelga.";
      } else if (ratio < 0.85) {
        _agentLine = "Oferta insultante. Suban o nos vamos.";
      } else {
        _agentLine = "Casi. Un poco más y hablamos.";
      }
    });

    if (_patience > 0 && _rng.nextDouble() > 0.5) {
      _minAccept *= 0.97;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: Text(widget.player.name.toUpperCase(), style: const TextStyle(fontSize: 14)),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text("NEGOCIACIÓN", style: TextStyle(color: Color(0xFFDEFF9A), letterSpacing: 3, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LinearProgressIndicator(
                value: _patience.clamp(0, 1),
                backgroundColor: Colors.white10,
                color: _patience > 0.3 ? const Color(0xFFDEFF9A) : Colors.red,
              ),
            ),
            const Text("Paciencia del agente", style: TextStyle(color: Colors.white38, fontSize: 11)),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, size: 80, color: Color(0xFFDEFF9A)),
                      const SizedBox(height: 20),
                      Text(_agentLine, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                      const SizedBox(height: 12),
                      Text(
                        "Mínimo estimado: ${(_minAccept / 1000000).toStringAsFixed(2)} M€",
                        style: const TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(28),
              decoration: const BoxDecoration(
                color: Color(0xFF0F172A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                children: [
                  Text("${(_offer / 1000000).toStringAsFixed(2)} M €", style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
                  Slider(
                    value: _offer.clamp(500000, widget.player.marketValue * 2),
                    min: 500000,
                    max: widget.player.marketValue * 2,
                    onChanged: _done ? null : (v) => setState(() => _offer = v),
                    activeColor: const Color(0xFFDEFF9A),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDEFF9A), foregroundColor: Colors.black),
                      onPressed: _done ? () => Navigator.pop(context, true) : _submitOffer,
                      child: Text(_done ? "VOLVER" : "ENVIAR OFERTA", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
