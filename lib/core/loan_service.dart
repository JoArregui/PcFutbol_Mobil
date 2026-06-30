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
    player.onLoanUntilMatchday = save.currentMatchday + matchdays;
    player.teamApiId = userTeamApiId;
    player.teamId = 'LOAN_IN';
    player.contractYearsRemaining = 1;

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
    player.loanedOutUntilMatchday = save.currentMatchday + matchdays;
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
    final all = await isar.players.where().findAll();
    final toUpdate = <Player>[];

    for (final p in all) {
      if (p.onLoanFromTeamApiId > 0 &&
          p.onLoanUntilMatchday > 0 &&
          currentMatchday >= p.onLoanUntilMatchday) {
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
      if (p.loanedOutToTeamApiId > 0 &&
          p.loanedOutUntilMatchday > 0 &&
          currentMatchday >= p.loanedOutUntilMatchday) {
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
