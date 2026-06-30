import 'dart:math';
import 'package:isar/isar.dart';
import '../models/match_stats.dart';
import '../models/team.dart';

/// Servicio de notas de prensa estilo PC Fútbol 7.
class PressService {
  final Isar isar;
  static final _rng = Random();

  PressService(this.isar);

  // Métodos placeholders para mantener compatibilidad con otras partes del código
  Future<void> publishMatchReaction({
    required Team userTeam,
    required int userGoals,
    required int opponentGoals,
    required String competition,
  }) async {}
  
  Future<void> publishTransferNews([
    String? title,
    String? body,
  ]) async {}

  /// Genera una nota de prensa post-partido.
  static String generateMatchReport({
    required String teamName,
    required String opponentName,
    required int ourGoals,
    required int theirGoals,
    required FullMatchStats stats,
    required bool wasHome,
  }) {
    final result = _getResultString(ourGoals, theirGoals);
    final keyEvent = _getKeyEvent(stats, ourGoals, theirGoals);
    final starPlayer = stats.manOfTheMatch;

    final report = StringBuffer();

    // Título
    report.writeln("📰 PRENSA POST-PARTIDO");
    report.writeln("");
    report.writeln("**${wasHome ? '🏠' : '✈️'} $teamName $ourGoals - $theirGoals $opponentName");
    report.writeln("");

    // Párrafo principal
    report.writeln("«$result $teamName $_getOpeningSentence(ourGoals, theirGoals, wasHome)");
    report.writeln("");

    // Evento clave
    if (keyEvent.isNotEmpty) {
      report.writeln(keyEvent);
      report.writeln("");
    }

    // Jugador destacado
    if (starPlayer != null) {
      report.writeln("⭐ ${starPlayer.playerName} ha sido el mejor del partido con una nota de ${starPlayer.rating.toStringAsFixed(1)}.");
      report.writeln("");
    }

    // Conclusión
    report.writeln(_getConclusion(ourGoals, theirGoals, teamName));

    return report.toString();
  }

  static String _getResultString(int ourGoals, int theirGoals) {
    if (ourGoals > theirGoals) return "🎉 Victoria";
    if (ourGoals == theirGoals) return "🤝 Empate";
    return "😔 Derrota";
  }

  static String _getOpeningSentence(int ourGoals, int theirGoals, bool wasHome) {
    if (ourGoals > theirGoals) {
      final sentences = [
        "ha conseguido una victoria importante ante un rival directo",
        "se ha impuesto con claridad en un partido muy completo",
        "ha demostrado su mejor versión en los minutos clave",
        "ha sabido gestionar el partido y llevarse los 3 puntos",
      ];
      return sentences[_rng.nextInt(sentences.length)];
    } else if (ourGoals == theirGoals) {
      final sentences = [
        "ha compartido los puntos en un partido equilibrado",
        "no ha podido pasar del empate a pesar de las ocasiones",
        "ha luchado hasta el final pero no ha conseguido más",
        "ha tenido chances pero no ha sido eficaz delante de portería",
      ];
      return sentences[_rng.nextInt(sentences.length)];
    } else {
      final sentences = [
        "no ha tenido su día y ha salido derrotado",
        "ha luchado pero el rival ha sido superior",
        "ha tenido problemas en defensa y le ha salido caro",
        "ha tenido chances pero no ha sido su tarde",
      ];
      return sentences[_rng.nextInt(sentences.length)];
    }
  }

  static String _getKeyEvent(FullMatchStats stats, int ourGoals, int theirGoals) {

    if (stats.homeYellowCards + stats.awayYellowCards > 5) {
      return "💥 Partido con mucho contacto: ${stats.homeYellowCards + stats.awayYellowCards} tarjetas amarillas en total.";
    }

    if (stats.homeCorners + stats.awayCorners > 10) {
      return "🏟️ Mucha acción en las áreas: ${stats.homeCorners + stats.awayCorners} córners entre ambos equipos.";
    }

    if (ourGoals > 2 || theirGoals > 2) {
      return "⚽ Festival de goles: un total de ${ourGoals + theirGoals} goles en un partidazo.";
    }

    return "";
  }

  static String _getConclusion(int ourGoals, int theirGoals, String teamName) {
    if (ourGoals > theirGoals) {
      final conclusions = [
        "El equipo sigue su buen camino y la afición está contenta.",
        "Tres puntos muy importantes para los objetivos de la temporada.",
        "$teamName demuestra que puede competir con cualquiera.",
      ];
      return conclusions[_rng.nextInt(conclusions.length)];
    } else if (ourGoals == theirGoals) {
      final conclusions = [
        "Un punto que sabe a poco pero que puede ser clave al final.",
        "Hay que mejorar la eficacia para ganar los próximos partidos.",
        "$teamName tiene margen de mejora pero la actitud ha sido buena.",
      ];
      return conclusions[_rng.nextInt(conclusions.length)];
    } else {
      final conclusions = [
        "Hay que olvidar este partido y pensar en el próximo.",
        "La reacción es importante para salir de esta mala racha.",
        "$teamName tiene que mejorar si quiere cumplir los objetivos.",
      ];
      return conclusions[_rng.nextInt(conclusions.length)];
    }
  }
}
