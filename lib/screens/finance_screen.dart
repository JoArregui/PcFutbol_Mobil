import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../models/finance_model.dart';
import 'package:isar/isar.dart';

class FinanceScreen extends StatefulWidget {
  final DatabaseService dbService;
  const FinanceScreen({super.key, required this.dbService});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text("FINANZAS Y GESTIÓN", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<ClubFinance>>(
        stream: widget.dbService.isar.clubFinances.where().watch(fireImmediately: true),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)));
          }

          final finance = snapshot.data!.first;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SECCIÓN 1: BALANCE GENERAL (Tus Tiles originales mejorados)
                _sectionTitle("ESTADO DE CAJA"),
                _financeTile("Balance Total", finance.balance, Colors.white),
                _financeTile("Presupuesto Fichajes", finance.transferBudget, const Color(0xFFDEFF9A)),
                
                const SizedBox(height: 20),

                // SECCIÓN 2: GESTIÓN DE INGRESOS (Estilo PC Fútbol)
                _sectionTitle("GESTIÓN DE INGRESOS"),
                _managementCard(
                  label: "Precio de Entrada",
                  value: "${finance.ticketPrice.toStringAsFixed(0)}€",
                  icon: Icons.confirmation_number_outlined,
                  onEdit: () => _showPriceSlider(finance),
                ),
                _managementCard(
                  label: "Vallas Publicitarias",
                  value: "+ ${(finance.sponsorIncomePerMatch / 1000).toStringAsFixed(0)}k€ / part.",
                  icon: Icons.ad_units_outlined,
                  onEdit: () { /* Navegar a pantalla de Vallas */ },
                ),

                const SizedBox(height: 20),

                // SECCIÓN 3: GASTOS FIJOS
                _sectionTitle("GASTOS SEMANALES"),
                _financeTile("Sueldos Plantilla", finance.wageBill, Colors.orange, isSmall: true),
                _financeTile("Mant. Estadio", finance.stadiumMaintenance, Colors.redAccent, isSmall: true),
                
                const SizedBox(height: 30),
                Center(
                  child: Text("PROYECCIÓN PRÓXIMO PARTIDO: +${((finance.sponsorIncomePerMatch + 150000) / 1000).toStringAsFixed(0)}k €", 
                    style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 15),
      child: Text(title, style: const TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2)),
    );
  }

  Widget _financeTile(String label, double value, Color color, {bool isSmall = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(isSmall ? 15 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          Text("${(value / 1000000).toStringAsFixed(2)} M €", 
            style: TextStyle(color: color, fontSize: isSmall ? 18 : 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _managementCard({required String label, required String value, required IconData icon, required VoidCallback onEdit}) {
    return GestureDetector(
      onTap: onEdit,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B), // Un poco más claro para indicar acción
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFDEFF9A).withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFDEFF9A), size: 28),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.edit_note, color: Colors.white24),
          ],
        ),
      ),
    );
  }

  void _showPriceSlider(ClubFinance finance) {
    double tempPrice = finance.ticketPrice;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("AJUSTAR PRECIO ENTRADA", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("${tempPrice.toStringAsFixed(0)} €", style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 32, fontWeight: FontWeight.bold)),
              Slider(
                value: tempPrice,
                min: 5,
                max: 100,
                activeColor: const Color(0xFFDEFF9A),
                onChanged: (val) => setModalState(() => tempPrice = val),
              ),
              const Text("A mayor precio, menor asistencia de público.", style: TextStyle(color: Colors.white38, fontSize: 12)),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDEFF9A), minimumSize: const Size(double.infinity, 50)),
                onPressed: () async {
                  finance.ticketPrice = tempPrice;
                  await widget.dbService.isar.writeTxn(() => widget.dbService.isar.clubFinances.put(finance));
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
                child: const Text("GUARDAR CAMBIOS", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}