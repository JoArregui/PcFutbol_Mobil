import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/user_lineup.dart';

class LineupService {
  final Isar isar;

  LineupService(this.isar);

  static const int requiredStarters = 11;

  Future<UserLineup> getLineup() async {
    var lineup = await isar.userLineups.get(1);
    lineup ??= UserLineup()..id = 1;
    return lineup;
  }

  Future<List<Player>> getStarters(int teamApiId) async {
    final lineup = await getLineup();
    if (lineup.starterPlayerIds.length < requiredStarters) return [];

    final players = <Player>[];
    for (final pid in lineup.starterPlayerIds) {
      final p = await isar.players.get(pid);
      if (p != null &&
          p.injuredDays <= 0 &&
          p.suspendedMatches <= 0 &&
          !p.isYouth) {
        players.add(p);
      }
    }
    return players;
  }

  Future<String> getFormation() async {
    final lineup = await getLineup();
    return lineup.formation;
  }

  Future<void> saveFormation(String formation) async {
    final lineup = await getLineup();
    lineup.formation = formation;
    await isar.writeTxn(() => isar.userLineups.put(lineup));
  }

  Future<bool> hasValidLineup(int teamApiId) async {
    final starters = await getStarters(teamApiId);
    if (starters.length != requiredStarters) return false;
    return starters.any((p) => p.position == 'GK');
  }

  Future<void> saveLineup(List<int> playerIds, {String? formation}) async {
    final current = await getLineup();
    final lineup = UserLineup()
      ..id = 1
      ..starterPlayerIds = playerIds
      ..formation = formation ?? current.formation;
    await isar.writeTxn(() => isar.userLineups.put(lineup));
  }

  /// Mejor 11 automático al estilo PCF7 (1 portero + mejores por línea).
  Future<void> autoPickBest11(int teamApiId) async {
    final all = await isar.players
        .filter()
        .teamApiIdEqualTo(teamApiId)
        .isYouthEqualTo(false)
        .findAll();
    if (all.length < requiredStarters) return;

    all.sort((a, b) => b.average.compareTo(a.average));

    final gk = all.where((p) => p.position == 'GK').toList();
    final def = all.where((p) => p.position == 'DEF').toList();
    final mid = all.where((p) => p.position == 'MID').toList();
    final fwd = all.where((p) => p.position == 'FWD').toList();

    final picked = <Player>[];
    if (gk.isNotEmpty) picked.add(gk.first);
    picked.addAll(def.take(4));
    picked.addAll(mid.take(4));
    picked.addAll(fwd.take(2));

    final used = picked.map((p) => p.id).toSet();
    for (final p in all) {
      if (picked.length >= requiredStarters) break;
      if (!used.contains(p.id)) {
        picked.add(p);
        used.add(p.id);
      }
    }

    await saveLineup(picked.take(requiredStarters).map((p) => p.id).toList());
  }
}
