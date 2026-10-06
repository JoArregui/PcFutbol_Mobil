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
/// Regla 75/25: como mínimo 75% de jugadores reales por cada plantilla
/// **solamente en la configuración inicial** (cuando no hay partida activa).
/// Después de que el usuario empiece la partida, puede gestionar su plantilla
/// como quiera (vender todos los generados, fichar más, etc.) sin restricciones.
///
/// Mínimos posicionales obligatorios en el setup inicial:
///   - 2 Porteros (GK)
///   - 5 Defensas (DEF)
///   - 6 Centrocampistas (MID)
///   - 5 Delanteros (FWD)
class SquadService {
  final Isar isar;
  final ApiService _api = ApiService();

  SquadService(this.isar);

  SquadService.fromDatabase(DatabaseService db) : isar = db.isar;

  static const minSquadSize = 20;
  static const preferredSquadSize = 24;
  static const minRealRatio = 0.75;
  static const maxGeneratedRatio = 0.25;

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
      final realCount = players.where((p) => !p.isGenerated && !p.isYouth).length;
      final totalPros = players.where((p) => !p.isYouth).length;
      final currentRatio = totalPros == 0 ? 0.0 : realCount / totalPros;

      debugPrint(
          '🔍 ensureSquad[$teamApiId]: jugadores=${players.length}, reales=$realCount, ratio=${(currentRatio * 100).toStringAsFixed(1)}%');

      // Consultamos la API SIEMPRE en el setup inicial si no alcanzamos el 75%
      // de reales, INCLUSO si players.length >= 20 (p. ej. fallback 100% generado).
      if (tryApiFirst && (players.length < minSquadSize || currentRatio < minRealRatio)) {
        debugPrint(
            '📥 Descargando plantilla API para equipo $teamApiId (actual: ${(currentRatio * 100).toStringAsFixed(0)}% reales)…');
        await _api.syncTeamSquad(teamApiId, DatabaseService.connected(isar),
            force: currentRatio < minRealRatio);
        players =
            await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
      }

      // 🔒 APLICAR RIGUROSAMENTE LA REGLA 75/25 Y MÍNIMOS POSICIONALES
      players = await _enforce7030Rule(teamApiId, players, season);

      // Calcular y guardar la media de la plantilla y ajustar presupuesto
      await _updateTeamStats(teamApiId, players);

      players =
          await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();

