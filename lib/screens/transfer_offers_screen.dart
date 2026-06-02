import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../models/player_model.dart';
import '../core/transfer_ai_service.dart';
import '../models/team.dart';
import '../models/transfer_offer.dart';
import '../models/game_save.dart';
class TransferOffersScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const TransferOffersScreen({super.key, required this.dbService, required this.userTeam});

  @override
  State<TransferOffersScreen> createState() => _TransferOffersScreenState();
}

class _TransferOffersScreenState extends State<TransferOffersScreen> {
  late final TransferAiService _ai;
  List<TransferOffer> _offers = [];
  bool _loading = true;
  String _tab = 'all';

  @override
  void initState() {
    super.initState();
    _ai = TransferAiService(widget.dbService.isar);
    _load();
  }

  Future<void> _load() async {
    final list = await _ai.pendingOffers();
    if (mounted) {
      setState(() {
        _offers = list;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text('OFERTAS DE MERCADO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _load,
            icon: const Icon(Icons.refresh, color: Color(0xFFDEFF9A)),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)))
          : _filteredOffers().isEmpty
              ? const Center(child: Text('Sin ofertas pendientes.', style: TextStyle(color: Colors.white38)))
              : Column(
                  children: [
                    _tabs(),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredOffers().length,
                        itemBuilder: (_, i) => _offerCard(_filteredOffers()[i]),
                      ),
                    ),
                  ],
                ),
    );
  }

  List<TransferOffer> _filteredOffers() {
    if (_tab == 'incoming') {
      return _offers.where((o) => !o.isForOurPlayer).toList();
    }
    if (_tab == 'outgoing') {
      return _offers.where((o) => o.isForOurPlayer).toList();
    }
    return _offers;
  }

  Widget _tabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          _tabChip('Todas', 'all'),
          const SizedBox(width: 6),
          _tabChip('Por tus jugadores', 'outgoing'),
          const SizedBox(width: 6),
          _tabChip('Para fichar', 'incoming'),
        ],
      ),
    );
  }

  Widget _tabChip(String label, String id) {
    final selected = _tab == id;
    return ChoiceChip(
      label: Text(label, style: TextStyle(color: selected ? Colors.black : Colors.white70, fontSize: 11)),
      selected: selected,
      selectedColor: const Color(0xFFDEFF9A),
      onSelected: (_) => setState(() => _tab = id),
    );
  }

  Widget _offerCard(TransferOffer o) {
    return FutureBuilder<Player?>(
      future: widget.dbService.isar.players.get(o.playerId),
      builder: (context, snap) {
        final p = snap.data;
        final saveFuture = widget.dbService.isar.gameSaves.get(1);
        final typeLabel = switch (o.offerType) {
          OfferType.purchase => 'COMPRA',
          OfferType.loanIn => 'CESIÓN ENTRANTE',
          OfferType.loanOut => 'CESIÓN SALIDA',
        };
        return FutureBuilder<GameSave?>(
          future: saveFuture,
          builder: (context, saveSnap) {
            final md = saveSnap.data?.currentMatchday ?? 1;
            final left = (o.expiresOnMatchday - md).clamp(0, 99);
            final urgent = left <= 1;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: urgent
                      ? Colors.redAccent.withValues(alpha: 0.45)
                      : const Color(0xFFDEFF9A).withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(typeLabel, style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 10, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Text(
                        urgent ? 'URGENTE' : 'VIGENTE',
                        style: TextStyle(
                          color: urgent ? Colors.redAccent : Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(p?.name ?? 'Jugador', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(o.counterpartyTeamName, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(
                    o.offerType == OfferType.loanIn || o.offerType == OfferType.loanOut
                        ? '${o.loanMatchdays} jornadas'
                        : '${(o.amount / 1e6).toStringAsFixed(2)} M€',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    'Caduca en $left jornada(s)',
                    style: TextStyle(color: urgent ? Colors.redAccent : Colors.white38, fontSize: 11),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            await _ai.rejectOffer(o);
                            await _load();
                          },
                          child: const Text('RECHAZAR'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDEFF9A), foregroundColor: Colors.black),
                          onPressed: () async {
                            final msg = await _ai.acceptOffer(o, widget.userTeam.apiId);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                            await _load();
                          },
                          child: const Text('ACEPTAR', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
