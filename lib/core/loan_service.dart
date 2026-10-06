import 'package:isar/isar.dart';
import '../models/game_save.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import '../models/game_message.dart';
import 'message_service.dart';
import 'press_service.dart';

class LoanService {
  final Isar isar;

  LoanService(this.isar);

  int _absoluteMatchday(GameSave save) {
    final total = save.totalMatchdays > 0 ? save.totalMatchdays : 38;
    return (save.seasonNumber - 1) * total + save.currentMatchday;
  }

  Future<String> loanInPlayer(
    Player player,
    int fromTeamApiId,
    int userTeamApiId,
    int matchdays,
  ) async {
    if (player.teamApiId != fromTeamApiId) return 'El jugador ya no está en ese club.';
    final save = await isar.gameSaves.get(1);
    if (save == null) return 'Sin partida activa.';

    player.onLoanFromTeamApiId = fromTeamApiId;
    // Jornada absoluta para que no se rompa al cambiar de temporada.
    player.onLoanUntilMatchday = _absoluteMatchday(save) + matchdays;
    // No corromper contrato: solo garantizar mínimo 1 año.
    if (player.contractYearsRemaining < 1) {
      player.contractYearsRemaining = 1;
    }
    player.teamApiId = userTeamApiId;
    player.teamId = 'LOAN_IN';

    await isar.writeTxn(() => isar.players.put(player));

    final from = await isar.teams.filter().apiIdEqualTo(fromTeamApiId).findFirst();
    await PressService(isar).publishTransferNews(
      'Cesión',
      '${player.name} llega cedido desde ${from?.name ?? "otro club"} por $matchdays jornadas.',
    );
    return 'Cesión completada.';
  }

  Future<String> loanOutPlayer(
    Player player,
    Team toTeam,
    int userTeamApiId,
    int matchdays,
  ) async {
    if (player.teamApiId != userTeamApiId || player.isYouth) {
      return 'No puedes ceder a este jugador.';
    }
    final save = await isar.gameSaves.get(1);
    if (save == null) return 'Sin partida activa.';

    player.loanedOutToTeamApiId = toTeam.apiId;
    player.loanedOutUntilMatchday = _absoluteMatchday(save) + matchdays;
    player.teamApiId = toTeam.apiId;
    player.teamId = 'LOAN_OUT';

    await isar.writeTxn(() => isar.players.put(player));
    await PressService(isar).publishTransferNews(
      'Cesión salida',
      '${player.name} juega cedido en ${toTeam.name}.',
    );
    return 'Cedido a ${toTeam.name}.';
  }

  Future<void> tickLoanContracts(int userTeamApiId, int currentMatchday) async {
    // currentMatchday puede ser relativo (1-38); lo convertimos a absoluto
    // usando la temporada actual para comparar con vencimientos absolutos.
    // Compatibilidad con partidas viejas que guardaban jornada relativa:
    // si el vencimiento es <=38 y currentMatchday es absoluto grande, se
    // considera vencido.
    final save = await isar.gameSaves.get(1);
    final total = (save?.totalMatchdays ?? 0) > 0 ? save!.totalMatchdays : 38;
    final season = save?.seasonNumber ?? 1;
    final absoluteNow = (season - 1) * total + currentMatchday;
    final all = await isar.players.where().findAll();
    final toUpdate = <Player>[];

    bool isExpired(int until) {
      if (until <= 0) return false;
      if (until == absoluteNow || absoluteNow >= until) {
        // Caso normal: vencimiento absoluto alcanzado.
        // Caso legacy: until relativo (<=38) y ya estamos en temporada
        // posterior (absoluteNow > 38) -> también vencido.
        return true;
      }
      // Legacy: until relativo y seguimos en temporada 1.
      if (until <= total && season == 1 && currentMatchday >= until) return true;
      return false;
    }

    for (final p in all) {
      if (p.onLoanFromTeamApiId > 0 && isExpired(p.onLoanUntilMatchday)) {
        p.teamApiId = p.onLoanFromTeamApiId;
        p.teamId = 'API';
        p.onLoanFromTeamApiId = 0;
        p.onLoanUntilMatchday = 0;
        toUpdate.add(p);
        await MessageService(isar).add(
          title: 'Fin de cesión',
          body: '${p.name} vuelve a su club propietario.',
          type: MessageType.transfer,
        );
      }
      if (p.loanedOutToTeamApiId > 0 && isExpired(p.loanedOutUntilMatchday)) {
        p.teamApiId = userTeamApiId;
        p.teamId = 'USER';
        p.loanedOutToTeamApiId = 0;
        p.loanedOutUntilMatchday = 0;
        toUpdate.add(p);
        await MessageService(isar).add(
          title: 'Regresa de cesión',
          body: '${p.name} vuelve a tu plantilla.',
          type: MessageType.transfer,
        );
      }
    }

    if (toUpdate.isNotEmpty) {
      await isar.writeTxn(() => isar.players.putAll(toUpdate));
    }
  }
}
