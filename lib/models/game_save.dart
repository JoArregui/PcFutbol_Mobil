import 'package:isar/isar.dart';

part 'game_save.g.dart';

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
}
