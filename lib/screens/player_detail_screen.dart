import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import '../widgets/radar_chart.dart';
import '../core/database_service.dart';
import '../core/finance_service.dart';
import 'transfer_negotiation_screen.dart';

class PlayerDetailScreen extends StatelessWidget {
  final Player player;
  final DatabaseService dbService;
  final Team userTeam;

  const PlayerDetailScreen({
    super.key,
    required this.player,
    required this.dbService,
    required this.userTeam,
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
          _rowInfo("Contrato", "${player.contractYearsRemaining} temporada(s)"),
          if (player.onLoanFromTeamApiId > 0)
            _rowInfo("Cesión", "Hasta jornada ${player.onLoanUntilMatchday}"),
          if (player.nationality.isNotEmpty) _rowInfo("Nacionalidad", player.nationality),
          if (player.age <= 20 && player.potential >= 88)
            _rowInfo("Perfil", "APUESTA DE FUTURO"),
          _rowInfo("Potencial", "${player.potential}"),
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
    final isOurs = player.teamApiId == userTeam.apiId && !player.isYouth;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        children: [
          if (player.injuredDays > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'LESIONADO — ${player.injuredDays} días',
                style: GoogleFonts.urbanist(color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),
          if (player.suspendedMatches > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'SANCIONADO — ${player.suspendedMatches} partido(s)',
                style: GoogleFonts.urbanist(color: Colors.amber, fontWeight: FontWeight.bold),
              ),
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDEFF9A),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 65),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            onPressed: isOurs
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransferNegotiationScreen(
                          player: player,
                          userTeam: userTeam,
                          dbService: dbService,
                        ),
                      ),
                    );
                  },
            child: Text(
              isOurs ? "EN TU PLANTILLA" : "NEGOCIAR FICHAJE",
              style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5),
            ),
          ),
          if (isOurs) ...[
            const SizedBox(height: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                side: const BorderSide(color: Colors.redAccent),
                minimumSize: const Size(double.infinity, 52),
              ),
              onPressed: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: const Color(0xFF0F172A),
                    title: const Text('Vender jugador', style: TextStyle(color: Colors.white)),
                    content: Text(
                      '¿Ceder a ${player.name} por ~${(player.marketValue * 0.85 / 1e6).toStringAsFixed(2)} M€?',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('CANCELAR')),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('VENDER', style: TextStyle(color: Color(0xFFDEFF9A))),
                      ),
                    ],
                  ),
                );
                if (ok != true || !context.mounted) return;
                final msg = await FinanceService(dbService.isar)
                    .sellPlayer(player, userTeam.apiId);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                if (msg.startsWith('Vendido')) Navigator.pop(context);
              },
              child: const Text('CEDER JUGADOR', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ],
      ),
    );
  }
}