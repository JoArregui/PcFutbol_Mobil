import 'package:isar/isar.dart';

part 'league_fixture.g.dart';

@collection
class LeagueFixture {
  Id id = Isar.autoIncrement;

  @Index()
  late int matchday;

  late int homeTeamApiId;
  late int awayTeamApiId;
  bool played = false;
  int homeGoals = 0;
  int awayGoals = 0;

  /// liga | copa
  String competition = 'liga';

  /// 0 en liga; 1–4 en copa
  int cupRound = 0;
}
