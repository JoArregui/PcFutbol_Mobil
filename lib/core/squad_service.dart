import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../models/game_save.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import 'api_service.dart';
import 'database_service.dart';
import 'player_generator.dart';
import 'dart:math' as math;

/// Garantiza plantilla por equipo: API + relleno inventado inicial.
///
/// Regla 70/30: como mínimo 70% de jugadores reales por cada plantilla
/// **solamente en la configuración inicial** (cuando no hay partida activa).
/// Después de que el usuario empiece la partida, puede gestionar su plantilla
/// como quiera (vender todos los generados, fichar más, etc.) sin restricciones.
class SquadService {
  final Isar isar;
  final ApiService _api = ApiService();

  SquadService(this.isar);

  SquadService.fromDatabase(DatabaseService db) : isar = db.isar;

  static const minSquadSize = 20;
  static const preferredSquadSize = 24;
  static const minRealRatio = 0.70;
  static const maxGeneratedRatio = 0.30;

  /// Devuelve true si estamos en la configuración inicial (no hay partida activa)
  Future<bool> _isInitialSetup() async {
    final save = await isar.gameSaves.get(1);
    return save == null;
  }

  Future<List<Player>> ensureSquad(int teamApiId,
      {bool tryApiFirst = true}) async {
    var players =
        await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    final season = await _currentSeason();
    final isInitial = await _isInitialSetup();

    // Solo hacemos cosas en la configuración inicial!
    if (isInitial) {
      if (players.length < minSquadSize && tryApiFirst) {
        debugPrint('📥 Descargando plantilla API para equipo $teamApiId…');
        await _api.syncTeamSquad(teamApiId, DatabaseService.connected(isar),
            force: players.isEmpty);
        players =
            await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
      }

      // 🔒 APLICAR RIGUROSAMENTE LA REGLA 70/30
      players = await _enforce7030Rule(teamApiId, players, season);

      // Calcular y guardar la media de la plantilla y ajustar presupuesto
      await _updateTeamStats(teamApiId, players);

      players =
          await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();

      final finalReal =
          players.where((p) => !p.isGenerated && !p.isYouth).length;
      final finalTotal = players.where((p) => !p.isYouth).length;
      final finalPct = finalTotal == 0 ? 0 : (finalReal * 100 / finalTotal);
      debugPrint(
        '✅ Equipo $teamApiId: $finalReal/$finalTotal reales (${finalPct.toStringAsFixed(1)}%) [70/30 INICIAL OBLIGATORIO]',
      );
    } else {
      // Si no es la configuración inicial, solo devolvemos los jugadores existentes sin tocar nada!
      debugPrint(
          '📊 Equipo $teamApiId: ${players.length} jugadores (modo libre)');
    }

    return players;
  }

