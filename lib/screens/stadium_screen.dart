import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/database_service.dart';
import '../models/finance_model.dart';
import '../models/team.dart';

/// Modelo para representar un contrato de publicidad activo o en oferta
class SponsorContract {
  final String brand;
  final int vallasCount;
  final double incomePerMatch;
  int remainingWeeks;

  SponsorContract({
    required this.brand,
    required this.vallasCount,
    required this.incomePerMatch,
    required this.remainingWeeks,
  });

  // Serializa el contrato para guardarlo en las cadenas de texto de Isar
  // Formato: BRAND|VALLAS|INCOME|WEEKS
  String toRawString() => "$brand|$vallasCount|$incomePerMatch|$remainingWeeks";

  factory SponsorContract.fromRawString(String raw) {
    final parts = raw.split('|');
    return SponsorContract(
      brand: parts[0],
      vallasCount: int.parse(parts[1]),
      incomePerMatch: double.parse(parts[2]),
      remainingWeeks: int.parse(parts[3]),
    );
  }
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
  List<SponsorContract> _marketOffers = [];

  // Estado del césped por defecto (si Isar no tuviera campo específico, lo manejamos localmente)
  // NOTA: Para producción, lo ideal es mapear esto a un campo `f.pitchCondition` en Isar.
  // Como fallback temporal simulado que persiste durante la sesión, usamos esta variable:
  int _pitchCondition = 100; 

  static const int maxVallasLargo = 20; // Sectores Laterales
  static const int maxVallasAncho = 15; // Sector Fondo
  static const double costReplantar = 250000; // Coste de cambiar el césped: 250.000€

  // Banco de marcas para la generación aleatoria
  static const _brandsPool = ["NIKE", "ADIDAS", "PUMA", "COCA-COLA", "MOVISTAR", "MAHOU", "SANTANDER", "EMIRATES", "SONY", "REPSOL"];

  @override
  void initState() {
    super.initState();
    _loadCapacity();
    _generateMarketOffers();
  }

  Future<void> _loadCapacity() async {
    final cap = await widget.dbService.effectiveStadiumCapacity(widget.team);
    if (mounted) setState(() => _effectiveCapacity = cap);
  }

  /// Genera ofertas aleatorias variables tanto en vallas, ingresos y semanas de duración
  void _generateMarketOffers() {
    final random = Random();
    _marketOffers = List.generate(5, (_) {
      final brand = _brandsPool[random.nextInt(_brandsPool.length)];
      final vallas = random.nextInt(11) + 5; // Entre 5 y 15 vallas
      final weeks = random.nextInt(17) + 4;   // Entre 4 y 20 semanas de duración
      
      // El valor base por valla oscila aleatoriamente para obligar a calcular la mejor oferta
      final basePricePerValla = (random.nextInt(1500) + 1500).toDouble(); // 1500€ - 3000€
      final totalIncome = vallas * basePricePerValla;

      return SponsorContract(
        brand: brand,
        vallasCount: vallas,
        incomePerMatch: totalIncome,
        remainingWeeks: weeks,
      );
    });
  }

  // Parseadores helpers de persistencia para Isar
  List<SponsorContract> _parseContracts(String raw) {
    if (raw.isEmpty) return [];
    return raw.split(',').where((e) => e.isNotEmpty).map((e) => SponsorContract.fromRawString(e)).toList();
  }

  String _serializeContracts(List<SponsorContract> contracts) {
    return contracts.map((c) => c.toRawString()).join(',');
  }

  // Helper para obtener el estado visual del césped
  Map<String, dynamic> _getPitchStatus() {
    if (_pitchCondition >= 85) {
      return {'label': 'EXCELENTE', 'color': const Color(0xFFDEFF9A)};
    } else if (_pitchCondition >= 60) {
      return {'label': 'BUENO', 'color': Colors.greenAccent};
    } else if (_pitchCondition >= 35) {
      return {'label': 'REGULAR', 'color': Colors.orangeAccent};
    } else {
      return {'label': 'LAMENTABLE (Peligro de Sanción)', 'color': Colors.redAccent};
    }
  }

