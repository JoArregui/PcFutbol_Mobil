import 'package:isar/isar.dart';
import '../models/game_message.dart';

class MessageService {
  final Isar isar;

  MessageService(this.isar);

  Future<void> add({
    required String title,
    required String body,
    MessageType type = MessageType.general,
  }) async {
    await isar.writeTxn(() => isar.gameMessages.put(GameMessage()
      ..createdAt = DateTime.now()
      ..title = title
      ..body = body
      ..type = type
      ..read = false));
  }

  Future<int> unreadCount() async {
    return await isar.gameMessages.filter().readEqualTo(false).count();
  }

  Future<void> markAllRead() async {
    final msgs = await isar.gameMessages.where().findAll();
    for (final m in msgs) {
      m.read = true;
    }
    await isar.writeTxn(() => isar.gameMessages.putAll(msgs));
  }
}
