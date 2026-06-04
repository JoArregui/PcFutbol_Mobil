import 'package:isar/isar.dart';
import '../models/game_save.dart';
import '../models/game_message.dart';
import 'message_service.dart';

/// Despido por 3 semanas consecutivas en números rojos (PC Fútbol 7).
class FinancialGuardService {
  final Isar isar;

  FinancialGuardService(this.isar);

  Future<void> afterMatchdayWeek(GameSave save, String clubName) async {
    final finance = await isar.clubFinances.get(1);
    if (finance == null) return;

    final messages = MessageService(isar);

    if (finance.balance < 0) {
      save.consecutiveRedWeeks++;
      await messages.add(
        title: 'Tesorería en rojo',
        body:
            'Semana ${save.consecutiveRedWeeks}/3 en números rojos. El presidente exige equilibrio inmediato.',
        type: MessageType.board,
      );
      if (save.consecutiveRedWeeks >= 3) {
        save.financiallyDismissed = true;
        await messages.add(
          title: 'DESPEDIDO',
          body:
              'El consejo de administración de $clubName te cesa por mala gestión económica (3 semanas en rojo).',
          type: MessageType.board,
        );
      }
    } else {
      save.consecutiveRedWeeks = 0;
    }

    await isar.writeTxn(() => isar.gameSaves.put(save));
  }
}
