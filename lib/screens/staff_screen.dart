import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/database_service.dart';
import '../core/staff_service.dart';
import '../models/staff.dart';
import '../models/staff_member.dart';
import '../models/team.dart';
import '../core/staff_generator.dart';

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
    {'id': 'coach',          'label': 'Secretario Técnico',   'icon': FontAwesomeIcons.userTie},
    {'id': 'assistant',      'label': 'Preparador Físico',    'icon': FontAwesomeIcons.users},
    {'id': 'physio',         'label': 'Médico',               'icon': FontAwesomeIcons.heartPulse},
    {'id': 'psychologist',   'label': 'Psicólogo Deportivo',  'icon': FontAwesomeIcons.brain},
    {'id': 'scout',          'label': 'Ojeador Jefe',         'icon': FontAwesomeIcons.eye},
    {'id': 'youth_director', 'label': 'Director de Cantera',  'icon': FontAwesomeIcons.graduationCap},
  ];

  StaffRole _toStaffRole(String roleId) {
    switch (roleId) {
      case 'coach':          return StaffRole.secretario;
      case 'assistant':      return StaffRole.preparador;
      case 'physio':         return StaffRole.medico;
      case 'psychologist':   return StaffRole.psicologo;
      case 'youth_director': return StaffRole.juvenil;
      default:               return StaffRole.secretario;
    }
  }

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
      (e) => e['id'] == role,
      orElse: () => {},
    );
    return found.isNotEmpty ? found['label'] : 'Staff';
  }

  // ─── Pantalla principal ───────────────────────────────────────────────────

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
                _buildBudgetBar(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: _availableRoles.length,
                    itemBuilder: (context, index) {
                      final roleMap    = _availableRoles[index];
                      final String roleId    = roleMap['id'];
                      final String roleLabel = roleMap['label'];
                      final IconData roleIcon = roleMap['icon'];

                      final Staff? assigned = _staff.cast<Staff?>().firstWhere(
                        (s) => s?.role == roleId,
                        orElse: () => null,
                      );

                      return assigned != null
                          ? _buildOccupiedSlot(assigned, roleIcon)
                          : _buildEmptySlot(roleId, roleLabel, roleIcon);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  // ─── Barra de presupuesto ─────────────────────────────────────────────────

  Widget _buildBudgetBar() {
    return Padding(
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
                const Text('COSTO MENSUAL TOTAL',
                    style: TextStyle(color: Colors.white38, fontSize: 10,
                        fontWeight: FontWeight.bold, letterSpacing: 1)),
                const SizedBox(height: 4),
                Text(
                  '\$${(_totalMonthlyCost / 1000).toStringAsFixed(0)}k / mes',
                  style: const TextStyle(color: Color(0xFFDEFF9A),
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('PRESUPUESTO CLUB',
                    style: TextStyle(color: Colors.white38, fontSize: 10,
                        fontWeight: FontWeight.bold, letterSpacing: 1)),
                const SizedBox(height: 4),
                Text(
                  '\$${(_currentBudget / 1000).toStringAsFixed(0)}k',
                  style: const TextStyle(color: Colors.white,
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── Slot ocupado ─────────────────────────────────────────────────────────

  Widget _buildOccupiedSlot(Staff staff, IconData icon) {
    return Card(
      color: const Color(0xFF0F172A),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: const Color(0xFFDEFF9A).withOpacity(0.3)),
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
                    style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 9,
                        fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                  const SizedBox(height: 2),
                  Text(staff.name,
                      style: const TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 15)),
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
                  tooltip: 'Mejorar nivel',
                  icon: const Icon(FontAwesomeIcons.chartLine,
                      color: Color(0xFFDEFF9A), size: 18),
                  onPressed: () => _trainStaff(staff),
                ),
                IconButton(
                  tooltip: 'Despedir',
                  icon: const Icon(FontAwesomeIcons.trashCan,
                      color: Colors.redAccent, size: 18),
                  onPressed: () => _fireStaff(staff),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── Slot vacío ───────────────────────────────────────────────────────────

  Widget _buildEmptySlot(String roleId, String label, IconData icon) {
    return Card(
      color: const Color(0xFF0F172A),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.white10),
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
        title: Text(label.toUpperCase(),
            style: const TextStyle(color: Colors.white38, fontSize: 10,
                fontWeight: FontWeight.bold, letterSpacing: 1)),
        subtitle: const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text('Puesto Vacante',
              style: TextStyle(color: Colors.white24, fontSize: 13,
                  fontWeight: FontWeight.w500)),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white10,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => _showCandidatesSheet(roleId),
          child: const Text('CONTRATAR',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
                  color: Color(0xFFDEFF9A))),
        ),
      ),
    );
  }

  // ─── Bottom sheet con candidatos ──────────────────────────────────────────

  Future<void> _showCandidatesSheet(String roleId) async {
    final staffRole  = _toStaffRole(roleId);
    final candidates = StaffGenerator.generateCandidates(staffRole, count: 6);

    await showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.65,
          maxChildSize: 0.92,
          minChildSize: 0.4,
          builder: (_, scrollCtrl) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.person_search_rounded,
                          color: Color(0xFFDEFF9A), size: 20),
                      const SizedBox(width: 10),
                      Text(
                        'CANDIDATOS — ${_getRoleDisplay(roleId).toUpperCase()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white10, height: 1),
                Expanded(
                  child: ListView.builder(
                    controller: scrollCtrl,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    itemCount: candidates.length,
                    itemBuilder: (_, i) {
                      final c = candidates[i];
                      final canAfford = _currentBudget >= c.salary;
                      return _buildCandidateTile(c, roleId, canAfford, ctx);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCandidateTile(
      StaffMember candidate, String roleId, bool canAfford, BuildContext sheetCtx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: canAfford
            ? const Color(0xFF1E293B)
            : Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: canAfford
              ? const Color(0xFFDEFF9A).withOpacity(0.2)
              : Colors.white10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name,
                      style: TextStyle(
                        color: canAfford ? Colors.white : Colors.white38,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${'⭐' * candidate.level}  ·  \$${(candidate.salary / 1000).toStringAsFixed(1)}k/mes',
                      style: TextStyle(
                        color: canAfford ? const Color(0xFFDEFF9A) : Colors.white24,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: canAfford ? const Color(0xFFDEFF9A) : Colors.white10,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: canAfford
                    ? () {
                        Navigator.pop(sheetCtx);
                        _hireCandidate(candidate, roleId);
                      }
                    : null,
                child: Text(
                  canAfford ? 'FICHAR' : 'SIN FONDOS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: canAfford ? Colors.black : Colors.white24,
                  ),
                ),
              ),
            ],
          ),
          if (candidate.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              candidate.description,
              style: const TextStyle(color: Colors.white38, fontSize: 11, height: 1.3),
            ),
          ],
        ],
      ),
    );
  }

  // ─── Acciones ─────────────────────────────────────────────────────────────

  Future<void> _hireCandidate(StaffMember candidate, String roleId) async {
    final finance = await widget.dbService.isar.clubFinances.get(1);
    if (!mounted) return;

    if (finance == null || finance.balance < candidate.salary) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No tienes suficiente presupuesto.')),
      );
      return;
    }

    final newStaff = Staff(
      name: candidate.name,
      role: roleId,
      level: candidate.level,
      salary: candidate.salary,
    );

    finance.balance -= candidate.salary;

    await widget.dbService.isar.writeTxn(() async {
      await widget.dbService.isar.staffs.put(newStaff);
      await widget.dbService.isar.clubFinances.put(finance);
    });

    await _staffService.syncGameSave();

    if (!mounted) return;
    await _load();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${candidate.name} contratado como ${_getRoleDisplay(roleId)}.')),
    );
  }

  Future<void> _trainStaff(Staff staff) async {
    if (staff.level >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este miembro ya está en el nivel máximo.')),
      );
      return;
    }

    final cost = staff.salary * 1.5;

    if (_currentBudget < cost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay fondos suficientes para el entrenamiento.')),
      );
      return;
    }

    final msg = await _staffService.trainStaff(staff, _currentBudget);
    if (!mounted) return;

    final finance = await widget.dbService.isar.clubFinances.get(1);
    if (!mounted) return;

    if (finance != null) {
      finance.balance -= cost;
      await widget.dbService.isar.writeTxn(
          () => widget.dbService.isar.clubFinances.put(finance));
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    await _load();
  }

  Future<void> _fireStaff(Staff staff) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('Confirmar despido',
            style: TextStyle(color: Colors.white)),
        content: Text(
          '¿Estás seguro de que quieres despedir a ${staff.name}?\nNo recibirá indemnización.',
          style: const TextStyle(color: Colors.white54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('CANCELAR',
                style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('DESPEDIR',
                style: TextStyle(color: Colors.redAccent,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final msg = await _staffService.fireStaff(staff);
      if (!mounted) return;
      await _load();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }
}