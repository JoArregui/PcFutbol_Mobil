import 'dart:math';
import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import '../models/league_standing.dart';
import 'tactics_service.dart';

/// Informe completo de scouting sobre un rival
class ScoutReport {
  final Team opponent;
  final double teamStrength;
  final String keyStrength;
  final String keyWeakness;
  final List<String> dangerPlayers;
  final String recommendedTactic;
  final TeamMentality recommendedMentality;
  final TeamStyle recommendedStyle;
  final String prediction;

  ScoutReport({
    required this.opponent,
    required this.teamStrength,
    required this.keyStrength,
    required this.keyWeakness,
    required this.dangerPlayers,
    required this.recommendedTactic,
    required this.recommendedMentality,
    required this.recommendedStyle,
    required this.prediction,
  });
}

class ScoutService {
  final Isar isar;
  final _rng = Random();

  ScoutService(this.isar);

  /// Genera un informe completo de scouting sobre el rival
  Future<ScoutReport> generateScoutReport(Team opponent, int userTeamApiId) async {
    // Obtener jugadores del rival
    final opponentPlayers = await isar.players
        .filter()
        .teamApiIdEqualTo(opponent.apiId)
        .isYouthEqualTo(false)
        .findAll();

    // Calcular fuerza del equipo
    final teamStrength = _calculateTeamStrength(opponentPlayers);

    // Obtener clasificación
    final standing = await isar.leagueStandings
        .filter()
        .teamApiIdEqualTo(opponent.apiId)
        .findFirst();

    // Identificar fortalezas y debilidades
    final strengths = _identifyStrengths(opponentPlayers, standing);
    final weaknesses = _identifyWeaknesses(opponentPlayers, standing);
    
    // Jugadores peligrosos
    final dangerPlayers = _identifyDangerPlayers(opponentPlayers);

    // Recomendaciones tácticas
    final recommendations = _generateRecommendations(teamStrength, strengths, weaknesses);

    // Predicción
    final prediction = _generatePrediction(teamStrength, opponent.name);

    return ScoutReport(
      opponent: opponent,
      teamStrength: teamStrength,
      keyStrength: strengths[_rng.nextInt(strengths.length)],
      keyWeakness: weaknesses[_rng.nextInt(weaknesses.length)],
      dangerPlayers: dangerPlayers,
      recommendedTactic: recommendations.$1,
      recommendedMentality: recommendations.$2,
      recommendedStyle: recommendations.$3,
      prediction: prediction,
    );
  }

  double _calculateTeamStrength(List<Player> players) {
    if (players.isEmpty) return 50.0;
    final sorted = List<Player>.from(players)
      ..sort((a, b) => b.average.compareTo(a.average));
    final top11 = sorted.take(11).toList();
    final avg = top11.map((p) => p.average).reduce((a, b) => a + b) / 11;
    return avg.clamp(20.0, 95.0);
  }

  List<String> _identifyStrengths(List<Player> players, LeagueStanding? standing) {
    final strengths = <String>[];
    
    // Analizar ataque
    final forwards = players.where((p) => p.position == 'FWD').toList();
    if (forwards.isNotEmpty) {
      final avgShooting = forwards.map((p) => p.stats[1]).reduce((a, b) => a + b) / forwards.length;
      if (avgShooting >= 80) {
        strengths.add('Ataque letal — jugadores de calidad en la delantera');
      } else if (avgShooting >= 70) {
        strengths.add('Ataque sólido — pueden marcar en cualquier momento');
      }
    }

    // Analizar defensa
    final defenders = players.where((p) => p.position == 'DEF' || p.position == 'GK').toList();
    if (defenders.isNotEmpty) {
      final avgDefense = defenders.map((p) => p.stats[3]).reduce((a, b) => a + b) / defenders.length;
      if (avgDefense >= 80) {
        strengths.add('Defensa impenetrable — muy difícil marcarles');
      } else if (avgDefense >= 70) {
        strengths.add('Defensa organizada — difícil de superar');
      }
    }

    // Analizar medio campo
    final midfielders = players.where((p) => p.position == 'MID').toList();
    if (midfielders.isNotEmpty) {
      final avgPassing = midfielders.map((p) => p.stats[2]).reduce((a, b) => a + b) / midfielders.length;
      if (avgPassing >= 80) {
        strengths.add('Control de balón — dominan el centro del campo');
      }
    }

    // Analizar estado de forma (clasificación por puntos)
    if (standing != null) {
      if (standing.points >= 40) {
        strengths.add('Gran racha — están en zona de Champions');
      } else if (standing.points >= 20) {
        strengths.add('Buena temporada — consistentemente en mitad de tabla');
      }
    }

    if (strengths.isEmpty) {
      strengths.add('Equipo compensado — no hay debilidades evidentes');
    }

    return strengths;
  }

