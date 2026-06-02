import 'package:isar/isar.dart';

part 'game_message.g.dart';

enum MessageType { match, transfer, training, board, general, press }

@collection
class GameMessage {
  Id id = Isar.autoIncrement;

  late DateTime createdAt;
  late String title;
  late String body;
  bool read = false;

  @enumerated
  late MessageType type;
}
