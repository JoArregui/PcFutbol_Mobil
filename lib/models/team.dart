import 'package:isar/isar.dart';

part 'team.g.dart';

@collection
class Team {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  final int apiId; 
  
  final String name;
  final String city;
  final String stadium; // Este es el nombre del estadio
  final int stadiumCapacity; // NUEVO: Para gestionar ingresos y ampliaciones
  final String logoUrl;
  final int budget;

  Team({
    required this.apiId,
    required this.name,
    required this.city,
    required this.stadium,
    required this.stadiumCapacity,
    required this.logoUrl,
    required this.budget,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    final venue = json['venue']; // A veces viene en la raíz o dentro de 'team'
    final teamName = json['team']['name'] ?? "Equipo Desconocido";
    final lowerName = teamName.toLowerCase();

    // Asignamos el presupuesto inicial real basado en la categoría del club
    int initialBudget = 12500000; // Por defecto modesto
    if (lowerName.contains('madrid') || lowerName.contains('barcelon') || lowerName.contains('atlético')) {
      initialBudget = 150000000;
    } else if (lowerName.contains('valencia') || lowerName.contains('sevilla') || lowerName.contains('betis') || lowerName.contains('real sociedad')) {
      initialBudget = 45000000;
    }

    return Team(
      apiId: json['team']['id'],
      name: teamName,
      city: venue != null ? (venue['city'] ?? "Ciudad Desconocida") : "Ciudad Desconocida",
      stadium: venue != null ? (venue['name'] ?? "Estadio Genérico") : "Estadio Genérico",
      stadiumCapacity: venue != null ? (venue['capacity'] ?? 15000) : 15000,
      logoUrl: json['team']['logo'] ?? "",
      budget: initialBudget,
    );
  }

  /// Devuelve el presupuesto formateado con puntos en formato legible (ej: 150.000.000 €)
  @ignore
  String get formattedBudget {
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String mathFunc(Match match) => '${match[1]}.';
    return '${budget.toString().replaceAllMapped(reg, mathFunc)} €';
  }

  /// Getters dinámicos para las expectativas de la directiva y metas según el nivel del equipo
  @ignore
  Map<String, String> get expectations {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('madrid') || lowerName.contains('barcelon') || lowerName.contains('atlético')) {
      return {
        "objetivo": "Ganar el campeonato y disputar la final de Copa.",
        "exigencia": "Crítica. Sin margen de error.",
      };
    } else if (lowerName.contains('valencia') || lowerName.contains('sevilla') || lowerName.contains('betis') || lowerName.contains('real sociedad')) {
      return {
        "objetivo": "Clasificación para competiciones europeas.",
        "exigencia": "Alta. La afición demanda regularidad.",
      };
    } else {
      return {
        "objetivo": "Evitar el descenso y asentar el bloque.",
        "exigencia": "Media. Desarrollo y estabilidad financiera.",
      };
    }
  }
}