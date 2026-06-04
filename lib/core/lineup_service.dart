import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/user_lineup.dart';

class LineupService {
  final Isar isar;

  LineupService(this.isar);

  static const int requiredStarters = 11;
  static const int requiredBench = 7;
  static const int requiredMatchdaySquad = requiredStarters + requiredBench;

  Future<UserLineup> getLineup() async {
    var lineup = await isar.userLineups.get(1);
    lineup ??= UserLineup()..id = 1;
    return lineup;
  }

  Future<List<Player>> _resolvePlayers(List<int> ids, int teamApiId) async {
    final players = <Player>[];
    for (final pid in ids) {
      final p = await isar.players.get(pid);
      if (p != null &&
          p.teamApiId == teamApiId &&
          p.injuredDays <= 0 &&
          p.suspendedMatches <= 0 &&
          !p.isYouth) {
        players.add(p);
      }
    }
    return players;
  }

  Future<List<Player>> getStarters(int teamApiId) async {
    final lineup = await getLineup();
    if (lineup.starterPlayerIds.length < requiredStarters) return [];
    final players = await _resolvePlayers(lineup.starterPlayerIds, teamApiId);
    return players.length == requiredStarters ? players : [];
  }

  Future<List<Player>> getBench(int teamApiId) async {
    final lineup = await getLineup();
    if (lineup.benchPlayerIds.length < requiredBench) return [];
    final players = await _resolvePlayers(lineup.benchPlayerIds, teamApiId);
    return players.length == requiredBench ? players : [];
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
    final lineup = await getLineup();
    if (lineup.starterPlayerIds.length != requiredStarters) return false;
    if (lineup.benchPlayerIds.length != requiredBench) return false;

    final allIds = {...lineup.starterPlayerIds, ...lineup.benchPlayerIds};
    if (allIds.length != requiredMatchdaySquad) return false;

    final starters = await getStarters(teamApiId);
    if (starters.length != requiredStarters) return false;
    if (!starters.any((p) => p.position == 'GK')) return false;

    final bench = await getBench(teamApiId);
    return bench.length == requiredBench;
  }

  Future<void> saveLineup({
    required List<int> starterIds,
    required List<int> benchIds,
    String? formation,
  }) async {
    final current = await getLineup();
    final lineup = UserLineup()
      ..id = 1
      ..starterPlayerIds = starterIds
      ..benchPlayerIds = benchIds
      ..formation = formation ?? current.formation;
    await isar.writeTxn(() => isar.userLineups.put(lineup));
  }

  /// Mejor 11 + 7 suplentes automáticos.
  Future<void> autoPickMatchdaySquad(int teamApiId) async {
    final all = await isar.players
        .filter()
        .teamApiIdEqualTo(teamApiId)
        .isYouthEqualTo(false)
        .findAll();
    if (all.length < requiredMatchdaySquad) return;

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

    final bench = <Player>[];
    for (final p in all) {
      if (bench.length >= requiredBench) break;
      if (!used.contains(p.id)) {
        bench.add(p);
        used.add(p.id);
      }
    }

    if (picked.length < requiredStarters || bench.length < requiredBench) return;

    await saveLineup(
      starterIds: picked.map((p) => p.id).toList(),
      benchIds: bench.map((p) => p.id).toList(),
    );
  }
}
