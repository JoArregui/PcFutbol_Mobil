import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/finance_model.dart';
import '../models/game_save.dart';

class FinanceService {
  final Isar isar;
  FinanceService(this.isar);

  Future<void> initFinances() async {
    if (await isar.clubFinances.count() == 0) {
      await isar.writeTxn(() async {
        await isar.clubFinances.put(ClubFinance()
          ..id = 1
          ..balance = 50000000.0
          ..transferBudget = 25000000.0
          ..wageBill = 12000000.0
          ..maxWageBill = 35000000.0
          ..ticketPrice = 25.0
          ..stadiumMaintenance = 45000.0
          ..sponsorIncomePerMatch = 0
          ..sponsorSlot1Brand = ""
          ..sponsorSlot1Income = 0
          ..sponsorSlot2Brand = ""
          ..sponsorSlot2Income = 0
          ..sponsorSlot3Brand = ""
          ..sponsorSlot3Income = 0);
      });
    }
  }

  Future<String> signPlayer(Player targetPlayer, double agreedPrice, int userTeamApiId) async {
    final finance = await isar.clubFinances.get(1);

    if (finance == null) return "Error: No hay datos financieros.";
    if (finance.transferBudget < agreedPrice) return "Presupuesto insuficiente.";
    if (finance.wageBill + targetPlayer.salary > finance.maxWageBill) {
      return "Límite salarial excedido.";
    }

    await isar.writeTxn(() async {
      finance.transferBudget -= agreedPrice;
      finance.balance -= agreedPrice;
      finance.wageBill += targetPlayer.salary;
      await isar.clubFinances.put(finance);

      targetPlayer.teamApiId = userTeamApiId;
      targetPlayer.teamId = "USER";
      if (targetPlayer.contractYearsRemaining < 1) {
        targetPlayer.contractYearsRemaining = 3;
      }
      await isar.players.put(targetPlayer);
    });

    return "✅ ¡${targetPlayer.name} ya es parte de tu equipo!";
  }

  Future<String> sellPlayer(Player player, int userTeamApiId) async {
    if (player.teamApiId != userTeamApiId || player.isYouth) {
      return "No puedes vender a este jugador.";
    }

    final pros = await isar.players
        .filter()
        .teamApiIdEqualTo(userTeamApiId)
        .isYouthEqualTo(false)
        .findAll();
    if (pros.length <= 16) {
      return "La directiva exige mínimo 16 jugadores en plantilla (como en PC Fútbol 7).";
    }

    final finance = await isar.clubFinances.get(1);
    if (finance == null) return "Error financiero.";

    final salePrice = player.marketValue * 0.85;

    await isar.writeTxn(() async {
      finance.balance += salePrice;
      finance.transferBudget += salePrice * 0.6;
      finance.wageBill = (finance.wageBill - player.salary).clamp(0, double.infinity);
      await isar.clubFinances.put(finance);
      await isar.players.delete(player.id);
    });

    return "Vendido por ${(salePrice / 1e6).toStringAsFixed(2)} M€.";
  }

  /// Nóminas del cuerpo técnico por jornada (estilo gestión PCF7).
  Future<void> deductStaffAndWages(GameSave save) async {
    final finance = await isar.clubFinances.get(1);
    if (finance == null) return;

    final staffCost = (save.staffSecretaryLevel +
            save.staffPreparatorLevel +
            save.staffMedicoLevel) *
        12000.0;
    final weeklyWages = finance.wageBill / 38;

    finance.balance -= staffCost + weeklyWages;
    if (finance.balance < 0) {
      finance.balance = 0;
    }

    await isar.writeTxn(() => isar.clubFinances.put(finance));
  }
}