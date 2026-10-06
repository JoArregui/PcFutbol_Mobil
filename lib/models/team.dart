import 'package:isar/isar.dart';

part 'team.g.dart';

enum TeamTier {
  elite,        // Real Madrid, Barcelona
  top,          // Atlético, Real Sociedad, Sevilla, Betis, Villarreal
  upperMid,     // Valencia, Athletic, Celta, Osasuna
  midTable,     // Getafe, Rayo, Girona, Espanyol
  lowerMid,     // Almería, Granada, Cádiz
  relegation,   // Las Palmas, Mallorca, Leganés, etc.
}

@collection
class Team {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  final int apiId; 
  
  final String name;
  final String city;
  final String stadium;
  final int stadiumCapacity;
  final String logoUrl;
  int budget; // mutable: adjusted per season
  
  // Clasificación de la temporada anterior (1-20)
  int previousSeasonPosition = 10;
  
  // Media de calidad de la plantilla
  double squadAverageRating = 0.0;
  
  // Contadores para la composición de la plantilla inicial
  int initialRealPlayersCount = 0;
  int initialGeneratedPlayersCount = 0;

  Team({
    required this.apiId,
    required this.name,
    required this.city,
    required this.stadium,
    required this.stadiumCapacity,
    required this.logoUrl,
    required this.budget,
    this.previousSeasonPosition = 10,
    this.squadAverageRating = 0.0,
    this.initialRealPlayersCount = 0,
    this.initialGeneratedPlayersCount = 0,
  });

  /// Categoriza el equipo en un tier según su nombre/historia
  static TeamTier getTierForTeam(String teamName) {
    final lowerName = teamName.toLowerCase();
    
    // Tier Élite - Gigantes de España y Europa
    if (lowerName.contains('real madrid') || lowerName.contains('barcelona')) {
      return TeamTier.elite;
    }
    
    // Tier Top - Equipos que luchan por Champions y Europa League
    if (lowerName.contains('atlético') || 
        lowerName.contains('real sociedad') || 
        lowerName.contains('sevilla') || 
        lowerName.contains('betis') || 
        lowerName.contains('villarreal')) {
      return TeamTier.top;
    }
    
    // Tier Upper Mid - Equipos con historia que buscan Europa League
    if (lowerName.contains('valencia') || 
        lowerName.contains('athletic') || 
        lowerName.contains('celta') || 
        lowerName.contains('osasuna')) {
      return TeamTier.upperMid;
    }
    
    // Tier Mid Table - Equipos consolidados en Primera
    if (lowerName.contains('getafe') || 
        lowerName.contains('rayo') || 
        lowerName.contains('girona') || 
        lowerName.contains('espanyol')) {
      return TeamTier.midTable;
    }
    
    // Tier Lower Mid - Equipos que luchan por mantenerse
    if (lowerName.contains('almería') || 
        lowerName.contains('granada') || 
        lowerName.contains('cádiz')) {
      return TeamTier.lowerMid;
    }
    
    // Tier Relegation - Equipos recién ascendidos o con presupuesto limitado
    return TeamTier.relegation;
  }

  /// Devuelve la posición de la temporada anterior según el equipo
  static int _getPreviousSeasonPosition(String teamName) {
    final lowerName = teamName.toLowerCase();
    
    // Posiciones de la temporada 2023-2024 de La Liga como referencia
    if (lowerName.contains('real madrid')) return 1;
    if (lowerName.contains('barcelona')) return 2;
    if (lowerName.contains('atlético')) return 3;
    if (lowerName.contains('girona')) return 4;
    if (lowerName.contains('athletic')) return 5;
    if (lowerName.contains('real sociedad')) return 6;
    if (lowerName.contains('villarreal')) return 7;
    if (lowerName.contains('betis')) return 8;
    if (lowerName.contains('osasuna')) return 9;
    if (lowerName.contains('rayo')) return 10;
    if (lowerName.contains('sevilla')) return 11;
    if (lowerName.contains('celta')) return 12;
    if (lowerName.contains('valencia')) return 13;
    if (lowerName.contains('getafe')) return 14;
    if (lowerName.contains('espanyol')) return 15;
    if (lowerName.contains('almería')) return 16;
    if (lowerName.contains('granada')) return 17;
    if (lowerName.contains('cádiz')) return 18;
    if (lowerName.contains('las palmas')) return 19;
    if (lowerName.contains('mallorca')) return 20;
    
    return 10; // Por defecto
  }

  /// Calcula el presupuesto ajustado por posición anterior y media de plantilla
  static int calculateAdjustedBudget(int baseBudget, int previousPosition, double squadAverage) {
    // Ajuste por posición: mejor posición = más presupuesto
    double positionMultiplier = 1.0;
    if (previousPosition <= 4) {
      positionMultiplier = 1.3;
    } else if (previousPosition <= 8) positionMultiplier = 1.15;
    else if (previousPosition <= 12) positionMultiplier = 1.0;
    else if (previousPosition <= 17) positionMultiplier = 0.85;
    else positionMultiplier = 0.75;
    
    // Ajuste por media de plantilla: mejor media = más presupuesto
    double qualityMultiplier = 1.0;
    if (squadAverage >= 80) {
      qualityMultiplier = 1.25;
    } else if (squadAverage >= 75) qualityMultiplier = 1.1;
    else if (squadAverage >= 70) qualityMultiplier = 1.0;
    else if (squadAverage >= 65) qualityMultiplier = 0.9;
    else qualityMultiplier = 0.8;
    
    final adjustedBudget = (baseBudget * positionMultiplier * qualityMultiplier).round();
    return adjustedBudget;
  }

