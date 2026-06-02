import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/database_service.dart';
import '../core/league_service.dart';
import '../models/game_save.dart';
import '../models/team.dart';
import 'secretary_screen.dart';
import 'youth_academy_screen.dart';
import 'trophy_room_screen.dart';

class ClubManagementScreen extends StatelessWidget {
  final DatabaseService dbService;
  final Team team;

  const ClubManagementScreen({super.key, required this.dbService, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text("GESTIÓN DEL CLUB", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<GameSave?>(
        stream: dbService.isar.gameSaves.watchObject(1, fireImmediately: true),
        builder: (context, snapshot) {
          final save = snapshot.data;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildClubBanner(save),
              const SizedBox(height: 24),
              _buildMenuSection("CUERPO TÉCNICO"),
              _buildStaffTile(
                "SECRETARIO TÉCNICO",
                save?.staffSecretaryName ?? "—",
                save != null ? "⭐" * save.staffSecretaryLevel : "—",
              ),
              _buildStaffTile(
                "PREPARADOR FÍSICO",
                save?.staffPreparatorName ?? "—",
                save != null ? "⭐" * save.staffPreparatorLevel : "—",
              ),
              _buildStaffTile(
                "JEFE DE MÉDICOS",
                save?.staffMedicoName ?? "—",
                save != null ? "⭐" * save.staffMedicoLevel : "—",
              ),
              const SizedBox(height: 30),
              _buildMenuSection("DESARROLLO"),
              _buildActionTile(
                "CUIDAD DEPORTIVA / CANTERA",
                "Gestiona las futuras promesas del club.",
                FontAwesomeIcons.graduationCap,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => YouthAcademyScreen(dbService: dbService, team: team),
                    ),
                  );
                },
              ),
              _buildActionTile(
                "SECRETARÍA",
                "Mensajes del presidente y renovaciones.",
                FontAwesomeIcons.envelopeOpenText,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SecretaryScreen(dbService: dbService)),
                  );
                },
              ),
              const SizedBox(height: 30),
              _buildMenuSection("HISTORIAL"),
              _buildActionTile(
                "SALA DE TROFEOS",
                "Palmarés y logros del club.",
                FontAwesomeIcons.trophy,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TrophyRoomScreen(dbService: dbService, team: team),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildClubBanner(GameSave? save) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFDEFF9A).withOpacity(0.15), const Color(0xFF0F172A)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDEFF9A).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          if (team.logoUrl.isNotEmpty)
            Image.network(team.logoUrl, height: 56, errorBuilder: (_, __, ___) => const Icon(Icons.shield, size: 48, color: Color(0xFFDEFF9A))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(team.name.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
                Text(team.city, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                if (save != null)
                  FutureBuilder(
                    future: LeagueService(dbService.isar).getStanding(team.apiId),
                    builder: (context, stSnap) {
                      final pts = stSnap.data?.points ?? 0;
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Temporada en curso · $pts puntos",
                          style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Text(title, style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12)),
    );
  }

  Widget _buildStaffTile(String role, String name, String level) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role, style: const TextStyle(color: Colors.white38, fontSize: 10)),
              Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(level, style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildActionTile(String title, String sub, IconData icon, VoidCallback onTap) {
    return Card(
      color: const Color(0xFF1e293b),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFFDEFF9A), size: 20),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 11)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white24, size: 18),
      ),
    );
  }
}