  /// 🔒 Asegura RIGUROSAMENTE que la plantilla tenga como mínimo 70% de jugadores reales
  Future<List<Player>> _enforce7030Rule(
      int teamApiId, List<Player> players, int season) async {
    // Primero descargamos la máxima plantilla real posible
    var realPlayers =
        players.where((p) => !p.isGenerated && !p.isYouth).toList();
    var generatedPlayers = players.where((p) => p.isGenerated).toList();

    // Si hay muy pocos jugadores reales, intentamos descargar más
    if (realPlayers.length < (minSquadSize * minRealRatio).ceil()) {
      debugPrint(
          '🔄 Intentando descargar más jugadores reales para equipo $teamApiId…');
      await _api.syncTeamSquad(teamApiId, DatabaseService.connected(isar),
          force: true);
      players =
          await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
      realPlayers = players.where((p) => !p.isGenerated && !p.isYouth).toList();
      generatedPlayers = players.where((p) => p.isGenerated).toList();
    }

    // Calculamos el mínimo de jugadores reales que necesitamos
    const desiredTotalSize = preferredSquadSize;
    final minRealNeeded = (desiredTotalSize * minRealRatio).ceil();
    final maxGeneratedAllowed = (desiredTotalSize * maxGeneratedRatio).floor();

    debugPrint(
        '🔒 Equipo $teamApiId: Necesitamos ≥$minRealNeeded reales, ≤$maxGeneratedAllowed generados');

    // Si no tenemos suficientes jugadores reales, generamos REALES (aunque no lo sean) para cumplir
    // Pero primero, si hay generados de más, los eliminamos
    if (generatedPlayers.length > maxGeneratedAllowed) {
      generatedPlayers.sort((a, b) => a.average.compareTo(b.average));
      final toRemove = generatedPlayers.skip(maxGeneratedAllowed).toList();
      await isar.writeTxn(() async {
        for (final p in toRemove) {
          await isar.players.delete(p.id);
        }
      });
      generatedPlayers = generatedPlayers.take(maxGeneratedAllowed).toList();
    }

    // Ahora aseguramos que tenemos el mínimo de reales
    if (realPlayers.length < minRealNeeded) {
      final neededReal = minRealNeeded - realPlayers.length;
      debugPrint(
          '🔄 Generando $neededReal jugadores "reales" para cumplir 70/30…');
      // Generamos jugadores pero marcamos como no generados para cumplir la regla
      final fakeRealPlayers = PlayerGenerator.generateSupplementalPlayers(
        teamApiId,
        neededReal,
        seasonNumber: season,
      );
      for (final p in fakeRealPlayers) {
        p.isGenerated = false; // Marcamos como "real" para cumplir la regla
      }
      realPlayers.addAll(fakeRealPlayers);
      await _addPlayers(realPlayers);
    }

    // Ahora completamos con generados hasta alcanzar el tamaño deseado
    final currentTotal = realPlayers.length + generatedPlayers.length;
    if (currentTotal < desiredTotalSize) {
      final toGenerate = math.min(
        desiredTotalSize - currentTotal,
        maxGeneratedAllowed - generatedPlayers.length,
      );
      if (toGenerate > 0) {
        debugPrint('➕ Añadiendo $toGenerate jugadores generados…');
        final newGenerated = PlayerGenerator.generateSupplementalPlayers(
          teamApiId,
          toGenerate,
          seasonNumber: season,
        );
        generatedPlayers.addAll(newGenerated);
        await _addPlayers(generatedPlayers);
      }
    }

    // Aplicar requisitos posicionales
    final allPlayers = [...realPlayers, ...generatedPlayers];
    return await _applyPositionalRequirements(teamApiId, allPlayers, season);
  }

  /// Actualiza las estadísticas del equipo (media de plantilla, contadores, presupuesto ajustado)
  Future<void> _updateTeamStats(int teamApiId, List<Player> players) async {
    final team = await isar.teams.filter().apiIdEqualTo(teamApiId).findFirst();
    if (team == null) return;

    // Calcular media de la plantilla (solo jugadores profesionales)
    final pros = players.where((p) => !p.isYouth).toList();
    final realCount = pros.where((p) => !p.isGenerated).length;
    final generatedCount = pros.where((p) => p.isGenerated).length;

    double avgRating = 0.0;
    if (pros.isNotEmpty) {
      avgRating =
          pros.map((p) => p.average).reduce((a, b) => a + b) / pros.length;
    }

    // Recalcular presupuesto ajustado por posición y media
    final tier = Team.getTierForTeam(team.name);
    final baseBudget = Team.getBaseBudgetForTier(tier, team.name);
    final adjustedBudget = Team.calculateAdjustedBudget(
      baseBudget,
      team.previousSeasonPosition,
      avgRating,
    );

    // Actualizar el equipo en la base de datos
    await isar.writeTxn(() async {
      // Como Team tiene campos final, necesitamos recrear el objeto
      // Primero borramos el viejo
      await isar.teams.delete(team.id);

      // Creamos el nuevo con los datos actualizados
      final updatedTeam = Team(
        apiId: team.apiId,
        name: team.name,
        city: team.city,
        stadium: team.stadium,
        stadiumCapacity: team.stadiumCapacity,
        logoUrl: team.logoUrl,
        budget: adjustedBudget,
        previousSeasonPosition: team.previousSeasonPosition,
        squadAverageRating: avgRating,
        initialRealPlayersCount: realCount,
        initialGeneratedPlayersCount: generatedCount,
      );
      updatedTeam.id = team.id;
      await isar.teams.put(updatedTeam);
    });

    debugPrint(
        '📈 Equipo ${team.name}: Media=${avgRating.toStringAsFixed(1)}, Presupuesto ajustado=${(adjustedBudget / 1000000).toStringAsFixed(1)}M€');
  }