  List<String> _identifyWeaknesses(List<Player> players, LeagueStanding? standing) {
    final weaknesses = <String>[];
    
    // Analizar ataque
    final forwards = players.where((p) => p.position == 'FWD').toList();
    if (forwards.isNotEmpty) {
      final avgShooting = forwards.map((p) => p.stats[1]).reduce((a, b) => a + b) / forwards.length;
      if (avgShooting < 65) {
        weaknesses.add('Falta de gol — tienen problemas para marcar');
      }
    }

    // Analizar defensa
    final defenders = players.where((p) => p.position == 'DEF' || p.position == 'GK').toList();
    if (defenders.isNotEmpty) {
      final avgDefense = defenders.map((p) => p.stats[3]).reduce((a, b) => a + b) / defenders.length;
      if (avgDefense < 65) {
        weaknesses.add('Defensa vulnerable — sufren mucho en su área');
      }
    }

    // Analizar condición física
    final avgFitness = players.map((p) => p.stats[4]).reduce((a, b) => a + b) / players.length;
    if (avgFitness < 68) {
      weaknesses.add('Poca intensidad — bajan el ritmo en la segunda parte');
    }

    // Analizar estado de forma
    if (standing != null) {
      if (standing.points <= 10) {
        weaknesses.add('Mala racha — están en zona de descenso');
      }
    }

    if (weaknesses.isEmpty) {
      weaknesses.add('Poca profundidad de plantilla — suplentes no dan garantías');
    }

    return weaknesses;
  }

  List<String> _identifyDangerPlayers(List<Player> players) {
    final sorted = List<Player>.from(players)
      ..sort((a, b) => b.average.compareTo(a.average));
    return sorted.take(3).map((p) => p.name).toList();
  }

  (String, TeamMentality, TeamStyle) _generateRecommendations(double opponentStrength, List<String> strengths, List<String> weaknesses) {
    String formation;
    TeamMentality mentality;
    TeamStyle style;

    // Si el rival es muy fuerte
    if (opponentStrength >= 80) {
      formation = '5-3-2';
      mentality = TeamMentality.defensive;
      style = TeamStyle.counterAttack;
    } 
    // Si el rival es débil
    else if (opponentStrength <= 60) {
      formation = '4-3-3';
      mentality = TeamMentality.attacking;
      style = TeamStyle.possession;
    } 
    // Rival equilibrado
    else {
      formation = '4-4-2';
      mentality = TeamMentality.balanced;
      
      // Ajustar según debilidades del rival
      if (weaknesses.any((w) => w.contains('defensa') || w.contains('vulnerable'))) {
        style = TeamStyle.direct;
        mentality = TeamMentality.attacking;
      } else if (weaknesses.any((w) => w.contains('intensidad') || w.contains('segunda'))) {
        style = TeamStyle.direct;
        mentality = TeamMentality.attacking;
      } else {
        style = TeamStyle.possession;
      }
    }

    return (formation, mentality, style);
  }

  String _generatePrediction(double opponentStrength, String opponentName) {
    final predictions = <String>[];
    
    if (opponentStrength >= 80) {
      predictions.add('Partido complicado — $opponentName es uno de los mejores equipos');
      predictions.add('Necesitarás un partido perfecto para ganar');
      predictions.add('El punto sería un gran resultado');
    } else if (opponentStrength >= 70) {
      predictions.add('Partido equilibrado — quien mejor aproveche las ocasiones ganará');
      predictions.add('Dependerá de tu planteamiento táctico');
      predictions.add('Tienes opciones si juegas a tu fortaleza');
    } else if (opponentStrength >= 60) {
      predictions.add('Favoritos — pero no confíes, cualquier error puede ser fatal');
      predictions.add('Deberías ganar, pero no será fácil');
      predictions.add('$opponentName luchará hasta el final');
    } else {
      predictions.add('Partido a ganar — no hay excusas');
      predictions.add('Tu equipo es superior en todos los aspectos');
      predictions.add('Gana con autoridad y da confianza a la afición');
    }

    return predictions[_rng.nextInt(predictions.length)];
  }
}
