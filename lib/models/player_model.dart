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

  /// Días restantes de lesión (0 = apto)
  int injuredDays = 0;

  /// Partidos de sanción pendientes
  int suspendedMatches = 0;

  /// Jugador de cantera (no cuenta en plantilla profesional hasta promoción)
  bool isYouth = false;

  int contractYearsRemaining = 3;

  String nationality = 'ESP';

  /// Cedido a nosotros desde otro club (0 = no)
  int onLoanFromTeamApiId = 0;

  int onLoanUntilMatchday = 0;

  /// Nuestro jugador cedido a otro (0 = no)
  int loanedOutToTeamApiId = 0;

  int loanedOutUntilMatchday = 0;

  /// Jugador inventado por el motor local (no proviene de API).
  bool isGenerated = false;

  /// Marcador interno para apuestas jóvenes con progresión acelerada.
  bool isUnicorn = false;

  /// Techo de atributos (1–99). Las apuestas jóvenes suelen tener 88–99.
  int potential = 82;

  /// Getter para calcular la media global del jugador basada en sus stats
  double get average {
    if (stats.isEmpty) return 0.0;
    final total = stats.reduce((a, b) => a + b);
    return total / stats.length;
  }
}

enum Personality { ambitious, loyal, greedy, professional }  