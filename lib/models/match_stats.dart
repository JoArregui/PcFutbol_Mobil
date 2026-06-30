import 'package:isar/isar.dart';

/// Estadísticas de un jugador en un partido
class PlayerMatchStats {
  final Id playerId;
  final String playerName;
  final String position;
  final int minutesPlayed;
  final int goals;
  final int assists;
  final int yellowCards;
  final bool redCard;
  final double rating; // 0-10
  final int saves; // para porteros
  final int shotsOnTarget;

  PlayerMatchStats({
    required this.playerId,
    required this.playerName,
    required this.position,
    this.minutesPlayed = 0,
    this.goals = 0,
    this.assists = 0,
    this.yellowCards = 0,
    this.redCard = false,
    this.rating = 6.0,
    this.saves = 0,
    this.shotsOnTarget = 0,
  });

  /// Actualiza las estadísticas con un evento y devuelve una nueva instancia
  PlayerMatchStats copyWith({
    int? goals,
    int? yellowCards,
    bool? redCard,
    double? rating,
    int? shotsOnTarget,
  }) {
    return PlayerMatchStats(
      playerId: playerId,
      playerName: playerName,
      position: position,
      minutesPlayed: minutesPlayed,
      goals: goals ?? this.goals,
      assists: assists,
      yellowCards: yellowCards ?? this.yellowCards,
      redCard: redCard ?? this.redCard,
      rating: rating ?? this.rating,
      saves: saves,
      shotsOnTarget: shotsOnTarget ?? this.shotsOnTarget,
    );
  }
}

/// Estadísticas completas de un partido
class FullMatchStats {
  final int homeGoals;
  final int awayGoals;
  final int homeShots;
  final int awayShots;
  final int homeShotsOnTarget;
  final int awayShotsOnTarget;
  final int homeCorners;
  final int awayCorners;
  final int homeFouls;
  final int awayFouls;
  final int homeOffsides;
  final int awayOffsides;
  final int homeYellowCards;
  final int awayYellowCards;
  final int homeRedCards;
  final int awayRedCards;
  final List<PlayerMatchStats> homePlayerStats;
  final List<PlayerMatchStats> awayPlayerStats;

  FullMatchStats({
    this.homeGoals = 0,
    this.awayGoals = 0,
    this.homeShots = 0,
    this.awayShots = 0,
    this.homeShotsOnTarget = 0,
    this.awayShotsOnTarget = 0,
    this.homeCorners = 0,
    this.awayCorners = 0,
    this.homeFouls = 0,
    this.awayFouls = 0,
    this.homeOffsides = 0,
    this.awayOffsides = 0,
    this.homeYellowCards = 0,
    this.awayYellowCards = 0,
    this.homeRedCards = 0,
    this.awayRedCards = 0,
    required this.homePlayerStats,
    required this.awayPlayerStats,
  });

  /// Obtiene el jugador mejor valorado del partido
  PlayerMatchStats? get manOfTheMatch {
    final allPlayers = [...homePlayerStats, ...awayPlayerStats];
    if (allPlayers.isEmpty) return null;
    allPlayers.sort((a, b) => b.rating.compareTo(a.rating));
    return allPlayers.first;
  }
}
