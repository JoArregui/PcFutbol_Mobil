import 'package:flutter/material.dart';
import '../models/staff_member.dart';
import '../models/team.dart';
import '../core/database_service.dart';
import '../core/game_session_service.dart';
import '../core/staff_generator.dart';
import 'main_menu_screen.dart';

class StaffSelectionScreen extends StatefulWidget {
  final Team userTeam;
  final DatabaseService dbService;

  const StaffSelectionScreen({super.key, required this.userTeam, required this.dbService});

  @override
  State<StaffSelectionScreen> createState() => _StaffSelectionScreenState();
}

class _StaffSelectionScreenState extends State<StaffSelectionScreen> {
  Map<StaffRole, StaffMember?> selectedStaff = {
    StaffRole.secretario: null,
    StaffRole.preparador: null,
    StaffRole.medico: null,
  };

  void _showStaffPicker(StaffRole role) {
    final options = StaffGenerator.generateCandidates(role, count: 10);
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.92,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _roleTitle(role),
                      style: const TextStyle(
                        color: Color(0xFFDEFF9A),
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showStaffPicker(role);
                    },
                    icon: const Icon(Icons.refresh, color: Color(0xFFDEFF9A), size: 18),
                    label: const Text('OTROS', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '10 candidatos disponibles · Pulsa OTROS para generar nuevos',
                style: TextStyle(color: Colors.white38, fontSize: 10),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final staff = options[index];
                  return Card(
                    color: const Color(0xFF1e293b),
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        staff.name,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${'⭐' * staff.level}  ·  ${staff.salary.toStringAsFixed(0)} €/sem',
                              style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              staff.description,
                              style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.3),
                            ),
                          ],
                        ),
                      ),
                      trailing: const Icon(Icons.add_circle, color: Color(0xFFDEFF9A), size: 28),
                      onTap: () {
                        setState(() => selectedStaff[role] = staff);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _roleTitle(StaffRole role) {
    switch (role) {
      case StaffRole.secretario:
        return 'SECRETARIOS TÉCNICOS';
      case StaffRole.preparador:
        return 'PREPARADORES FÍSICOS';
      case StaffRole.medico:
        return 'JEFES DE SERVICIOS MÉDICOS';
      default:
        return 'CANDIDATOS';
    }
  }

  @override
  Widget build(BuildContext context) {
    final allSelected = !selectedStaff.values.contains(null);

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text("CONTRATACIÓN DE EMPLEADOS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Elige tu cuerpo técnico para ${widget.userTeam.name}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 8),
            const Text(
              "Cada puesto ofrece candidatos aleatorios con distinto nivel y salario",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white24, fontSize: 11),
            ),
            const SizedBox(height: 28),
            _buildStaffSlot("SECRETARIO TÉCNICO", StaffRole.secretario),
            _buildStaffSlot("PREPARADOR FÍSICO", StaffRole.preparador),
            _buildStaffSlot("MÉDICO", StaffRole.medico),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: allSelected ? const Color(0xFFDEFF9A) : Colors.white10,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: allSelected
                  ? () async {
                      final session = GameSessionService(widget.dbService.isar);
                      final staff = {
                        StaffRole.secretario: selectedStaff[StaffRole.secretario]!,
                        StaffRole.preparador: selectedStaff[StaffRole.preparador]!,
                        StaffRole.medico: selectedStaff[StaffRole.medico]!,
                      };
                      await session.startSeason(widget.userTeam, staff);
                      if (!context.mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainMenuScreen(
                            dbService: widget.dbService,
                            userTeam: widget.userTeam,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Text(
                "COMENZAR TEMPORADA",
                style: TextStyle(
                  color: allSelected ? Colors.black : Colors.white24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffSlot(String title, StaffRole role) {
    final staff = selectedStaff[role];
    return GestureDetector(
      onTap: () => _showStaffPicker(role),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: staff != null ? const Color(0xFFDEFF9A) : Colors.white10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(
                    staff?.name ?? "PUESTO VACANTE",
                    style: TextStyle(
                      color: staff != null ? Colors.white : Colors.white24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (staff != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${'⭐' * staff.level} · ${staff.description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white38, fontSize: 10),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              staff != null ? Icons.check_circle : Icons.person_add,
              color: staff != null ? const Color(0xFFDEFF9A) : Colors.white10,
            ),
          ],
        ),
      ),
    );
  }
}
