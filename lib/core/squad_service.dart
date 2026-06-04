import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../models/player_model.dart';
import 'api_service.dart';
import 'database_service.dart';
import 'player_generator.dart';
import 'dart:math' as math;

/// Garantiza plantilla por equipo: API + relleno inventado progresivo.
/// Jornada 1: mínimo 70% reales / máximo 30% generados. Desde jornada 2: libertad total en el usuario.
class SquadService {
  final Isar isar;
  final ApiService _api = ApiService();

  SquadService(this.isar);

  SquadService.fromDatabase(DatabaseService db) : isar = db.isar;

  static const minSquadSize = 20;
  static const preferredSquadSize = 24;
  static const minRealRatio = 0.70;
  static const maxGeneratedRatio = 0.30;

  Future<bool> _enforceInitialRatio(int teamApiId) async {
    final save = await isar.gameSaves.get(1);
    if (save == null) return true;
    if (save.userTeamApiId != teamApiId) return true;
    return save.currentMatchday <= 1;
  }

  Future<List<Player>> ensureSquad(int teamApiId, {bool tryApiFirst = true}) async {
    var players = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    final season = await _currentSeason();
    final enforceRatio = await _enforceInitialRatio(teamApiId);

    if (players.length < minSquadSize && tryApiFirst) {
      debugPrint('📥 Descargando plantilla API para equipo $teamApiId…');
      await _api.syncTeamSquad(teamApiId, DatabaseService.connected(isar), force: players.isEmpty);
      players = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    }

    players = await _applyPositionalRequirements(
      teamApiId,
      players,
      season,
      enforceRatio: enforceRatio,
    );

    if (enforceRatio) {
      players = await _trimExcessGenerated(teamApiId, players);
    }

    final realCount = players.where((p) => !p.isGenerated && !p.isYouth).length;
    final generatedCount = players.where((p) => p.isGenerated).length;

    int desiredGenerated = 0;
    if (enforceRatio) {
      final maxAllowedGenerated =
          (realCount * (maxGeneratedRatio / (1 - maxGeneratedRatio))).ceil();
      desiredGenerated = math.min(
        maxAllowedGenerated,
        math.max(0, preferredSquadSize - realCount - generatedCount),
      );
    } else {
      desiredGenerated = math.max(0, preferredSquadSize - players.where((p) => !p.isYouth).length);
    }

    final lowerLimit = math.min(minSquadSize, preferredSquadSize);
    final upperLimit = math.max(minSquadSize, preferredSquadSize);
    final desiredTotal = (realCount + generatedCount + desiredGenerated).clamp(lowerLimit, upperLimit);
    final needed = desiredTotal - players.length;

    if (needed > 0) {
      final toGenerate = enforceRatio
          ? math.min(needed, math.max(0, (realCount * (maxGeneratedRatio / (1 - maxGeneratedRatio))).ceil() - generatedCount))
          : needed;
      if (toGenerate > 0) {
        final generated = PlayerGenerator.generateSupplementalPlayers(
          teamApiId,
          toGenerate,
          seasonNumber: season,
        );
        players = [...players, ...generated];
        await _replaceSquad(teamApiId, players);
      }
    }

    if (enforceRatio) {
      players = await _trimExcessGenerated(teamApiId, players);
      players = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    }

    final finalReal = players.where((p) => !p.isGenerated && !p.isYouth).length;
    final finalTotal = players.where((p) => !p.isYouth).length;
    final finalPct = finalTotal == 0 ? 0 : (finalReal * 100 / finalTotal);
    debugPrint(
      '📊 Equipo $teamApiId: $finalReal/$finalTotal reales (${finalPct.toStringAsFixed(1)}%)'
      '${enforceRatio ? " [70/30]" : " [libre]"}',
    );

    return players;
  }

  Future<List<Player>> _trimExcessGenerated(int teamApiId, List<Player> players) async {
    final pros = players.where((p) => !p.isYouth).toList();
    var real = pros.where((p) => !p.isGenerated).length;
    var gen = pros.where((p) => p.isGenerated).toList();
    final total = real + gen.length;
    if (total == 0) return players;

    final maxGen = (real * (maxGeneratedRatio / (1 - maxGeneratedRatio))).floor();
    if (gen.length > maxGen) {
      gen.sort((a, b) => a.average.compareTo(b.average));
      final removeCount = gen.length - maxGen;
      final removeIds = gen.take(removeCount).map((p) => p.id).toSet();
      players = players.where((p) => !removeIds.contains(p.id)).toList();
      await _replaceSquad(teamApiId, players);
    }

    final prosAfter = players.where((p) => !p.isYouth).toList();
    real = prosAfter.where((p) => !p.isGenerated).length;
    final minReal = (prosAfter.length * minRealRatio).ceil();
    if (real < minReal) {
      debugPrint('⚠️ Equipo $teamApiId: solo $real reales (${(real * 100 / pros.length).toStringAsFixed(0)}%), se intentará más API en próxima sync.');
    }

    return players;
  }

  Future<List<Player>> _applyPositionalRequirements(
    int teamApiId,
    List<Player> players,
    int season, {
    required bool enforceRatio,
  }) async {
    const requiredPositions = {'GK': 2, 'DEF': 5, 'MID': 5, 'FWD': 5};
    final additions = <Player>[];

    for (final entry in requiredPositions.entries) {
      final pos = entry.key;
      final min = entry.value;
      final current = players.where((p) => p.position == pos && !p.isYouth).length;
      if (current < min) {
        var needed = min - current;
        if (enforceRatio) {
          final real = players.where((p) => !p.isGenerated && !p.isYouth).length;
          final gen = players.where((p) => p.isGenerated).length;
          final maxGen = (real * (maxGeneratedRatio / (1 - maxGeneratedRatio))).ceil();
          needed = math.min(needed, math.max(0, maxGen - gen));
        }
        for (var i = 0; i < needed; i++) {
          additions.add(PlayerGenerator.generateSpecificPosition(teamApiId, pos, season));
        }
      }
    }

    if (additions.isNotEmpty) {
      players = [...players, ...additions];
      await _replaceSquad(teamApiId, players);
    }
    return players;
  }

  Future<int> _currentSeason() async {
    final save = await isar.gameSaves.get(1);
    return save?.seasonNumber ?? 1;
  }

  Future<void> _replaceSquad(int teamApiId, List<Player> players) async {
    await isar.writeTxn(() async {
      final old = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
      for (final p in old) {
        await isar.players.delete(p.id);
      }
      await isar.players.putAll(players);
    });
  }

  Future<void> ensureAllTeams() async {
    final teams = await isar.teams.where().findAll();
    for (var i = 0; i < teams.length; i++) {
      await ensureSquad(teams[i].apiId, tryApiFirst: true);
      if (i < teams.length - 1) {
        await Future.delayed(const Duration(milliseconds: 400));
      }
    }
    debugPrint('✅ Plantillas iniciales revisadas para ${teams.length} equipos.');
  }
}