  /// Realiza la transacción económica para cambiar el césped deteriorado
  Future<void> _replantarCesped(ClubFinance f) async {
    // Verificamos si hay fondos suficientes (Usamos f.balance o el campo de presupuesto de tu modelo)
    // Suponiendo que f.balance contiene el dinero total actual del club:
    if ((f.balance ?? 0) < costReplantar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fondos insuficientes para replantar el césped (Necesitas 250.000 €).')),
      );
      return;
    }

    // Descontar presupuesto y resetear el césped
    f.balance = (f.balance ?? 0) - costReplantar;
    
    await widget.dbService.isar.writeTxn(() => widget.dbService.isar.clubFinances.put(f));
    
    setState(() {
      _pitchCondition = 100;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🌱 Césped replantado con éxito. Gastos extra: -250.000 €.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pitch = _getPitchStatus();

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: Text("ESTADIO: ${widget.team.stadium.toUpperCase()}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<ClubFinance?>(
        stream: widget.dbService.isar.clubFinances.watchObject(1, fireImmediately: true),
        builder: (context, snap) {
          final f = snap.data;
          if (f == null) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)));
          }

          final contratosLateralA = _parseContracts(f.sponsorSlot1Brand);
          final contratosLateralB = _parseContracts(f.sponsorSlot2Brand);
          final contratosFondo = _parseContracts(f.sponsorSlot3Brand);

          int vallasOcupadasA = contratosLateralA.fold(0, (sum, c) => sum + c.vallasCount);
          int vallasOcupadasB = contratosLateralB.fold(0, (sum, c) => sum + c.vallasCount);
          int vallasOcupadasFondo = contratosFondo.fold(0, (sum, c) => sum + c.vallasCount);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStadiumVisual(pitch['label'], pitch['color']),
                const SizedBox(height: 12),
                
