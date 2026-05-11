import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/player_model.dart';
import '../widgets/radar_chart.dart';
import '../core/database_service.dart';

class PlayerDetailScreen extends StatelessWidget {
  final Player player;
  final DatabaseService dbService; // Añadido para consistencia con la navegación

  const PlayerDetailScreen({
    super.key, 
    required this.player, 
    required this.dbService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: Text(
          player.name.toUpperCase(), 
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // SECCIÓN SUPERIOR: GRÁFICO DE RADAR
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Círculo de fondo decorativo
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFDEFF9A).withOpacity(0.02),
                      border: Border.all(color: const Color(0xFFDEFF9A).withOpacity(0.05), width: 2),
                    ),
                  ),
                  // El Gráfico de Radar
                  SizedBox(
                    width: 260,
                    height: 260,
                    child: CustomPaint(
                      painter: PlayerRadarChartPainter(stats: player.stats),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            
            // TARJETA DE INFORMACIÓN HÍBRIDA
            _buildInfoCard(),
            
            const SizedBox(height: 10),
            
            // BOTÓN DE ACCIÓN
            _buildActionButtons(context),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          // Media Global destacada con el estilo del anterior
          _rowInfo("Media Global", player.average.toStringAsFixed(1), isAverage: true),
          const Divider(color: Colors.white10, height: 30),
          
          _rowInfo("Posición", player.position),
          _rowInfo("Edad", "${player.age} Años"),
          _rowInfo("Personalidad", player.personality.name.toUpperCase()),
          
          const SizedBox(height: 15),
          const Divider(color: Colors.white10, height: 10),
          const SizedBox(height: 15),
          
          _rowInfo("Valor de Mercado", "${(player.marketValue / 1000000).toStringAsFixed(1)}M €"),
          _rowInfo("Ficha Anual", "${(player.salary / 1000).toStringAsFixed(0)}K €"),
        ],
      ),
    );
  }

  Widget _rowInfo(String label, String value, {bool isAverage = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label.toUpperCase(), 
            style: GoogleFonts.urbanist(
              color: Colors.white38, 
              fontSize: 12, 
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1
            )
          ),
          Text(
            value, 
            style: GoogleFonts.urbanist(
              color: isAverage ? const Color(0xFFDEFF9A) : Colors.white, 
              fontWeight: FontWeight.w900, 
              fontSize: isAverage ? 28 : 16
            )
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDEFF9A),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 65),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            onPressed: () {
              // Lógica de negociación
            },
            child: Text(
              "INICIAR NEGOCIACIÓN", 
              style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5)
            ),
          ),
        ],
      ),
    );
  }
}