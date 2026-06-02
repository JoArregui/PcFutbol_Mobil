import 'package:isar/isar.dart';
import '../models/editor_config.dart';
import '../models/player_model.dart';
class EditorService {
  final Isar isar;

  EditorService(this.isar);

  Future<EditorConfig> getConfig() async {
    var cfg = await isar.editorConfigs.get(1);
    cfg ??= EditorConfig()..id = 1;
    return cfg;
  }

  Future<void> saveConfig(EditorConfig cfg) async {
    cfg.id = 1;
    await isar.writeTxn(() => isar.editorConfigs.put(cfg));
  }

  Future<void> updatePlayer(Player player) async {
    await isar.writeTxn(() => isar.players.put(player));
  }

  Future<Player> createCustomPlayer(int teamApiId) async {
    final p = Player()
      ..name = 'Jugador Editor'
      ..teamApiId = teamApiId
      ..teamId = 'EDITOR'
      ..age = 24
      ..position = 'MID'
      ..stats = [70, 70, 70, 70, 70]
      ..marketValue = 2000000
      ..salary = 500000
      ..personality = Personality.professional
      ..contractYearsRemaining = 4
      ..nationality = 'ESP';
    await isar.writeTxn(() => isar.players.put(p));
    return p;
  }
}
