enum EventType { goal, card, substitution, injury, chance, comment }

class MatchEvent {
  final int minute;
  final String description;
  final EventType type;
  final bool isHomeTeam;
  final int? homeScore;
  final int? awayScore;
  final bool isFullTime;
  final int? playerId;
  final bool cardIsRed;
  final int injuryDays;

  MatchEvent({
    required this.minute,
    required this.description,
    required this.type,
    this.isHomeTeam = true,
    this.homeScore,
    this.awayScore,
    this.isFullTime = false,
    this.playerId,
    this.cardIsRed = false,
    this.injuryDays = 0,
  });
}
