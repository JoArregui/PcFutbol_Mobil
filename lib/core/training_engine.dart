import 'dart:math';
import 'package:isar/isar.dart';
import '../models/player_model.dart';

enum TrainingFocus { fitness, shooting, passing, defense, tactical }

class TrainingResult {
  final String playerName;
  final String statName;
  final int oldStat;
  final int newStat;
  final bool improved;

  TrainingResult({
    required this.playerName,
    required this.statName,
    required this.oldStat,
    required this.newStat,
    required this.improved,
  });
}

class TrainingEngine {
  final Isar isar;
  final _random = Random();

  TrainingEngine(this.isar);

  int getSelectionLimit(double staffMultiplier) {
    if (staffMultiplier <= 1.0) return 3;
    if (staffMultiplier <= 1.25) return 5;
    return 8;
  }

  /// Estructura de auto-configuración inteligente para entrenamientos rápidos automatizados
  Map<String, dynamic> autoSelectConfiguration({
    required List<Player> teamPlayers,
    required int maxCupos,
  }) {
    if (teamPlayers.isEmpty) {
      return {"focus": TrainingFocus.tactical, "playerIds": <int>[]};
    }

    // 1. Elección de foco aleatorio de la semana
    const foci = TrainingFocus.values;
    final randomFocus = foci[_random.nextInt(foci.length)];

    // 2. Ordenación lógica de jugadores por prioridad de desarrollo:
    // Prioriza Unicorns (estrellas), menores de 21 años, y jugadores con mayor margen respecto a su potencial
    final sortedPlayers = List<Player>.from(teamPlayers);
    sortedPlayers.sort((a, b) {
      int scoreA = 0;
      int scoreB = 0;

      if (a.isUnicorn) scoreA += 10;
      if (b.isUnicorn) scoreB += 10;

      if (a.age <= 21) scoreA += 5;
      if (b.age <= 21) scoreB += 5;

      // Calcular margen respecto a su cap estimado
      final capA = a.potential.clamp(75, 99);
      final capB = b.potential.clamp(75, 99);
      final indexFocus = _getFocusStatIndex(randomFocus);

      scoreA += (capA - a.stats[indexFocus]);
      scoreB += (capB - b.stats[indexFocus]);

      return scoreB.compareTo(scoreA); // De mayor a menor puntuación de prioridad
    });

    final selectedIds = sortedPlayers
        .take(maxCupos)
        .map((p) => p.id)
        .toList();

    return {
      "focus": randomFocus,
      "playerIds": selectedIds,
    };
  }

  /// Entrena a los jugadores y devuelve un mapa detallado con la evolución de cada uno
  Future<Map<int, TrainingResult>> trainSelectedPlayers(List<int> playerIds, TrainingFocus focus, {double staffMultiplier = 1.0}) async {
    if (playerIds.isEmpty) return {};
    
    final results = await isar.players.getAll(playerIds);
    final players = results.whereType<Player>().toList();
    final Map<int, TrainingResult> report = {};

    await isar.writeTxn(() async {
      for (var player in players) {
        double multiplier = player.personality == Personality.ambitious ? 1.2 : 1.0;
        multiplier *= staffMultiplier;

        if (player.isUnicorn) multiplier *= 1.85;
        if (player.age <= 21) multiplier *= 1.15;

        final statIndex = _getFocusStatIndex(focus);
        final statName = _getStatLabel(statIndex);
        final oldStat = player.stats[statIndex];
        int newStat = oldStat;
        bool hasImproved = false;

        if (_random.nextDouble() * multiplier > 0.55) {
          final cap = player.potential.clamp(75, 99);
          if (oldStat < cap) {
            final newStats = List<int>.from(player.stats);
            var gain = 1;
            if (player.isUnicorn && player.age <= 20 && _random.nextDouble() < 0.35) {
              gain = 2;
            }
            newStat = (oldStat + gain).clamp(1, cap);
            newStats[statIndex] = newStat;
            player.stats = newStats;
            hasImproved = true;
          }
        }

        report[player.id] = TrainingResult(
          playerName: player.name,
          statName: statName,
          oldStat: oldStat,
          newStat: newStat,
          improved: hasImproved,
        );
      }
      await isar.players.putAll(players);
    });

    return report;
  }

  int _getFocusStatIndex(TrainingFocus focus) {
    switch (focus) {
      case TrainingFocus.fitness:
        return 4; // Físico
      case TrainingFocus.shooting:
        return 1; // Tiro
      case TrainingFocus.passing:
        return 2; // Pase
      case TrainingFocus.defense:
        return 3; // Defensa
      case TrainingFocus.tactical:
        return 2; // Pase / Táctica mixta
    }
  }

  String _getStatLabel(int index) {
    switch (index) {
      case 0: return "Velocidad";
      case 1: return "Tiro";
      case 2: return "Pase";
      case 3: return "Defensa";
      case 4: return "Físico";
      default: return "Atributo";
    }
  }
}