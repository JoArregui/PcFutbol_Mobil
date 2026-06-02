import 'package:isar/isar.dart';

part 'finance_model.g.dart';

@collection
class ClubFinance {
  Id id = Isar.autoIncrement;

  late double balance;         // Dinero en caja
  late double transferBudget;  // Presupuesto para fichajes
  late double wageBill;        // Masa salarial actual
  late double maxWageBill;     // Límite de masa salarial impuesto por el club (puede variar según el equipo)
  
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
}
