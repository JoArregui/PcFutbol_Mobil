import 'package:isar/isar.dart';

part 'league_standing.g.dart';

@collection
class LeagueStanding {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int teamApiId;

  int played = 0;
  int wins = 0;
  int draws = 0;
  int losses = 0;
  int goalsFor = 0;
  int goalsAgainst = 0;
  int points = 0;

  int get goalDifference => goalsFor - goalsAgainst;
}
