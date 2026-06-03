import 'dart:math';
import 'package:isar/isar.dart';
import '../models/staff.dart';
import '../models/game_save.dart';
import '../models/game_message.dart';
import '../core/message_service.dart';

class StaffService {
  final Isar isar;
  final _rng = Random();

  static const _firstNames = [
    'Iván', 'Sergio', 'Marcos', 'Álex', 'Pablo', 'Diego', 'Raúl', 'Hugo',
    'Adrián', 'Rubén', 'Jorge', 'Mario', 'Óscar', 'Víctor', 'Andrés',
    'Luis', 'Manuel', 'Antonio', 'José', 'Francisco', 'Javier', 'Juan',
    'Carlos', 'David', 'Daniel', 'Alejandro', 'Miguel', 'Fernando',
  ];
  static const _lastNames = [
    'García', 'López', 'Martínez', 'Sánchez', 'Fernández', 'Ruiz', 'Torres',
    'Díaz', 'Moreno', 'Jiménez', 'Navarro', 'Romero', 'Vega', 'Castro',
    'Herrera', 'Dimás', 'Cortés', 'Mendoza', 'Ramos', 'Álvarez', 'Gil',
    'Ortega', 'Rubio', 'Domínguez', 'Blanco', 'Suárez', 'Pérez', 'Jiménez',
  ];

  StaffService(this.isar);

  /// Sync the three core staff roles (coach, assistant, physio) to GameSave fields.
  Future<void> _syncGameSaveStaff() async {
    final save = await isar.gameSaves.get(1);
    if (save == null) return;

    // Isar genera por defecto 'staffs' para la clase 'Staff'. 
    // Si sigue fallando tras compilar, se debe verificar que esté añadida en la apertura de Isar.
    final coach = await isar.staffs.filter().roleEqualTo('coach').findFirst();
    final assistant = await isar.staffs.filter().roleEqualTo('assistant').findFirst();
    final physio = await isar.staffs.filter().roleEqualTo('physio').findFirst();

    save.staffSecretaryName = coach?.name ?? 'Sin asignar';
    save.staffSecretaryLevel = coach?.level ?? 1;
    save.staffPreparatorName = assistant?.name ?? 'Sin asignar';
    save.staffPreparatorLevel = assistant?.level ?? 1;
    save.staffMedicoName = physio?.name ?? 'Sin asignar';
    save.staffMedicoLevel = physio?.level ?? 1;

    await isar.writeTxn(() => isar.gameSaves.put(save));
  }

  Future<List<Staff>> getStaff() async {
    return await isar.staffs.where().findAll();
  }

  /// Hire a new staff member of the given role.
  /// Returns the hired staff or null if unable to hire (e.g., insufficient funds).
  Future<Staff?> hireStaff(String role, double availableBudget) async {
    // CORREGIDO: Se eliminó la variable local 'current' que no se usaba para limpiar el warning.
    final baseSalary = _getBaseSalaryForRole(role);
    final level = 1 + _rng.nextInt(3); // Start with level 1-3
    final salary = baseSalary * level; // Salary scales with level

    if (salary > availableBudget) {
      // Not enough budget
      return null;
    }

    final name = '${_firstNames[_rng.nextInt(_firstNames.length)]} '
        '${_lastNames[_rng.nextInt(_lastNames.length)]}';

    final staff = Staff(
      name: name,
      role: role,
      level: level,
      salary: salary,
    );

    await isar.writeTxn(() => isar.staffs.put(staff));

    // Notify
    await MessageService(isar).add(
      title: 'Contratación',
      body: 'Has contratado a un nuevo $role: ${staff.name} (Nivel ${staff.level}).',
      type: MessageType.general,
    );

    await _syncGameSaveStaff();
    return staff;
  }

  Future<String> fireStaff(Staff staff) async {
    await isar.writeTxn(() => isar.staffs.delete(staff.id));
    await _syncGameSaveStaff();
    return '${staff.name} ha sido despedido.';
  }

  /// Train a staff member to increase their level by 1.
  /// Cost is based on current level.
  Future<String> trainStaff(Staff staff, double availableBudget) async {
    final trainingCost = staff.level * 50000; // Example cost
    if (trainingCost > availableBudget) {
      return 'No tienes suficiente presupuesto para entrenar a este miembro del staff.';
    }

    staff.level += 1;
    staff.salary = staff.salary * 1.1; // Salary increase with level

    await isar.writeTxn(() => isar.staffs.put(staff));
    await _syncGameSaveStaff();

    return '${staff.name} ha sido entrenado y ahora es Nivel ${staff.level}.';
  }

  double _getBaseSalaryForRole(String role) {
    switch (role) {
      case 'coach':
        return 80000;
      case 'assistant':
        return 50000;
      case 'physio':
        return 40000;
      case 'scout':
        return 45000;
      default:
        return 30000;
    }
  }
}