import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/game_message.dart';
import 'message_service.dart';
import 'player_generator.dart';

/// Ejecutar al final de cada temporada.
/// 1. Envejece a todos los jugadores (+1 año).
/// 2. Ajusta stats según curva de edad y posición.
/// 3. Retira jugadores mayores de 35 (o 34 con muchas lesiones).
/// 4. Genera un joven de cantera por cada retirado para mantener el ecosistema.
/// 5. Reduce contractYearsRemaining; jugadores libres quedan en el mercado.
class PlayerProgressionService {
  final Isar isar;
  final _rng = Random();

  PlayerProgressionService(this.isar);

  /// Punto de entrada principal. Devuelve un resumen de lo ocurrido.
  Future<ProgressionSummary> runEndOfSeason({
    required int userTeamApiId,
    required int seasonNumber,
  }) async {
    final allPlayers = await isar.players.where().findAll();
    final summary = ProgressionSummary();

    final toRetire = <Player>[];
    final toUpdate = <Player>[];

    for (final p in allPlayers) {
      // ── 1. Envejecer ────────────────────────────────────────────────────
      p.age += 1;

      // ── 2. Progresar / declinar stats ───────────────────────────────────
      _applyAgeCurve(p);

      // ── 3. Las lesiones acumuladas aceleran el declive ───────────────────
      if (p.injuredDays > 60) {
        _applyInjuryDecline(p);
        summary.injuryDeclines++;
      }

      // ── 4. Actualizar valor de mercado y sueldo ──────────────────────────
      p.marketValue = _recalcValue(p);
      // El sueldo se renegocia ligeramente cada temporada
      p.salary = _recalcSalary(p);

      // ── 5. Actualizar cláusula de rescisión ──────────────────────────────
      p.buyoutClause = _recalcBuyout(p);

      // ── 6. Reducir contrato ──────────────────────────────────────────────
      if (p.contractYearsRemaining > 0) {
        p.contractYearsRemaining -= 1;
      }

      // ── 7. ¿Se retira? ───────────────────────────────────────────────────
      if (_shouldRetire(p)) {
        toRetire.add(p);
        summary.retirements.add(RetiredPlayer(
          name: p.name,
          teamApiId: p.teamApiId ?? 0,
          wasUserTeam: p.teamApiId == userTeamApiId,
        ));
      } else {
        toUpdate.add(p);
      }
    }

    // ── Persistir cambios ────────────────────────────────────────────────
    await isar.writeTxn(() async {
      await isar.players.putAll(toUpdate);
      for (final p in toRetire) {
        await isar.players.delete(p.id);
      }
    });

    // ── Generar reemplazos jóvenes ────────────────────────────────────────
    // Agrupamos los retirados por equipo para generar un reemplazo por cada uno
    final retiredByTeam = <int, int>{};
    for (final r in toRetire) {
      final tid = r.teamApiId ?? 0;
      if (tid == 0) continue;
      retiredByTeam[tid] = (retiredByTeam[tid] ?? 0) + 1;
    }

    final replacements = <Player>[];
    retiredByTeam.forEach((teamApiId, count) {
      final youths = PlayerGenerator.generateYouthReplacements(
        teamApiId,
        count,
        seasonNumber: seasonNumber,
      );
      replacements.addAll(youths);
      summary.youthGenerated += youths.length;
    });

    if (replacements.isNotEmpty) {
      await isar.writeTxn(() => isar.players.putAll(replacements));
    }

    // ── Mensaje en secretaría ─────────────────────────────────────────────
    final userRetirements =
        summary.retirements.where((r) => r.wasUserTeam).toList();
    if (userRetirements.isNotEmpty) {
      final names = userRetirements.map((r) => r.name).join(', ');
      await MessageService(isar).add(
        title: 'Fin de temporada — Retiradas',
        body:
            'Los siguientes jugadores se han retirado: $names. Se han incorporado ${userRetirements.length} joven(es) a la cantera.',
        type: MessageType.transfer,
      );
    }

    // Avisar de contratos en último año
    final expiringOwn = toUpdate
        .where((p) =>
            p.teamApiId == userTeamApiId && p.contractYearsRemaining == 1)
        .toList();
    if (expiringOwn.isNotEmpty) {
      final names = expiringOwn.map((p) => p.name).join(', ');
      await MessageService(isar).add(
        title: 'Contratos en último año',
        body:
            '$names terminan contrato esta temporada. Renuévalos o perderás la cláusula de rescisión.',
        type: MessageType.transfer,
      );
    }

    debugPrint(
        '📅 Progresión: ${toUpdate.length} actualizados, ${toRetire.length} retirados, ${replacements.length} jóvenes generados.');

    return summary;
  }

