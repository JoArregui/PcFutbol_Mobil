import 'package:isar/isar.dart';

part 'cup_fixture.g.dart';

@collection
class CupFixture {
  Id id = Isar.autoIncrement;

  /// 1 = octavos, 2 = cuartos, 3 = semifinal, 4 = final
  late int round;

  late int homeTeamApiId;
  late int awayTeamApiId;
  bool played = false;
  int homeGoals = 0;
  int awayGoals = 0;
}
