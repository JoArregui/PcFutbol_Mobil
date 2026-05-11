import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/database_service.dart';
import '../models/team.dart';
import 'main_menu_screen.dart';

class TeamSelectionScreen extends StatefulWidget {
  final DatabaseService dbService;
  const TeamSelectionScreen({super.key, required this.dbService});

  @override
  State<TeamSelectionScreen> createState() => _TeamSelectionScreenState();
}

class _TeamSelectionScreenState extends State<TeamSelectionScreen> {
  Team? selectedTeam;
  late Future<List<Team>> _teamsFuture;

  @override
  void initState() {
    super.initState();
    _teamsFuture = widget.dbService.getAllTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: Text('ELIGE TU DESTINO',
            style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: const Color(0xFFDEFF9A),
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Team>>(
        future: _teamsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No se encontraron equipos sincronizados.", style: TextStyle(color: Colors.white)));
          }

          final teams = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final team = teams[index];
                    final isSelected = selectedTeam?.apiId == team.apiId;

                    return GestureDetector(
                      onTap: () => setState(() => selectedTeam = team),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFDEFF9A).withOpacity(0.1)
                              : Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? const Color(0xFFDEFF9A) : Colors.white10,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                team.logoUrl,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.shield, color: Colors.white24),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(team.name.toUpperCase(),
                                      style: GoogleFonts.urbanist(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800)),
                                  Text(team.stadium,
                                      style: GoogleFonts.urbanist(
                                          color: Colors.white38,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check_circle, color: Color(0xFFDEFF9A)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildConfirmButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: selectedTeam == null
              ? null
              : () {
                  // NAVEGACIÓN AL MENÚ PRINCIPAL ELIMINANDO EL HISTORIAL
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainMenuScreen(
                        userTeam: selectedTeam!,
                        dbService: widget.dbService,
                      ),
                    ),
                    (route) => false,
                  );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDEFF9A),
            foregroundColor: Colors.black,
            disabledBackgroundColor: Colors.white10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
          ),
          child: Text('TOMAR LAS RIENDAS',
              style: GoogleFonts.urbanist(
                  fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        ),
      ),
    );
  }
}