enum EventType { goal, card, substitution, injury, chance, comment }

class MatchEvent {
  final int minute;
  final String description;
  final EventType type;
  final bool isHomeTeam;

  MatchEvent({
    required this.minute,
    required this.description,
    required this.type,
    this.isHomeTeam = true,
  });
}