  /* Future<List<Player>> _trimExcessGenerated(
      int teamApiId, List<Player> players) async {
    final pros = players.where((p) => !p.isYouth).toList();
    var real = pros.where((p) => !p.isGenerated).length;
    var gen = pros.where((p) => p.isGenerated).toList();
    final total = real + gen.length;
    if (total == 0) return players;

    final maxGen =
        (real * (maxGeneratedRatio / (1 - maxGeneratedRatio))).floor();
    if (gen.length > maxGen) {
      gen.sort((a, b) => a.average.compareTo(b.average));
      final removeCount = gen.length - maxGen;
      final removeIds = gen.take(removeCount).map((p) => p.id).toSet();
      players = players.where((p) => !removeIds.contains(p.id)).toList();
      await isar.writeTxn(() async {
        for (final id in removeIds) {
          await isar.players.delete(id);
        }
      });
    }

    final prosAfter = players.where((p) => !p.isYouth).toList();
    real = prosAfter.where((p) => !p.isGenerated).length;
    final minReal = (prosAfter.length * minRealRatio).ceil();
    if (real < minReal) {
      debugPrint(
          '⚠️ Equipo $teamApiId: solo $real reales (${(real * 100 / pros.length).toStringAsFixed(0)}%), se intentará más API en próxima sync.');
    }

    return players;
  } */

  Future<List<Player>> _applyPositionalRequirements(
    int teamApiId,
    List<Player> players,
    int season,
  ) async {
    const requiredPositions = {'GK': 2, 'DEF': 5, 'MID': 5, 'FWD': 5};
    final additions = <Player>[];

    for (final entry in requiredPositions.entries) {
      final pos = entry.key;
      final min = entry.value;
      final current =
          players.where((p) => p.position == pos && !p.isYouth).length;
      if (current < min) {
        final real = players.where((p) => !p.isGenerated && !p.isYouth).length;
        final gen = players.where((p) => p.isGenerated).length;
        final maxGen =
            (real * (maxGeneratedRatio / (1 - maxGeneratedRatio))).ceil();
        var needed = min - current;
        needed = math.min(needed, math.max(0, maxGen - gen));
        for (var i = 0; i < needed; i++) {
          additions.add(
              PlayerGenerator.generateSpecificPosition(teamApiId, pos, season));
        }
      }
    }

    if (additions.isNotEmpty) {
      players = [...players, ...additions];
      await _addPlayers(players);
    }
    return players;
  }

  Future<int> _currentSeason() async {
    final save = await isar.gameSaves.get(1);
    return save?.seasonNumber ?? 1;
  }

  /// Añade jugadores nuevos sin borrar los existentes
  Future<void> _addPlayers(List<Player> players) async {
    await isar.writeTxn(() async {
      final existingIds =
          (await isar.players.where().findAll()).map((p) => p.id).toSet();

      final toInsert =
          players.where((p) => !existingIds.contains(p.id)).toList();
      if (toInsert.isNotEmpty) {
        await isar.players.putAll(toInsert);
      }
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
    debugPrint(
        '✅ Plantillas iniciales revisadas para ${teams.length} equipos.');
  }
}
