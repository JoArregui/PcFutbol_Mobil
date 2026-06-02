import 'package:isar/isar.dart';

part 'user_lineup.g.dart';

@collection
class UserLineup {
  Id id = 1;

  List<int> starterPlayerIds = [];

  /// Formación táctica estilo PC Fútbol: 4-4-2, 4-3-3, 3-5-2, 5-3-2
  String formation = '4-4-2';
}
