import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/database_service.dart';
import '../models/finance_model.dart';
import '../models/team.dart';

class _SponsorOption {
  final String brand;
  final double income;
  const _SponsorOption(this.brand, this.income);
}

class StadiumScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team team;

  const StadiumScreen({super.key, required this.dbService, required this.team});

  @override
  State<StadiumScreen> createState() => _StadiumScreenState();
}

class _StadiumScreenState extends State<StadiumScreen> {
  int _effectiveCapacity = 0;
  static const _options = [
    _SponsorOption("NIKE", 45000),
    _SponsorOption("COCA-COLA", 32000),
    _SponsorOption("MOVISTAR", 28000),
    _SponsorOption("IBERDROLA", 22000),
    _SponsorOption("VACÍO", 0),
  ];

  @override
  void initState() {
    super.initState();
    _loadCapacity();
  }

  Future<void> _loadCapacity() async {
    final cap = await widget.dbService.effectiveStadiumCapacity(widget.team);
    if (mounted) setState(() => _effectiveCapacity = cap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: Text("ESTADIO: ${widget.team.stadium.toUpperCase()}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<ClubFinance?>(
        stream: widget.dbService.isar.clubFinances.watchObject(1, fireImmediately: true),
        builder: (context, snap) {
          final f = snap.data;
          if (f == null) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStadiumVisual(),
                const SizedBox(height: 20),
                _stat(
                  "CAPACIDAD",
                  "${_effectiveCapacity > 0 ? _effectiveCapacity : widget.team.stadiumCapacity} espectadores",
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDEFF9A),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () async {
                    final ok = await widget.dbService.expandStadium();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          ok
                              ? 'Grada ampliada (+5.000 localidades).'
                              : 'Fondos insuficientes (2,5 M€).',
                        ),
                      ),
                    );
                    await _loadCapacity();
                  },
                  child: const Text('AMPLIAR GRADA (+5.000 · 2,5 M€)', style: TextStyle(fontWeight: FontWeight.w900)),
                ),
                _stat("INGRESO VALLAS / PARTIDO", "${f.sponsorIncomePerMatch.toStringAsFixed(0)} €"),
                const Divider(color: Colors.white10, height: 36),
                const Text("VALLAS PUBLICITARIAS", style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12)),
                const SizedBox(height: 12),
                _slot(context, f, 1, "LATERAL A", f.sponsorSlot1Brand, f.sponsorSlot1Income),
                _slot(context, f, 2, "LATERAL B", f.sponsorSlot2Brand, f.sponsorSlot2Income),
                _slot(context, f, 3, "FONDO NORTE", f.sponsorSlot3Brand, f.sponsorSlot3Income),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _slot(BuildContext context, ClubFinance f, int slot, String label, String brand, double income) {
    final empty = brand.isEmpty || brand == "VACÍO";
    return GestureDetector(
      onTap: () => _pickSponsor(context, f, slot),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: empty ? Colors.transparent : const Color(0xFFDEFF9A).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: empty ? Colors.white10 : const Color(0xFFDEFF9A).withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
              Text(empty ? "CONTRATAR" : brand, style: TextStyle(color: empty ? Colors.white24 : Colors.white, fontWeight: FontWeight.bold)),
            ]),
            Text("${income.toStringAsFixed(0)} €/p", style: TextStyle(color: empty ? Colors.white24 : const Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Future<void> _pickSponsor(BuildContext context, ClubFinance f, int slot) async {
    final picked = await showModalBottomSheet<_SponsorOption>(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      builder: (ctx) => ListView(
        padding: const EdgeInsets.all(16),
        children: _options
            .map((o) => ListTile(
                  title: Text(o.brand, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("${o.income} € por partido", style: const TextStyle(color: Colors.white54)),
                  onTap: () => Navigator.pop(ctx, o),
                ))
            .toList(),
      ),
    );
    if (picked == null) return;

    switch (slot) {
      case 1:
        f.sponsorSlot1Brand = picked.brand;
        f.sponsorSlot1Income = picked.income;
        break;
      case 2:
        f.sponsorSlot2Brand = picked.brand;
        f.sponsorSlot2Income = picked.income;
        break;
      case 3:
        f.sponsorSlot3Brand = picked.brand;
        f.sponsorSlot3Income = picked.income;
        break;
    }
    f.sponsorIncomePerMatch = f.sponsorSlot1Income + f.sponsorSlot2Income + f.sponsorSlot3Income;
    await widget.dbService.isar.writeTxn(() => widget.dbService.isar.clubFinances.put(f));
    if (mounted) setState(() {});
  }

  Widget _buildStadiumVisual() {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFF1e293b), Color(0xFF0f172a)]),
        border: Border.all(color: const Color(0xFFDEFF9A).withValues(alpha: 0.15)),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.futbol, size: 48, color: Color(0xFFDEFF9A)),
          SizedBox(height: 12),
          Text("CÉSPED: EXCELENTE", style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}