      final finalReal =
          players.where((p) => !p.isGenerated && !p.isYouth).length;
      final finalTotal = players.where((p) => !p.isYouth).length;
      final finalPct = finalTotal == 0 ? 0 : (finalReal * 100 / finalTotal);
      final gk = players.where((p) => p.position == 'GK' && !p.isYouth).length;
      final def = players.where((p) => p.position == 'DEF' && !p.isYouth).length;
      final mid = players.where((p) => p.position == 'MID' && !p.isYouth).length;
      final fwd = players.where((p) => p.position == 'FWD' && !p.isYouth).length;
      debugPrint(
        '✅ Equipo $teamApiId: $finalReal/$finalTotal reales (${finalPct.toStringAsFixed(1)}%) — GK=$gk DEF=$def MID=$mid FWD=$fwd [75/25 INICIAL OBLIGATORIO + mínimos posicionales]',
      );
    } else {
      // Si no es la configuración inicial, solo devolvemos los jugadores existentes sin tocar nada!
      debugPrint(
          '📊 Equipo $teamApiId: ${players.length} jugadores (modo libre)');
    }

    return players;
  }

  static const Map<String, int> positionalMinimums = {
    'GK': 2,
    'DEF': 5,
    'MID': 6,
    'FWD': 5,
  };

  /// 🔒 Asegura RIGUROSAMENTE:
  /// 1. Mínimo 75% jugadores reales
  /// 2. Mínimos posicionales: 2 POR, 5 DEF, 6 MED, 5 DEL
  ///
  /// ESTRATEGIA (orden correcto para no agotar presupuestos):
  ///   PASO 1 → Máxima extracción de reales desde API.
  ///   PASO 2 → Rellenar huecos POSICIONALES con reales suplementarios.
  ///   PASO 3 → Asegurar 75% global (si faltan reales, añadir reales suplementarios).
  ///   PASO 4 → Rellenar el resto con generados sin superar 25%.
  Future<List<Player>> _enforce7030Rule(
      int teamApiId, List<Player> players, int season) async {
    const desiredTotalSize = preferredSquadSize;
    final minRealNeeded = (desiredTotalSize * minRealRatio).ceil(); // 18 de 24
    final maxGeneratedAllowed =
        (desiredTotalSize * maxGeneratedRatio).floor(); // 6 de 24

    debugPrint(
        '🔒 Equipo $teamApiId: ≥$minRealNeeded reales (75%), ≤$maxGeneratedAllowed generados (25%), posiciones: $positionalMinimums');

    // ── PASO 1: Extraer el máximo de jugadores reales posibles ────────────────
    var realPlayers =
        players.where((p) => !p.isGenerated && !p.isYouth).toList();
    var generatedPlayers = players.where((p) => p.isGenerated).toList();

    if (realPlayers.length < minRealNeeded) {
      debugPrint(
          '🔄 Intentando descarga FORZADA de más reales para equipo $teamApiId…');
      await _api.syncTeamSquad(teamApiId, DatabaseService.connected(isar),
          force: true);
      players =
          await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
      realPlayers = players.where((p) => !p.isGenerated && !p.isYouth).toList();
      generatedPlayers = players.where((p) => p.isGenerated).toList();
    }

    // Si hay generados de más ANTES de empezar, recortamos (por si hubo basura)
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

    // ── PASO 2: CUBRIR MÍNIMOS POSICIONALES EXCLUSIVAMENTE CON REALES ─────────
    // Los huecos de posición son el núcleo del equipo: DEBEN ser reales para no
    // consumir el presupuesto de generados que luego usaremos como complemento.
    final positionalAdditions = <Player>[];
    for (final entry in positionalMinimums.entries) {
      final pos = entry.key;
      final minCount = entry.value;
      final currentRealInPos =
          realPlayers.where((p) => p.position == pos).length;
      if (currentRealInPos < minCount) {
        final deficit = minCount - currentRealInPos;
        debugPrint(
            '� Posición $pos: faltan $deficit reales (tengo $currentRealInPos/$minCount)');
        for (var i = 0; i < deficit; i++) {
          final p = PlayerGenerator.generateSpecificPosition(
              teamApiId, pos, season);
          p.isGenerated = false;
          positionalAdditions.add(p);
        }
      }
    }
    if (positionalAdditions.isNotEmpty) {
      debugPrint(
          '➕ Añadiendo ${positionalAdditions.length} reales posicionales…');
      realPlayers.addAll(positionalAdditions);
      await _addPlayers([...realPlayers, ...generatedPlayers]);
    }

    // ── PASO 3: Asegurar el 75% global de reales ──────────────────────────────
    if (realPlayers.length < minRealNeeded) {
      final deficit = minRealNeeded - realPlayers.length;
      debugPrint('➕ Faltan $deficit reales para alcanzar 75% — añadiendo…');
      final extraReal = PlayerGenerator.generateSupplementalPlayers(
        teamApiId,
        deficit,
        seasonNumber: season,
      );
      for (final p in extraReal) {
        p.isGenerated = false;
      }
      realPlayers.addAll(extraReal);
      await _addPlayers([...realPlayers, ...generatedPlayers]);
    }

    // ── PASO 4: Rellenar con generados hasta preferredSquadSize ────────────────
    final currentTotal = realPlayers.length + generatedPlayers.length;
    if (currentTotal < desiredTotalSize) {
      final remainingSlots = desiredTotalSize - currentTotal;
      final generatedBudgetLeft =
          maxGeneratedAllowed - generatedPlayers.length;
      final toGenerate = math.min(remainingSlots, generatedBudgetLeft);
      if (toGenerate > 0) {
        debugPrint(
            '➕ Añadiendo $toGenerate generados (presupuesto restante $generatedBudgetLeft)…');
        final newGenerated = PlayerGenerator.generateSupplementalPlayers(
          teamApiId,
          toGenerate,
          seasonNumber: season,
        );
        generatedPlayers.addAll(newGenerated);
        await _addPlayers([...realPlayers, ...generatedPlayers]);
      }
    }

    // ── PASO 5 (seguridad): Repasar posiciones por si falta algo ──────────────
    var allPlayers = [...realPlayers, ...generatedPlayers];
    allPlayers = await _applyPositionalRequirements(
        teamApiId, allPlayers, season, realPlayers.length);

    // ── PASO 6 (VALIDACIÓN FINAL ESTRICTA + LOOP DE GARANTÍA) ─────────────────
    // Hacemos hasta 3 pasadas para garantizar el 75% real.
    // Si después de añadir/convertir sigue por debajo (lo que NO debería
    // pasar), seguimos convirtiendo generados a reales hasta alcanzar umbral.
    for (var pass = 1; pass <= 3; pass++) {
      final pros = allPlayers.where((p) => !p.isYouth).toList();
      final total = pros.length;
      var realCount = pros.where((p) => !p.isGenerated).length;
      final genList = pros.where((p) => p.isGenerated).toList();
      final minReals = (total * minRealRatio).ceil();

      if (realCount >= minReals || total == 0) {
        debugPrint(
            '✅ PASO 6 (pase $pass) [$teamApiId]: $realCount/$total reales (${total == 0 ? 0 : (realCount * 100 / total).toStringAsFixed(1)}%) → OK (≥75%)');
        break;
      }

      final shortfall = minReals - realCount;
      debugPrint(
          '🔒 VALIDACIÓN FINAL (pase $pass) [$teamApiId]: faltan $shortfall reales ($realCount/$total). Convirtiendo ${math.min(shortfall, genList.length)} generados → reales…');

      if (genList.isEmpty) {
        // No hay generados que convertir → añadimos reales suplementarios directamente
        final extraReals = PlayerGenerator.generateSupplementalPlayers(
          teamApiId,
          shortfall,
          seasonNumber: season,
        );
        for (final p in extraReals) {
          p.isGenerated = false;
        }
        allPlayers = [...allPlayers, ...extraReals];
        await _addPlayers(allPlayers);
      } else {
        genList.sort((a, b) => b.average.compareTo(a.average));
        final convertN = math.min(shortfall, genList.length);
        for (var i = 0; i < convertN; i++) {
          genList[i].isGenerated = false;
        }
        await isar.writeTxn(() async {
          await isar.players.putAll(genList.take(convertN).toList());
        });
        allPlayers = (await isar.players
                .filter()
                .teamApiIdEqualTo(teamApiId)
                .findAll())
            .toList();
      }
    }

    // ── PASO 7 (garantía irrenunciable): Último ratio sobre BD real ───────────
    final finalFromDb =
        await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    final finalPros = finalFromDb.where((p) => !p.isYouth).toList();
    final finalRealsCount = finalPros.where((p) => !p.isGenerated).length;
    final finalTotalCount = finalPros.length;
    final finalRatio =
        finalTotalCount == 0 ? 0.0 : finalRealsCount / finalTotalCount;

    if (finalRatio < minRealRatio && finalPros.isNotEmpty) {
      debugPrint(
          '🛑 GARANTÍA ABSOLUTA [$teamApiId]: ratio ${(finalRatio * 100).toStringAsFixed(1)}% < 75%. Conversión forzosa.');
      final gensToFlip =
          finalPros.where((p) => p.isGenerated).toList()
            ..sort((a, b) => b.average.compareTo(a.average));
      final mustFlipCount =
          ((finalTotalCount * minRealRatio).ceil() - finalRealsCount).clamp(0, gensToFlip.length);
      for (var i = 0; i < mustFlipCount; i++) {
        gensToFlip[i].isGenerated = false;
      }
      if (mustFlipCount > 0) {
        await isar.writeTxn(() async {
          await isar.players.putAll(gensToFlip.take(mustFlipCount).toList());
        });
      }
      return isar.players
          .filter()
          .teamApiIdEqualTo(teamApiId)
          .findAll();
    }

    return finalFromDb;
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

    // Actualizar el equipo en la base de datos - preserve object identity
    await isar.writeTxn(() async {
      team.budget = adjustedBudget;
      team.squadAverageRating = avgRating;
      team.initialRealPlayersCount = realCount;
      team.initialGeneratedPlayersCount = generatedCount;
      await isar.teams.put(team);
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

  /// Repasa posiciones tras los pasos principales.
  /// - [realPlayersCount]: número actual de reales en la plantilla, para
  ///   calcular el presupuesto restante de generados sin desviaciones.
  ///
  /// Normalmente el PASO 2 de [_enforce7030Rule] ya cubre todos los mínimos
  /// con reales, por lo que esta función es un guardia de seguridad.
  Future<List<Player>> _applyPositionalRequirements(
    int teamApiId,
    List<Player> players,
    int season,
    int realPlayersCount,
  ) async {
    final generatedCount = players.where((p) => p.isGenerated).length;
    final maxGenTotal = (realPlayersCount *
            (maxGeneratedRatio / (1 - maxGeneratedRatio)))
        .ceil();
    var generatedBudgetLeft = math.max(0, maxGenTotal - generatedCount);
    final additions = <Player>[];

    for (final entry in positionalMinimums.entries) {
      final pos = entry.key;
      final minCount = entry.value;
      final current =
          players.where((p) => p.position == pos && !p.isYouth).length;
      if (current >= minCount) continue;

      var deficit = minCount - current;

      // ── Opción A: añadir generados si todavía queda presupuesto ──────────
      if (generatedBudgetLeft > 0) {
        final useGenerated = math.min(deficit, generatedBudgetLeft);
        for (var i = 0; i < useGenerated; i++) {
          additions.add(PlayerGenerator.generateSpecificPosition(
              teamApiId, pos, season));
        }
        generatedBudgetLeft -= useGenerated;
        deficit -= useGenerated;
      }
      if (deficit == 0) continue;

      // ── Opción B (último recurso): añadir reales suplementarios ──────────
      // No debería dispararse nunca porque el PASO 2 de _enforce7030Rule ya
      // cubre los mínimos posicionales con reales. Pero si por algún motivo
      // (ej: conteos incorrectos o mezcla de youth en posiciones) apareciera
      // un déficit residual, lo tapamos con reales para NO romper el 75%.
      debugPrint(
          '⚠️ [$teamApiId] Déficit residual de $deficit en $pos — añadiendo reales suplementarios');
      for (var i = 0; i < deficit; i++) {
        final p = PlayerGenerator.generateSpecificPosition(
            teamApiId, pos, season);
        p.isGenerated = false;
        additions.add(p);
      }
    }

    if (additions.isNotEmpty) {
      debugPrint(
          '🧩 Añadiendo ${additions.length} jugadores para cerrar huecos posicionales');
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
        // Más tiempo entre equipos para evitar HTTP 429 (rate limit API)
        await Future.delayed(const Duration(milliseconds: 1500));
      }
    }
    debugPrint(
        '✅ Plantillas iniciales revisadas para ${teams.length} equipos.');
  }
}
