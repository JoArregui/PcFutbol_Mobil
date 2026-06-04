import 'package:isar/isar.dart';
import '../models/staff.dart';
import '../models/game_message.dart';
import '../core/message_service.dart';

class StaffService {
  final Isar isar;

  StaffService(this.isar);

  // ─── Sincronización con GameSave ─────────────────────────────────────────

  Future<void> syncGameSave() async {
    final save = await isar.gameSaves.get(1);
    if (save == null) return;

    final coach     = await isar.staffs.filter().roleEqualTo('coach').findFirst();
    final assistant = await isar.staffs.filter().roleEqualTo('assistant').findFirst();
    final physio    = await isar.staffs.filter().roleEqualTo('physio').findFirst();

    save.staffSecretaryName   = coach?.name       ?? '';
    save.staffSecretaryLevel  = coach?.level      ?? 0;
    save.staffPreparatorName  = assistant?.name   ?? '';
    save.staffPreparatorLevel = assistant?.level  ?? 0;
    save.staffMedicoName      = physio?.name      ?? '';
    save.staffMedicoLevel     = physio?.level     ?? 0;

    await isar.writeTxn(() => isar.gameSaves.put(save));
  }

  // ─── Consultas ────────────────────────────────────────────────────────────

  Future<List<Staff>> getStaff() async {
    return isar.staffs.where().findAll();
  }

  Future<Staff?> getByRole(String role) async {
    return isar.staffs.filter().roleEqualTo(role).findFirst();
  }

  // ─── Contratación ─────────────────────────────────────────────────────────

  Future<void> hireFromCandidate(Staff staff) async {
    await isar.writeTxn(() => isar.staffs.put(staff));

    await MessageService(isar).add(
      title: 'Contratación',
      body: 'Has contratado a ${staff.name} (${staff.roleDisplay}) — Nivel ${staff.level}.',
      type: MessageType.general,
    );

    await syncGameSave();
  }

  // ─── Entrenamiento ────────────────────────────────────────────────────────

  Future<String> trainStaff(Staff staff, double availableBudget) async {
    final trainingCost = staff.salary * 1.5;

    if (trainingCost > availableBudget) {
      return 'No tienes suficiente presupuesto para entrenar a ${staff.name}.';
    }

    if (staff.level >= 5) {
      return '${staff.name} ya está en el nivel máximo.';
    }

    staff.level  += 1;
    staff.salary  = staff.salary * 1.1;

    await isar.writeTxn(() => isar.staffs.put(staff));
    await syncGameSave();

    return '${staff.name} ha mejorado y ahora es Nivel ${staff.level}.';
  }

  // ─── Despido ──────────────────────────────────────────────────────────────

  Future<String> fireStaff(Staff staff) async {
    await isar.writeTxn(() => isar.staffs.delete(staff.id));
    await syncGameSave();

    await MessageService(isar).add(
      title: 'Despido',
      body: '${staff.name} ha abandonado el club.',
      type: MessageType.general,
    );

    return '${staff.name} ha sido despedido.';
  }
}