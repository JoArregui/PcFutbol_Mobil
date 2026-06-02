import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:pcfutbol_2026/screens/staff_selection_screen.dart';
import '../core/database_service.dart';
import '../core/squad_service.dart';
import '../models/team.dart';

class TeamSelectionScreen extends StatefulWidget {
  final DatabaseService dbService;
  const TeamSelectionScreen({super.key, required this.dbService});

  @override
  State<TeamSelectionScreen> createState() => _TeamSelectionScreenState();
}

class _TeamSelectionScreenState extends State<TeamSelectionScreen> {
  Team? selectedTeam;
  bool _loadingSquad = false;

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
        actions: [
          // Botón de emergencia para forzar reconstrucción
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFDEFF9A)),
            onPressed: () => setState(() {}),
          )
        ],
      ),
      body: StreamBuilder<List<Team>>(
        // Añadimos .findAll() al stream para asegurar que la primera carga tenga datos
        stream: widget.dbService.isar.teams.where().watch(fireImmediately: true),
        builder: (context, snapshot) {
          // Si hay datos en el snapshot, los usamos directamente
          final teams = snapshot.data ?? [];

          // Log de depuración interno
          debugPrint("Snapshot State: ${snapshot.connectionState} | Teams: ${teams.length}");

          // Si el stream aún no tiene nada, pero sabemos por el log que la API terminó,
          // intentamos una lectura directa asíncrona como último recurso.
          if (teams.isEmpty) {
            return FutureBuilder<List<Team>>(
              future: widget.dbService.getAllTeams(),
              builder: (context, futureSnapshot) {
                if (futureSnapshot.hasData && futureSnapshot.data!.isNotEmpty) {
                  return _buildTeamList(futureSnapshot.data!);
                }
                return _buildLoadingState();
              },
            );
          }

          return _buildTeamList(teams);
        },
      ),
    );
  }

  Widget _buildTeamList(List<Team> teams) {
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
                      _buildLogo(team.logoUrl),
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
  }

  Widget _buildLogo(String url) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Image.network(
        url,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.shield, color: Colors.white24),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFFDEFF9A)),
          const SizedBox(height: 20),
          Text("CARGANDO LIGA...",
              style: GoogleFonts.urbanist(color: Colors.white, letterSpacing: 2)),
        ],
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
          onPressed: selectedTeam == null || _loadingSquad
              ? null
              : () async {
                  setState(() => _loadingSquad = true);
                  await SquadService.fromDatabase(widget.dbService).ensureSquad(selectedTeam!.apiId);
                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StaffSelectionScreen(
                        userTeam: selectedTeam!,
                        dbService: widget.dbService,
                      ),
                    ),
                  );
                  if (mounted) setState(() => _loadingSquad = false);
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDEFF9A),
            foregroundColor: Colors.black,
            disabledBackgroundColor: Colors.white10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Text(
              _loadingSquad ? 'CARGANDO PLANTILLA…' : 'TOMAR LAS RIENDAS',
              style: GoogleFonts.urbanist(
                  fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        ),
      ),
    );
  }
}