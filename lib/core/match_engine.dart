import 'dart:async';
import 'dart:math';
import '../models/match_event.dart';

class MatchEngine {
  final _rng = Random();

  Stream<MatchEvent> playMatch() async* {
    int homeScore = 0;
    int awayScore = 0;

    for (int min = 1; min <= 90; min++) {
      // Simulamos tiempo real (500ms = 1 minuto de juego)
      await Future.delayed(const Duration(milliseconds: 500));

      double chance = _rng.nextDouble();

      if (chance < 0.05) { // 5% de probabilidad de GOL
        bool home = _rng.nextBool();
        yield MatchEvent(
          minute: min,
          type: EventType.goal,
          isHomeTeam: home,
          description: "¡GOOOOOL! Remate imparable al fondo de la red."
        );
      } else if (chance < 0.15) { // 10% de probabilidad de comentario/jugada
        yield MatchEvent(
          minute: min,
          type: EventType.comment,
          description: "Presión intensa en el centro del campo..."
        );
      }
      
      // Enviamos un evento vacío para actualizar el cronómetro cada minuto
      if (chance >= 0.15) {
        yield MatchEvent(minute: min, type: EventType.comment, description: "");
      }
    }
  }
}