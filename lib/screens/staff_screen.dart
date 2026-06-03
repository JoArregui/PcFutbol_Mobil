import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/database_service.dart';
import '../core/staff_service.dart';
import '../models/staff.dart';
import '../models/finance_model.dart';
import '../models/team.dart';

class StaffScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team team;

  const StaffScreen({super.key, required this.dbService, required this.team});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  late final StaffService _staffService;
  List<Staff> _staff = [];
  bool _loading = true;
  double _totalMonthlyCost = 0;
  double _currentBudget = 0;

  final List<Map<String, dynamic>> _availableRoles = [
    {'id': 'coach', 'label': 'Secretario Técnico', 'icon': FontAwesomeIcons.userTie},
    {'id': 'assistant', 'label': 'Preparador Físico', 'icon': FontAwesomeIcons.users},
    {'id': 'physio', 'label': 'Médico', 'icon': FontAwesomeIcons.heartPulse},
    {'id': 'psychologist', 'label': 'Psicólogo Deportivo', 'icon': FontAwesomeIcons.brain},
    {'id': 'scout', 'label': 'Ojeador Jefe', 'icon': FontAwesomeIcons.eye},
    {'id': 'youth_director', 'label': 'Director de Cantera', 'icon': FontAwesomeIcons.graduationCap},
  ];

  @override
  void initState() {
    super.initState();
    _staffService = StaffService(widget.dbService.isar);
    _load();
  }

  Future<void> _load() async {
    final staffList = await _staffService.getStaff();
    final finance = await widget.dbService.isar.clubFinances.get(1);

    double totalCost = 0;
    for (final s in staffList) {
      totalCost += s.salary;
    }

    if (mounted) {
      setState(() {
        _staff = staffList;
        _totalMonthlyCost = totalCost;
        _currentBudget = finance?.balance ?? 0.0;
        _loading = false;
      });
    }
  }

  String _getRoleDisplay(String role) {
    final found = _availableRoles.firstWhere(
      (element) => element['id'] == role,
      orElse: () => {},
    );
    return found.isNotEmpty ? found['label'] : 'Staff';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text(
          'GESTIÓN DEL CUERPO TÉCNICO',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'COSTO MENSUAL TOTAL',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${(_totalMonthlyCost / 1000).toStringAsFixed(0)}k / mes',
                              style: const TextStyle(
                                color: Color(0xFFDEFF9A),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'PRESUPUESTO CLUB',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${(_currentBudget / 1000).toStringAsFixed(0)}k',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: _availableRoles.length,
                    itemBuilder: (context, index) {
                      final roleMap = _availableRoles[index];
                      final String roleId = roleMap['id'];
                      final String roleLabel = roleMap['label'];
                      final IconData roleIcon = roleMap['icon'];

                      final Staff? assignedStaff = _staff.cast<Staff?>().firstWhere(
                        (s) => s?.role == roleId,
                        orElse: () => null,
                      );

                      if (assignedStaff != null) {
                        return _buildOccupiedSlot(assignedStaff, roleIcon);
                      } else {
                        return _buildEmptySlot(roleId, roleLabel, roleIcon);
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildOccupiedSlot(Staff staff, IconData icon) {
    return Card(
      color: const Color(0xFF0F172A),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: const Color(0xFFDEFF9A).withOpacity(0.3)), // ✅ 'side' en lugar de 'border'
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFFDEFF9A), size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getRoleDisplay(staff.role).toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFFDEFF9A),
                      fontSize: 9,
                      fontWeight: FontWeight.w900, // ✅ Corregido: w900 en lugar de black
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    staff.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${'⭐' * staff.level}   ·   \$${(staff.salary / 1000).toStringAsFixed(0)}k/mes',
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Entrenar Empleado',
                  icon: const Icon(FontAwesomeIcons.chartLine, color: Color(0xFFDEFF9A), size: 18),
                  onPressed: () => _trainStaff(staff),
                ),
                IconButton(
                  tooltip: 'Despedir',
                  icon: const Icon(FontAwesomeIcons.trashCan, color: Colors.redAccent, size: 18),
                  onPressed: () => _fireStaff(staff),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySlot(String roleId, String label, IconData icon) {
    return Card(
      color: const Color(0xFF0F172A),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.white10), // ✅ 'side' en lugar de 'border'
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white24, size: 22),
        ),
        title: Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        subtitle: const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            'Puesto Vacante',
            style: TextStyle(color: Colors.white24, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white10,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => _executeHiring(roleId),
          child: const Text(
            'CONTRATAR',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFDEFF9A)),
          ),
        ),
      ),
    );
  }

  Future<void> _executeHiring(String roleStr) async {
    final newMember = await _staffService.hireStaff(roleStr, _currentBudget);

    if (!mounted) return;

    if (newMember != null) {
      final finance = await widget.dbService.isar.clubFinances.get(1);
      if (!mounted) return; // ✅ Guard tras segundo await

      if (finance != null) {
        finance.balance -= newMember.salary;
        await widget.dbService.isar.writeTxn(() async {
          await widget.dbService.isar.clubFinances.put(finance);
        });
      }

      await _load();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Has contratado a ${newMember.name} como ${_getRoleDisplay(newMember.role)}.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No tienes suficiente presupuesto para pagar el salario de este miembro.')),
      );
    }
  }

  Future<void> _trainStaff(Staff staff) async {
    if (staff.level >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este miembro ya se encuentra en el nivel máximo.')),
      );
      return;
    }

    final cost = staff.salary * 1.5;

    if (_currentBudget >= cost) {
      final resultMessage = await _staffService.trainStaff(staff, _currentBudget);
      if (!mounted) return; // ✅ Guard tras await

      final finance = await widget.dbService.isar.clubFinances.get(1);
      if (!mounted) return; // ✅ Guard tras segundo await

      if (finance != null) {
        finance.balance -= cost;
        await widget.dbService.isar.writeTxn(() async {
          await widget.dbService.isar.clubFinances.put(finance);
        });
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultMessage)),
      );
      await _load();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay fondos suficientes para financiar el entrenamiento.')),
      );
    }
  }

  Future<void> _fireStaff(Staff staff) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('Confirmar despido', style: TextStyle(color: Colors.white)),
        content: Text(
          '¿Estás seguro de que quieres despedir a ${staff.name}?',
          style: const TextStyle(color: Colors.white54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCELAR', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('DESPEDIR', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final resultMessage = await _staffService.fireStaff(staff);

      if (!mounted) return;
      await _load();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultMessage)),
      );
    }
  }
}