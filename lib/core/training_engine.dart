import 'dart:math';
import 'package:isar/isar.dart';
import '../models/player_model.dart';

class TrainingEngine {
  final Isar isar;
  final _random = Random();

  TrainingEngine(this.isar);

  Future<int> trainTeam(int teamApiId, TrainingFocus focus, {double staffMultiplier = 1.0}) async {
    final players = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    int improved = 0;

    await isar.writeTxn(() async {
      for (var player in players) {
        double multiplier = player.personality == Personality.ambitious ? 1.2 : 1.0;
        multiplier *= staffMultiplier;

        if (player.isUnicorn) multiplier *= 1.85;
        if (player.age <= 21) multiplier *= 1.15;

        if (_random.nextDouble() * multiplier > 0.55) {
          final statIndex = _getFocusStatIndex(focus);
          final cap = player.potential.clamp(75, 99);
          if (player.stats[statIndex] < cap) {
            final newStats = List<int>.from(player.stats);
            var gain = 1;
            if (player.isUnicorn && player.age <= 20 && _random.nextDouble() < 0.35) {
              gain = 2;
            }
            newStats[statIndex] = (newStats[statIndex] + gain).clamp(1, cap);
            player.stats = newStats;
            improved++;
          }
        }
      }
      await isar.players.putAll(players);
    });

    return improved;
  }

  int _getFocusStatIndex(TrainingFocus focus) {
    switch (focus) {
      case TrainingFocus.fitness:
        return 4;
      case TrainingFocus.shooting:
        return 1;
      case TrainingFocus.passing:
        return 2;
      case TrainingFocus.defense:
        return 3;
      case TrainingFocus.tactical:
        return 2;
    }
  }
}

enum TrainingFocus { fitness, shooting, passing, defense, tactical }
