import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../core/player_generator.dart';

class YouthService {
  final Isar isar;

  YouthService(this.isar);

  /// Recupera los futbolistas de la cantera pertenecientes a un equipo específico
  Future<List<Player>> getYouthSquad(int teamApiId) async {
    return await isar.players
        .filter()
        .teamApiIdEqualTo(teamApiId)
        .isYouthEqualTo(true)
        .findAll();
  }

  /// Genera y busca futbolistas para la cantera del club o del mercado general.
  /// Delega en [PlayerGenerator] para garantizar coherencia de posiciones,
  /// nombres y financiero con el resto del juego.
  Future<void> scoutYouth({required int teamApiId, required int count}) async {
    final newYouthPlayers = PlayerGenerator.generateYouthReplacements(
      teamApiId,
      count,
    );

    // Escritura en bloque dentro de la transacción de Isar
    await isar.writeTxn(() async {
      await isar.players.putAll(newYouthPlayers);
    });
  }

  /// Promociona un jugador de la cantera al primer equipo profesional
  Future<String> promoteToFirstTeam(Player player) async {
    if (!player.isYouth) return 'Este jugador ya forma parte del primer equipo.';

    player.isYouth = false;
    // Al promocionar, actualizamos su cláusula al estatus profesional de manera blindada
    player.buyoutClause = player.marketValue * 4.0;

    await isar.writeTxn(() async {
      await isar.players.put(player);
    });

    return '¡${player.name} ha sido promocionado exitosamente al primer equipo profesional!';
  }
}