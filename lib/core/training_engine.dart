import 'dart:math';
import 'package:isar/isar.dart';
import '../models/player_model.dart';

class TrainingEngine {
  final Isar isar;
  final _random = Random();

  TrainingEngine(this.isar);

  Future<void> trainTeam(String teamId, TrainingFocus focus) async {
    final players = await isar.players.filter().teamIdEqualTo(teamId).findAll();

    await isar.writeTxn(() async {
      for (var player in players) {
        double multiplier = player.personality == Personality.ambitious ? 1.2 : 1.0;
        
        if (_random.nextDouble() * multiplier > 0.7) {
          int statIndex = _getFocusStatIndex(focus);
          
          if (player.stats[statIndex] < 99) {
            // Creamos una copia de la lista para que Isar detecte el cambio
            final newStats = List<int>.from(player.stats);
            newStats[statIndex] += 1;
            player.stats = newStats; // Reasignación clave
          }
        }
      }
      // PutAll es eficiente para los 25-30 jugadores de tu plantilla
      await isar.players.putAll(players);
    });
  }

  int _getFocusStatIndex(TrainingFocus focus) {
    switch (focus) {
      case TrainingFocus.fitness: return 4;
      case TrainingFocus.shooting: return 1;
      case TrainingFocus.passing: return 2;
      case TrainingFocus.defense: return 3;
      case TrainingFocus.tactical: return 2; // Puedes alternar entre 2 y 3 si quieres
    }
  }
}

enum TrainingFocus { fitness, shooting, passing, defense, tactical }