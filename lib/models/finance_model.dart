import 'package:isar/isar.dart';

part 'finance_model.g.dart';

@collection
class ClubFinance {
  Id id = Isar.autoIncrement;

  late double balance;         // Dinero en caja
  late double transferBudget;  // Presupuesto para fichajes
  late double wageBill;        // Masa salarial actual
  late double maxWageBill;     // Límite salarial de la liga
}