  // ── Curva de edad ─────────────────────────────────────────────────────────
  //
  // Stats: [Velocidad(0), Tiro(1), Pase(2), Defensa(3), Físico(4)]
  //
  // Velocidad y físico degradan antes (desde 28).
  // Tiro, pase y defensa alcanzan su pico más tarde y caen más despacio.

  void _applyAgeCurve(Player p) {
    if (p.stats.length < 5) return;
    final age = p.age;
    final newStats = List<int>.from(p.stats);

    for (var i = 0; i < 5; i++) {
      final delta = _statDelta(i, age, p.isUnicorn, p.potential);
      newStats[i] = (newStats[i] + delta).clamp(40, 99);
    }

    p.stats = newStats;
  }

  /// Devuelve cuántos puntos cambia el stat [index] dado la edad.
  int _statDelta(int statIndex, int age, bool isUnicorn, int potential) {
    // Velocidad (0) y Físico (4): pico 22-26, caída desde 28
    // Tiro (1) y Pase (2): pico 24-29, caída desde 30
    // Defensa (3): pico 25-30, caída desde 31

    final peakStart    = [22, 24, 24, 25, 22][statIndex];
    final peakEnd      = [26, 29, 29, 30, 26][statIndex];
    final declineStart = [28, 30, 30, 31, 28][statIndex];

    if (isUnicorn && age < peakStart) {
      // Jóvenes promesas crecen más rápido hacia su potencial
      final gap = potential - pAvgApprox(statIndex);
      return gap > 10 ? 2 : 1;
    }

    if (age < peakStart)     return _rng.nextBool() ? 1 : 0;    // crecimiento joven
    if (age <= peakEnd)      return _rng.nextDouble() < 0.3 ? 1 : 0;  // pico estable
    if (age <= declineStart) return _rng.nextDouble() < 0.4 ? -1 : 0; // inicio declive
    if (age <= 32)           return _rng.nextDouble() < 0.6 ? -1 : 0; // declive moderado
    if (age <= 34)           return _rng.nextBool() ? -1 : -2;        // declive serio
    return -2;                                                         // últimos años
  }

  // Aproximación local para no recalcular la media (evitamos getter en lógica)
  int pAvgApprox(int statIndex) => 75; // valor neutro de referencia

  void _applyInjuryDecline(Player p) {
    if (p.stats.length < 5) return;
    final newStats = List<int>.from(p.stats);
    // Velocidad y físico sufren más con lesiones acumuladas
    newStats[0] = (newStats[0] - _rng.nextInt(3) - 1).clamp(40, 99);
    newStats[4] = (newStats[4] - _rng.nextInt(2) - 1).clamp(40, 99);
    p.stats = newStats;
  }

  // ── Retiro ────────────────────────────────────────────────────────────────

  bool _shouldRetire(Player p) {
    if (p.isYouth) return false;
    if (p.age >= 36) return true;
    if (p.age == 35) return _rng.nextDouble() < 0.55;
    if (p.age == 34 && p.injuredDays > 90) return _rng.nextDouble() < 0.30;
    return false;
  }

  // ── Recálculos financieros ────────────────────────────────────────────────

  double _recalcValue(Player p) {
    if (p.stats.isEmpty) return p.marketValue;
    final avg = p.stats.reduce((a, b) => a + b) / p.stats.length;
    // Penalización por edad avanzada
    final ageFactor = p.age <= 28
        ? 1.0 + (p.age - 20) * 0.04
        : 1.0 - (p.age - 28) * 0.08;
    return (avg * avg * 12000 * ageFactor.clamp(0.2, 1.6))
        .clamp(100000, 200000000);
  }

  double _recalcSalary(Player p) {
    // El sueldo sigue al valor de mercado con una ratio de ~4-5%
    return (p.marketValue * 0.045).clamp(15000, 800000);
  }

  double _recalcBuyout(Player p) {
    // Cláusula = multiplicador según personalidad y años de contrato
    final baseMultiplier = () {
      switch (p.personality) {
        case Personality.greedy:
          return 4.5;
        case Personality.ambitious:
          return 3.5;
        case Personality.loyal:
          return 2.8;
        case Personality.professional:
          return 3.2;
      }
    }();

    // Si queda 1 año, la cláusula ya no protege tanto
    final contractFactor =
        p.contractYearsRemaining <= 1 ? 1.5 : baseMultiplier;
    return p.marketValue * contractFactor;
  }
}

// ── Modelos de resultado ──────────────────────────────────────────────────────

class ProgressionSummary {
  final List<RetiredPlayer> retirements = [];
  int youthGenerated = 0;
  int injuryDeclines = 0;
}

class RetiredPlayer {
  final String name;
  final int teamApiId;
  final bool wasUserTeam;
  RetiredPlayer({
    required this.name,
    required this.teamApiId,
    required this.wasUserTeam,
  });
}