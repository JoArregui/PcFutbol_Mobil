import 'package:isar/isar.dart';
import '../models/match_event.dart';
import '../models/player_model.dart';

/// Aplica lesiones y sanciones tras el partido; recupera días de lesión por jornada.
class MatchDisciplineService {
  final Isar isar;

  MatchDisciplineService(this.isar);

  Future<void> applyFromEvents(List<MatchEvent> events, int userTeamApiId) async {
    final toUpdate = <Player>[];

    for (final e in events) {
      if (e.playerId == null || e.playerId! <= 0) continue; 
      final p = await isar.players.get(e.playerId!);
      if (p == null || p.teamApiId != userTeamApiId) continue;

      if (e.type == EventType.injury && e.injuryDays > 0) {
        p.injuredDays = e.injuryDays;
        toUpdate.add(p);
      } else if (e.type == EventType.card) {
        if (e.cardIsRed) {
          p.suspendedMatches = 2;
        } else {
          p.suspendedMatches = (p.suspendedMatches > 0) ? 2 : 1;
        }
        toUpdate.add(p);
      }
    }

    if (toUpdate.isNotEmpty) {
      await isar.writeTxn(() => isar.players.putAll(toUpdate));
    }
  }

  /// -1 día de lesión a toda la plantilla del usuario (llamar cada jornada).
  Future<void> tickRecovery(int userTeamApiId) async {
    final squad = await isar.players.filter().teamApiIdEqualTo(userTeamApiId).findAll();
    var changed = false;
    for (final p in squad) {
      if (p.injuredDays > 0) {
        p.injuredDays--;
        changed = true;
      }
      if (p.suspendedMatches > 0) {
        p.suspendedMatches--;
        changed = true;
      }
    }
    if (changed) {
      await isar.writeTxn(() => isar.players.putAll(squad));
    }
  }
}
