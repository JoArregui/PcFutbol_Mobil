import 'package:isar/isar.dart';

part 'finance_model.g.dart';

@collection
class ClubFinance {
  Id id = Isar.autoIncrement;

  late double balance;         // Dinero en caja (Afectado por el crédito)
  late double transferBudget;  // Presupuesto para fichajes
  late double wageBill;        // Masa salarial actual
  late double maxWageBill;     // Límite de masa salarial impuesto por el club
  
  double ticketPrice = 20.0;
  double stadiumMaintenance = 50000.0;
  double sponsorIncomePerMatch = 0;

  String sponsorSlot1Brand = "";
  double sponsorSlot1Income = 0;
  String sponsorSlot2Brand = "";
  double sponsorSlot2Income = 0;
  String sponsorSlot3Brand = "";
  double sponsorSlot3Income = 0;

  /// Ampliación de grada (PC Fútbol 7 — obras en el estadio)
  int stadiumExtraCapacity = 0;

  // NUEVOS CAMPOS: Control de crédito bancario persistente
  double loanAmount = 0.0;     // Capital pendiente de devolución del préstamo
  int loanWeeks = 0;           // Semanas restantes para liquidar la deuda
}