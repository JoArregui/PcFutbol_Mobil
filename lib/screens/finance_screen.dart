import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../models/finance_model.dart';
import 'package:isar/isar.dart';

class FinanceScreen extends StatelessWidget {
  final DatabaseService dbService;
  const FinanceScreen({super.key, required this.dbService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text("FINANZAS DEL CLUB", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // CORRECCIÓN: Usamos ClubFinance (singular) como argumento de tipo
      body: StreamBuilder<List<ClubFinance>>(
        // Escuchamos cambios en tiempo real
        stream: dbService.isar.clubFinances.where().watch(fireImmediately: true),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.red)));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)));
          }

          final finance = snapshot.data!.first;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _financeTile("Balance en Caja", finance.balance, Colors.white),
                _financeTile("Presupuesto Fichajes", finance.transferBudget, const Color(0xFFDEFF9A)),
                _financeTile("Masa Salarial", finance.wageBill, Colors.orange),
                _financeTile("Límite Salarial", finance.maxWageBill, Colors.redAccent),
                const Spacer(),
                const Text("ESTADO ECONÓMICO: ESTABLE", 
                  style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _financeTile(String label, double value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Text("${(value / 1000000).toStringAsFixed(1)} M €", 
            style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}