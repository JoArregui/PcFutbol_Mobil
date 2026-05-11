import 'package:isar/isar.dart';

part 'player_model.g.dart';

@collection
class Player {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String name;

  @Index()
  late String teamId;

  // NUEVO: Este es el que usaremos para filtrar las plantillas reales
  @Index()
  int? teamApiId;

  late int age;
  late String position;
  
  // Stats: [Velocidad, Tiro, Pase, Defensa, Físico]
  late List<int> stats;

  late double marketValue;
  late double salary;

  // Personalidad para el motor de negociación
  @enumerated
  late Personality personality;

  /// Getter para calcular la media global del jugador basada en sus stats
  double get average {
    if (stats.isEmpty) return 0.0;
    final total = stats.reduce((a, b) => a + b);
    return total / stats.length;
  }
}

enum Personality { ambitious, loyal, greedy, professional }  