                // Botón dinámico de mantenimiento del césped (Solo aparece si se ha desgastado)
                if (_pitchCondition < 100) ...[
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 44),
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.grass, size: 16, color: Colors.greenAccent),
                    onPressed: () => _replantarCesped(f),
                    label: const Text('REPLANTAR CÉSPED MIGRADO (-250.000 €)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                ],

                _stat(
                  "CAPACIDAD",
                  "${_effectiveCapacity > 0 ? _effectiveCapacity : widget.team.stadiumCapacity} espectadores",
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDEFF9A),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () async {
                    final ok = await widget.dbService.expandStadium();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(ok ? 'Grada ampliada (+5.000 localidades).' : 'Fondos insuficientes (2,5 M€).')),
                    );
                    await _loadCapacity();
                  },
                  child: const Text('AMPLIAR GRADA (+5.000 · 2,5 M€)', style: TextStyle(fontWeight: FontWeight.w900)),
                ),
                const SizedBox(height: 10),
                _stat("TOTAL INGRESOS VALLAS / PARTIDO", "${f.sponsorIncomePerMatch.toStringAsFixed(0)} €"),
                const Divider(color: Colors.white10, height: 36),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "PLANIFICACIÓN DE SECTORES", 
                        style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                      icon: const Icon(Icons.refresh_rounded, size: 16),
                      label: const Text("SIMULAR SEMANA", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      onPressed: () => _simulateWeekElapsed(f),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                
                _interactiveSector(
                  context: context,
                  finance: f,
                  slotIndex: 1,
                  sectorName: "LATERAL A (LARGO)",
                  maxVallas: maxVallasLargo,
                  vallasOcupadas: vallasOcupadasA,
                  contratos: contratosLateralA,
                ),
                _interactiveSector(
                  context: context,
                  finance: f,
                  slotIndex: 2,
                  sectorName: "LATERAL B (LARGO)",
                  maxVallas: maxVallasLargo,
                  vallasOcupadas: vallasOcupadasB,
                  contratos: contratosLateralB,
                ),
                _interactiveSector(
                  context: context,
                  finance: f,
                  slotIndex: 3,
                  sectorName: "FONDO NORTE (ANCHO)",
                  maxVallas: maxVallasAncho,
                  vallasOcupadas: vallasOcupadasFondo,
                  contratos: contratosFondo,
                ),
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

  Widget _interactiveSector({
    required BuildContext context,
    required ClubFinance finance,
    required int slotIndex,
    required String sectorName,
    required int maxVallas,
    required int vallasOcupadas,
    required List<SponsorContract> contratos,
  }) {
    final int espacioLibre = maxVallas - vallasOcupadas;
    final double sectorIncome = contratos.fold(0, (sum, c) => sum + c.incomePerMatch);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: espacioLibre == 0 ? Colors.white10 : const Color(0xFFDEFF9A).withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectorName, style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.w900, fontSize: 12)),
              Text("$vallasOcupadas / $maxVallas Vallas", style: TextStyle(color: espacioLibre == 0 ? Colors.greenAccent : Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          if (contratos.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text("Sector disponible. Sin vallas contratadas.", style: TextStyle(color: Colors.white24, fontSize: 11)),
            )
          else
            Column(
              children: contratos.map((c) => Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.02), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${c.brand} (${c.vallasCount} ud)", style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    Text("${c.incomePerMatch.toStringAsFixed(0)} €/p", style: const TextStyle(color: Colors.white70, fontSize: 11)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: c.remainingWeeks <= 2 ? Colors.red.withValues(alpha: 0.2) : Colors.white10, borderRadius: BorderRadius.circular(4)),
                      child: Text("${c.remainingWeeks} sem", style: TextStyle(color: c.remainingWeeks <= 2 ? Colors.redAccent : Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )).toList(),
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total: ${sectorIncome.toStringAsFixed(0)} €/p", style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: const Color(0xFFDEFF9A)),
                onPressed: espacioLibre <= 0 ? null : () => _showMarketNegotiation(context, finance, slotIndex, espacioLibre),
                icon: const Icon(Icons.add_box_outlined, size: 16),
                label: Text("VER MERCADO (Libre: $espacioLibre)", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Despliega el mercado de ofertas dinámicas calculadas en tiempo real
  Future<void> _showMarketNegotiation(BuildContext context, ClubFinance f, int slot, int espacioDisponible) async {
    final picked = await showModalBottomSheet<SponsorContract>(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text("OFERTAS DEL MERCADO (Libre: $espacioDisponible vallas)", 
                    style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh_rounded, color: Color(0xFFDEFF9A), size: 18),
                  onPressed: () {
                    setState(() => _generateMarketOffers());
                    Navigator.pop(ctx);
                    _showMarketNegotiation(context, f, slot, espacioDisponible);
                  },
                )
              ],
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
              children: _marketOffers.map((o) {
                final bool cabe = o.vallasCount <= espacioDisponible;
                final double pricePerValla = o.incomePerMatch / o.vallasCount;
                return ListTile(
                  enabled: cabe,
                  leading: Icon(FontAwesomeIcons.rectangleAd, color: cabe ? const Color(0xFFDEFF9A) : Colors.white10),
                  title: Text(o.brand, style: TextStyle(color: cabe ? Colors.white : Colors.white24, fontWeight: FontWeight.bold)),
                  subtitle: Text("${o.vallasCount} vallas | ${o.incomePerMatch.toStringAsFixed(0)} €/partido\nDuración: ${o.remainingWeeks} semanas (${pricePerValla.toStringAsFixed(0)} €/valla)", 
                    style: TextStyle(color: cabe ? Colors.white54 : Colors.white10, fontSize: 12)),
                  trailing: Icon(Icons.check_circle_outline, color: cabe ? const Color(0xFFDEFF9A) : Colors.transparent),
                  onTap: () => Navigator.pop(ctx, o),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );

    if (picked == null) return;

    switch (slot) {
      case 1: {
        List<SponsorContract> current = _parseContracts(f.sponsorSlot1Brand);
        current.add(picked);
        f.sponsorSlot1Brand = _serializeContracts(current);
        f.sponsorSlot1Income += picked.incomePerMatch;
        break;
      }
      case 2: {
        List<SponsorContract> current = _parseContracts(f.sponsorSlot2Brand);
        current.add(picked);
        f.sponsorSlot2Brand = _serializeContracts(current);
        f.sponsorSlot2Income += picked.incomePerMatch;
        break;
      }
      case 3: {
        List<SponsorContract> current = _parseContracts(f.sponsorSlot3Brand);
        current.add(picked);
        f.sponsorSlot3Brand = _serializeContracts(current);
        f.sponsorSlot3Income += picked.incomePerMatch;
        break;
      }
    }

    f.sponsorIncomePerMatch = f.sponsorSlot1Income + f.sponsorSlot2Income + f.sponsorSlot3Income;
    
    await widget.dbService.isar.writeTxn(() => widget.dbService.isar.clubFinances.put(f));
    setState(() {
      _marketOffers.remove(picked); // Quitar oferta del mercado una vez aceptada
    });
  }

  /// Método de simulación para avanzar cronológicamente el fin de semana del gestor.
  /// Reduce el tiempo de vida de los contratos y además DEGRADARÁ EL CÉSPED.
  Future<void> _simulateWeekElapsed(ClubFinance f) async {
    List<SponsorContract> s1 = _parseContracts(f.sponsorSlot1Brand);
    List<SponsorContract> s2 = _parseContracts(f.sponsorSlot2Brand);
    List<SponsorContract> s3 = _parseContracts(f.sponsorSlot3Brand);

    // Decrementar semanas
    for (var c in s1) { c.remainingWeeks--; }
    for (var c in s2) { c.remainingWeeks--; }
    for (var c in s3) { c.remainingWeeks--; }

    // Filtrar contratos que ya expiraron
    s1.removeWhere((c) => c.remainingWeeks <= 0);
    s2.removeWhere((c) => c.remainingWeeks <= 0);
    s3.removeWhere((c) => c.remainingWeeks <= 0);

    // Recalcular ingresos por bloque
    f.sponsorSlot1Brand = _serializeContracts(s1);
    f.sponsorSlot1Income = s1.fold(0, (sum, c) => sum + c.incomePerMatch);

    f.sponsorSlot2Brand = _serializeContracts(s2);
    f.sponsorSlot2Income = s2.fold(0, (sum, c) => sum + c.incomePerMatch);

    f.sponsorSlot3Brand = _serializeContracts(s3);
    f.sponsorSlot3Income = s3.fold(0, (sum, c) => sum + c.incomePerMatch);

    f.sponsorIncomePerMatch = f.sponsorSlot1Income + f.sponsorSlot2Income + f.sponsorSlot3Income;

    await widget.dbService.isar.writeTxn(() => widget.dbService.isar.clubFinances.put(f));
    _generateMarketOffers(); // El mercado cambia completamente al iniciar nueva semana
    
    // MODIFICACIÓN: Deterioro aleatorio del césped entre 4% y 9% por semana simulada.
    final random = Random();
    final desgaste = random.nextInt(6) + 4; 

    if (mounted) {
      setState(() {
        _pitchCondition = max(0, _pitchCondition - desgaste);
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📅 Semana avanzada: Contratos actualizados y terreno de juego desgastado.')),
    );
  }

  Widget _buildStadiumVisual(String label, Color color) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFF1e293b), Color(0xFF0f172a)]),
        border: Border.all(color: const Color(0xFFDEFF9A).withValues(alpha: 0.15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(FontAwesomeIcons.futbol, size: 48, color: Color(0xFFDEFF9A)),
          const SizedBox(height: 12),
          Text(
            "CÉSPED: $label ($_pitchCondition%)", 
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)
          ),
        ],
      ),
    );
  }
}