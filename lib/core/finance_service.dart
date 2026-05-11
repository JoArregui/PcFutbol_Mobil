import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/finance_model.dart';

class FinanceService {
  final Isar isar;
  FinanceService(this.isar);

  Future<void> initFinances() async {
    // Usamos el getter generado por Isar: clubFinances
    if (await isar.clubFinances.count() == 0) {
      await isar.writeTxn(() async {
        await isar.clubFinances.put(ClubFinance()
          ..balance = 50000000.0 
          ..transferBudget = 25000000.0 
          ..wageBill = 12000000.0
          ..maxWageBill = 35000000.0);
      });
    }
  }

  Future<String> signPlayer(Player targetPlayer, double agreedPrice) async {
    final finance = await isar.clubFinances.get(1);

    if (finance == null) return "Error: No hay datos financieros.";
    if (finance.transferBudget < agreedPrice) return "Presupuesto insuficiente.";
    if (finance.wageBill + targetPlayer.salary > finance.maxWageBill) return "Límite salarial excedido.";

    await isar.writeTxn(() async {
      finance.transferBudget -= agreedPrice;
      finance.balance -= agreedPrice;
      finance.wageBill += targetPlayer.salary;
      await isar.clubFinances.put(finance);

      targetPlayer.teamId = "USER_TEAM"; 
      await isar.players.put(targetPlayer);
    });

    return "✅ ¡${targetPlayer.name} ya es parte de tu equipo!";
  }
}