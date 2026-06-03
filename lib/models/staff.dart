import 'package:isar/isar.dart';

part 'staff.g.dart';

@collection
class Staff {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String name;

  @Index()
  late String role; // e.g., 'coach', 'assistant', 'physio', 'scout'

  late int level; // 1-10, affects performance
  late double salary; // monthly salary

  // Optional: contract years remaining
  int contractYearsRemaining = 2;

  // Optional: nationality
  String nationality = 'ESP';

  Staff({
    required this.name,
    required this.role,
    required this.level,
    required this.salary,
  });

  // Getter for role display
  String get roleDisplay {
    switch (role) {
      case 'coach':
        return 'Entrenador';
      case 'assistant':
        return 'Entrenador Assistente';
      case 'physio':
        return 'Fisioterapeuta';
      case 'scout':
        return 'Ojeador';
      default:
        return role;
    }
  }
}