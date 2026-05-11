import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pcfutbol_2026/screens/squad_screen.dart';
import '../core/database_service.dart';
import '../models/team.dart'; // Importante para el modelo Team
import 'training_screen.dart';
import 'player_search_screen.dart';
import 'finance_screen.dart';

class MainMenuScreen extends StatelessWidget {
  final DatabaseService dbService;
  final Team userTeam; // Parámetro del equipo seleccionado

  const MainMenuScreen({
    super.key, 
    required this.dbService, 
    required this.userTeam, // Requerido en el constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.network(
                'https://images.unsplash.com/photo-1574629810360-7efbbe195018?q=80&w=2000',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  _buildHeader(),
                  const SizedBox(height: 50),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        _menuCard(
                          context,
                          "PLANTILLA",
                          FontAwesomeIcons.users,
                          // CORRECCIÓN: Ahora pasamos 'team: userTeam'
                          () => _navigateTo(context, SquadScreen(team: userTeam, dbService: dbService)),
                        ),
                        _menuCard(
                          context,
                          "ENTRENO",
                          FontAwesomeIcons.dumbbell,
                          () => _navigateTo(context, TrainingScreen(dbService: dbService)),
                        ),
                        _menuCard(
                          context,
                          "FINANZAS",
                          FontAwesomeIcons.chartLine,
                          () => _navigateTo(context, FinanceScreen(dbService: dbService)),
                        ),
                        _menuCard(
                          context,
                          "MERCADO",
                          FontAwesomeIcons.handshake,
                          () => _navigateTo(context, PlayerSearchScreen(dbService: dbService)),
                        ),
                      ],
                    ),
                  ),
                  _buildBottomBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "PC FÚTBOL",
          style: TextStyle(
            color: Color(0xFFDEFF9A),
            fontSize: 42,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFDEFF9A),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "SEASON 2026",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              userTeam.name.toUpperCase(), // Nombre del equipo seleccionado
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.2
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _menuCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFFDEFF9A)),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFDEFF9A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "SIGUIENTE PARTIDO",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                "ESTADIO: ${userTeam.stadium.toUpperCase()}", // Estadio dinámico
                style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const Icon(Icons.play_arrow_rounded, color: Colors.black, size: 30),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}