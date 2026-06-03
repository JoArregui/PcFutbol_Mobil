import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/finance_model.dart';
import '../models/game_save.dart';
import '../models/team.dart';

class FinanceService {
  final Isar isar;
  FinanceService(this.isar);

  /// Inicializa las finanzas de la partida basándose en el equipo elegido por el usuario
  Future<void> initFinances(Team userTeam) async {
    final double initialBalance = userTeam.budget.toDouble();
    final double initialTransfer = initialBalance * 0.5; // 50% para fichajes
    final double initialWageBill = initialBalance * 0.25; // 25% comprometido en fichas anuales
    final double maxWageBillAllowed = initialBalance * 0.70; // Límite de control financiero

    // Mantenimiento de estadio basado en su capacidad real (ej: 1.2€ por asiento al año)
    final double maintenance = userTeam.stadiumCapacity * 1.2;

    await isar.writeTxn(() async {
      await isar.clubFinances.put(ClubFinance()
        ..id = 1
        ..balance = initialBalance
        ..transferBudget = initialTransfer
        ..wageBill = initialWageBill
        ..maxWageBill = maxWageBillAllowed
        ..ticketPrice = 25.0
        ..stadiumMaintenance = maintenance
        ..sponsorIncomePerMatch = 45000.0 // Base fija de vallas publicitarias iniciales
        ..sponsorSlot1Brand = "Patrocinador Principal"
        ..sponsorSlot1Income = 120000.0
        ..sponsorSlot2Brand = "Valla Lateral"
        ..sponsorSlot2Income = 45000.0
        ..sponsorSlot3Brand = "Marcador Electrónico"
        ..sponsorSlot3Income = 60000.0
        ..stadiumExtraCapacity = 0
        ..loanAmount = 0.0
        ..loanWeeks = 0);
    });
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

  /// Nóminas del cuerpo técnico por jornada (estilo gestión PCF7) y amortización de créditos.
  Future<void> deductStaffAndWages(GameSave save) async {
    final finance = await isar.clubFinances.get(1);
    if (finance == null) return;

    final staffCost = (save.staffSecretaryLevel +
            save.staffPreparatorLevel +
            save.staffMedicoLevel) *
        12000.0;
    final weeklyWages = finance.wageBill / 38;

    // Calcular pago semanal de amortización si el club tiene deuda con el banco
    double weeklyLoanPayment = 0.0;
    if (finance.loanAmount > 0 && finance.loanWeeks > 0) {
      const double annualInterestRate = 0.10;
      double totalInterest = finance.loanAmount * (annualInterestRate * (finance.loanWeeks / 52));
      weeklyLoanPayment = (finance.loanAmount + totalInterest) / finance.loanWeeks;

      // Decrementar amortización en la base de datos
      finance.loanWeeks--;
      if (finance.loanWeeks <= 0) {
        finance.loanAmount = 0.0; // Préstamo totalmente pagado
        finance.loanWeeks = 0;
      } else {
        // Reducimos proporcionalmente el capital principal adeudado
        finance.loanAmount -= (finance.loanAmount / (finance.loanWeeks + 1));
      }
    }

    // Aplicar todos los gastos operativos del club al balance total
    finance.balance -= (staffCost + weeklyWages + weeklyLoanPayment);
    if (finance.balance < 0) {
      finance.balance = 0;
    }

    await isar.writeTxn(() => isar.clubFinances.put(finance));
  }
}