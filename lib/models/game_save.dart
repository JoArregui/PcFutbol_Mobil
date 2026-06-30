import 'package:isar/isar.dart';
import '../core/tactics_service.dart';

part 'game_save.g.dart';

/// Plan de partido por fases (ajustes automáticos según el minuto)
enum GamePhasePlan {
  early,       // 0-30 min
  mid,         // 31-60 min
  late,        // 61-75 min
  veryLate,    // 76-90 min
  ifWinning,   // Si vamos ganando
  ifLosing,    // Si vamos perdiendo
  ifDrawing    // Si vamos empatando
}

/// Tipo de requerimiento de la directiva
enum BoardRequirementType {
  signPlayer,        // Fichar un jugador con características específicas
  promoteYouth,      // Promover X canteranos al primer equipo
  reachPosition,     // Alcanzar posición X en liga en jornada Y
  winDerby,          // Ganar el derbi
  keepCleanSheets,   // Mantener X porterías a cero
  scoreGoals,        // Marcar X goles en Y partidos
  developPlayer      // Mejorar un jugador específico
}

/// Requerimiento específico de la directiva
@embedded
class BoardRequirement {
  @Enumerated(EnumType.name)
  late BoardRequirementType type;
  
  late String description;
  late int targetValue;
  int currentValue = 0;
  bool completed = false;
  DateTime? deadline;
  String? playerId;
}

/// Resultado de encuesta a la afición
@embedded
class FanSurvey {
  late int approvalRating; // 0-100
  late String favoritePlayer;
  late String mostCriticizedPlayer;
  late String feedback;
  late DateTime surveyDate;
}

@collection
class GameSave {
  Id id = 1;

  late int userTeamApiId;
  late int currentMatchday;
  int totalMatchdays = 38;

  late String staffSecretaryName;
  late int staffSecretaryLevel;
  late String staffPreparatorName;
  late int staffPreparatorLevel;
  late String staffMedicoName;
  late int staffMedicoLevel;

  bool seasonFinished = false;

  /// Número de temporada (1 = primera)
  int seasonNumber = 1;

  /// Copa del Rey: el usuario sigue vivo en el torneo
  bool inCup = true;

  /// Ronda actual de copa (1–4) o 0 si aún no ha jugado octavos
  int cupRound = 0;

  /// Trofeos conseguidos (texto descriptivo)
  List<String> trophies = [];

  /// Modo de partido: resultado | resumen (por defecto resumen, como PCF7)
  String matchMode = 'resumen';

  /// Semanas consecutivas en números rojos (despido a las 3)
  int consecutiveRedWeeks = 0;

  bool financiallyDismissed = false;

  /// Objetivo: acabar como máximo en esta posición (4 = top 4, 17 = salvación)
  int boardObjectiveMaxPosition = 10;

  late String boardObjectiveLabel;

  /// Prestamo scouts internacionales usados esta temporada
  int internationalScoutsUsed = 0;

  /// Día dentro de la semana de competición (1-7). El partido suele ser día 7.
  int currentDay = 1;

  /// Confianza de la directiva (0–100), revisada al cerrar cada jornada.
  int boardAcceptance = 75;

  /// Último informe del presidente tras cerrar jornada.
  late String boardLastFeedback;

  /// Acumulado histórico de jugadores `isGenerated` seleccionados
  /// en todas las convocatorias guardadas por el usuario.
  /// Sirve para decidir si la regla 70/30 debe seguir activa en
  /// jornadas posteriores a la primera.
  int lineupGeneratedPlayers = 0;

  /// Total histórico de jugadores (titulares + suplentes) seleccionados
  /// en todas las convocatorias guardadas por el usuario.
  int lineupTotalPlayers = 0;

  /// Focos de entrenamiento ya usados en el día actual.
  /// Se resetea automáticamente al avanzar de día en CalendarService.
  List<String> trainingFocusesUsedToday = [];

  /// Mentalidad del equipo
  @Enumerated(EnumType.name)
  TeamMentality teamMentality = TeamMentality.balanced;

  /// Intensidad del equipo
  @Enumerated(EnumType.name)
  TeamIntensity teamIntensity = TeamIntensity.normal;

  /// Estilo de juego
  @Enumerated(EnumType.name)
  TeamStyle teamStyle = TeamStyle.possession;

  // === NUEVOS CAMPOS PARA TÁCTICAS AVANZADAS ===

  /// Plan de partido por fases (ajustes automáticos)
  /// Mapa: phase -> (mentality, intensity, style)
  List<String> phasePlans = [];

  /// Formación principal por defecto
  String defaultFormation = '4-4-2';

  /// Si usar ajustes automáticos por fase
  bool useAutomaticPhaseAdjustments = false;

  // === NUEVOS CAMPOS PARA DIRECTIVA ===

  /// Requerimientos específicos de la directiva
  List<BoardRequirement> boardRequirements = [];

  /// Última encuesta a la afición
  FanSurvey? lastFanSurvey;

  /// Fecha de la última encuesta
  DateTime? lastSurveyDate;

  /// Número de derbis ganados esta temporada
  int derbiesWon = 0;

  /// Número de porterías a cero esta temporada
  int cleanSheets = 0;

  /// Jugador estrella elegido por la afición
  String? fanFavoritePlayerId;
}
