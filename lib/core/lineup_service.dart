import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../models/game_save.dart';
import '../models/player_model.dart';
import '../models/user_lineup.dart';

class LineupService {
  final Isar isar;

  LineupService(this.isar);

  static const int requiredStarters = 11;
  static const int requiredBench = 7;
  static const int requiredMatchdaySquad = requiredStarters + requiredBench;

  /// Umbral de jugadores generados en convocatorias guardadas para
  /// mantener la regla 70/30 activa más allá de la jornada 1.
  /// Si el usuario mete al menos este ratio (25%) de jugadores
  /// `isGenerated`, entendemos que sigue "dependiendo" de la IA y la
  /// liga debe preservar la calidad competitiva del resto de equipos.
  static const double generatedStyleThreshold = 0.25;

  /// Devuelve `true` cuando la regla 70/30 debe seguir forzándose
  /// para los rivales del usuario, según el estilo acumulado del
  /// jugador (cuántos generados mete en sus convocatorias).
  static bool shouldEnforceRatio({
    required int currentMatchday,
    required int lineupGeneratedPlayers,
    required int lineupTotalPlayers,
  }) {
    if (currentMatchday <= 1) return true;
    final total = lineupTotalPlayers <= 0 ? 1 : lineupTotalPlayers;
    final ratio = lineupGeneratedPlayers / total;
    return ratio >= generatedStyleThreshold;
  }

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

  /// Resetea la convocatoria: titulares y suplentes vacíos. Mantiene la
  /// formación. Después de llamar a este método, `hasValidLineup` será
  /// `false` y la guardia del partido volverá a pedir alineación.
  Future<void> clearLineup() async {
    final current = await getLineup();
    final lineup = UserLineup()
      ..id = 1
      ..starterPlayerIds = const <int>[]
      ..benchPlayerIds = const <int>[]
      ..formation = current.formation;
    await isar.writeTxn(() => isar.userLineups.put(lineup));
  }

  Future<void> saveLineup({
    required List<int> starterIds,
    required List<int> benchIds,
    String? formation,
  }) async {
    // Validar duplicados: un jugador no puede estar en ambos.
    final dupes = starterIds.toSet().intersection(benchIds.toSet());
    if (dupes.isNotEmpty) return;
    final current = await getLineup();
    final lineup = UserLineup()
      ..id = 1
      ..starterPlayerIds = starterIds
      ..benchPlayerIds = benchIds
      ..formation = formation ?? current.formation;

    // Contamos los jugadores generados para alimentar el "estilo"
    // acumulado del usuario en `GameSave`. Esto es lo que decide si la
    // regla 70/30 sigue activa o se relaja en jornadas posteriores.
    final allIds = [...starterIds, ...benchIds];
    final players = await isar.players.getAll(allIds);
    final validPlayers = players.whereType<Player>().toList();
    final generatedCount = validPlayers.where((p) => p.isGenerated).length;
    final totalCount = validPlayers.length;

    await isar.writeTxn(() async {
      await isar.userLineups.put(lineup);

      final save = await isar.gameSaves.get(1);
      if (save != null) {
        save.lineupGeneratedPlayers += generatedCount;
        save.lineupTotalPlayers += totalCount;
        await isar.gameSaves.put(save);
      }
    });

    if (kDebugMode) {
      final ratio = totalCount == 0 ? 0.0 : generatedCount / totalCount;
      debugPrint(
        '📋 Convocatoria guardada — generados: $generatedCount/$totalCount '
        '(${(ratio * 100).toStringAsFixed(0)}%)',
      );
    }
  }

  /// Mejor 11 + 7 suplentes automáticos.
  Future<void> autoPickMatchdaySquad(int teamApiId) async {
    final all = await isar.players
        .filter()
        .teamApiIdEqualTo(teamApiId)
        .isYouthEqualTo(false)
        .findAll();
    // Solo disponibles: sin lesión ni sanción.
    final available =
        all.where((p) => p.injuredDays <= 0 && p.suspendedMatches <= 0).toList();
    if (available.length < requiredMatchdaySquad) return;

    available.sort((a, b) => b.average.compareTo(a.average));

    final gk = available.where((p) => p.position == 'GK').toList();
    if (gk.isEmpty) return; // Sin portero disponible no generar alineación inválida.
    final def = available.where((p) => p.position == 'DEF').toList();
    final mid = available.where((p) => p.position == 'MID').toList();
    final fwd = available.where((p) => p.position == 'FWD').toList();

    final picked = <Player>[];
    picked.add(gk.first);
    picked.addAll(def.take(4));
    picked.addAll(mid.take(4));
    picked.addAll(fwd.take(2));

    final used = picked.map((p) => p.id).toSet();
    for (final p in available) {
      if (picked.length >= requiredStarters) break;
      if (!used.contains(p.id)) {
        picked.add(p);
        used.add(p.id);
      }
    }

    // Garantizar portero en el 11 aunque el relleno lo haya desplazado.
    if (!picked.any((p) => p.position == 'GK')) {
      // Sustituir el peor no-portero por el mejor portero disponible.
      final nonGk = picked.where((p) => p.position != 'GK').toList()
        ..sort((a, b) => a.average.compareTo(b.average));
      if (nonGk.isNotEmpty) {
        picked.remove(nonGk.first);
        picked.add(gk.firstWhere((g) => !used.contains(g.id),
            orElse: () => gk.first));
      }
    }

    final bench = <Player>[];
    final usedWithPicked = {...used, ...picked.map((p) => p.id)};
    for (final p in available) {
      if (bench.length >= requiredBench) break;
      if (!usedWithPicked.contains(p.id)) {
        bench.add(p);
        usedWithPicked.add(p.id);
      }
    }

    if (picked.length < requiredStarters || bench.length < requiredBench) return;

    await saveLineup(
      starterIds: picked.map((p) => p.id).toList(),
      benchIds: bench.map((p) => p.id).toList(),
    );
  }
}