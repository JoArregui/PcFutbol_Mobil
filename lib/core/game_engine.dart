import 'dart:math';
import '../models/player_model.dart';

class GameEngine {
  final _rng = Random();

  // Simulación de una jugada de ataque
  String calculatePlay(Player attacker, Player defender) {
    // Atributo de ataque (Pase/Tiro) vs Defensa/Posicionamiento
    double atkScore = (attacker.stats[1] * 0.7) + (_rng.nextInt(20));
    double defScore = (defender.stats[3] * 0.8) + (_rng.nextInt(15));

    if (atkScore > defScore + 10) {
      return "¡GOL! ${attacker.name} superó a la defensa.";
    } else if (atkScore > defScore) {
      return "Ocasión clara fallada por ${attacker.name}.";
    } else {
      return "Robo de balón impecable de ${defender.name}.";
    }
  }
}