  /// Devuelve el presupuesto base según el tier del equipo (público para acceso desde servicios)
  static int getBaseBudgetForTier(TeamTier tier, String teamName) {
    final lowerName = teamName.toLowerCase();
    
    // Presupuestos específicos para equipos de élite
    if (lowerName.contains('real madrid')) return 220000000;
    if (lowerName.contains('barcelona')) return 200000000;
    
    switch (tier) {
      case TeamTier.elite:
        return 180000000;
      case TeamTier.top:
        if (lowerName.contains('atlético')) return 120000000;
        if (lowerName.contains('villarreal')) return 75000000;
        if (lowerName.contains('real sociedad')) return 70000000;
        if (lowerName.contains('sevilla')) return 65000000;
        return 60000000;
      case TeamTier.upperMid:
        if (lowerName.contains('athletic')) return 55000000;
        if (lowerName.contains('valencia')) return 48000000;
        if (lowerName.contains('osasuna')) return 38000000;
        return 40000000;
      case TeamTier.midTable:
        if (lowerName.contains('girona')) return 35000000;
        if (lowerName.contains('getafe')) return 30000000;
        return 28000000;
      case TeamTier.lowerMid:
        return 20000000;
      case TeamTier.relegation:
        return 15000000;
    }
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    final venue = json['venue'];
    final teamName = json['team']['name'] ?? "Equipo Desconocido";
    final tier = getTierForTeam(teamName);
    final previousPosition = _getPreviousSeasonPosition(teamName);
    final baseBudget = getBaseBudgetForTier(tier, teamName);
    // Presupuesto inicial sin ajuste de media (se actualizará después)
    final initialBudget = baseBudget;

    return Team(
      apiId: json['team']['id'],
      name: teamName,
      city: venue != null ? (venue['city'] ?? "Ciudad Desconocida") : "Ciudad Desconocida",
      stadium: venue != null ? (venue['name'] ?? "Estadio Genérico") : "Estadio Genérico",
      stadiumCapacity: venue != null ? (venue['capacity'] ?? 15000) : 15000,
      logoUrl: json['team']['logo'] ?? "",
      budget: initialBudget,
      previousSeasonPosition: previousPosition,
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
    final tier = getTierForTeam(name);
    
    // Expectativas específicas para equipos de élite
    if (lowerName.contains('real madrid')) {
      return {
        "objetivo": "Ganar La Liga, Champions League y llegar a la final de Copa.",
        "exigencia": "Máxima. Cualquier cosa que no sea ganar es un fracaso.",
      };
    }
    if (lowerName.contains('barcelona')) {
      return {
        "objetivo": "Ligar doble: Campeonato y Champions League.",
        "exigencia": "Máxima. La afición exige títulos cada temporada.",
      };
    }
    
    switch (tier) {
      case TeamTier.elite:
        return {
          "objetivo": "Ganar el campeonato y disputar la final de Champions.",
          "exigencia": "Crítica. Sin margen de error.",
        };
      case TeamTier.top:
        if (lowerName.contains('atlético')) {
          return {
            "objetivo": "Luchar por el título y clasificar para Champions League.",
            "exigencia": "Muy alta. Competir con los grandes es obligatorio.",
          };
        }
        if (lowerName.contains('villarreal')) {
          return {
            "objetivo": "Clasificar para Champions League y hacer una buena temporada europea.",
            "exigencia": "Alta. El equipo aspira a competir en Europa.",
          };
        }
        return {
          "objetivo": "Clasificación para Europa League y luchar por puestos de Champions.",
          "exigencia": "Alta. La afición demanda regularidad europea.",
        };
      case TeamTier.upperMid:
        if (lowerName.contains('athletic')) {
          return {
            "objetivo": "Luchar por Europa League y mantener la filosofía cantera.",
            "exigencia": "Alta. Tradición y competitividad deben ir de la mano.",
          };
        }
        if (lowerName.contains('osasuna')) {
          return {
            "objetivo": "Mantenerse en la mitad alta de la tabla y sorprender.",
            "exigencia": "Media-alta. La afición valora la entrega y el fútbol vistoso.",
          };
        }
        return {
          "objetivo": "Clasificar para Europa League o Conference League.",
          "exigencia": "Media. Aspirar a más cada temporada.",
        };
      case TeamTier.midTable:
        if (lowerName.contains('girona')) {
          return {
            "objetivo": "Repetir la gran temporada pasada y asentarse en la élite.",
            "exigencia": "Alta. El proyecto busca consolidarse.",
          };
        }
        return {
          "objetivo": "Mantenerse cómodamente en Primera División.",
          "exigencia": "Media. Estabilidad es la prioridad.",
        };
      case TeamTier.lowerMid:
        return {
          "objetivo": "Evitar el descenso y construir un futuro mejor.",
          "exigencia": "Media. Supervivencia y desarrollo.",
        };
      case TeamTier.relegation:
        return {
          "objetivo": "MANTENER LA CATEGORÍA por todos los medios.",
          "exigencia": "Vital. El descenso sería un duro golpe.",
        };
    }
  }
}