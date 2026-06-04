import 'dart:math';
import '../models/match_event.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import 'tactics_service.dart';

/// Motor de partido estilo PC Fútbol 7: resumen por escrito con goles, tarjetas y lesiones.
class MatchEngine {
  final _rng = Random();

  static const _pressureComments = [
    "El balón circula por el centro del campo sin dueño claro...",
    "Juego trabado. Los aficionados piden más intensidad.",
    "Centro al área... la defensa despeja en última instancia.",
    "Tiro desde fuera del área. A las nubes.",
    "Gran parada del portero. El estadio ruge.",
    "Contraataque peligroso... se queda sin espacio.",
    "Córner para el local. Todo el mundo en el área.",
  ];

  List<MatchEvent> simulateMatch({
    required Team home,
    required Team away,
    required List<Player> homePlayers,
    required List<Player> awayPlayers,
    String homeFormation = '4-4-2',
    String awayFormation = '4-4-2',
    double medicoLevel = 1,
  }) {
    final first = simulatePeriod(
      home: home,
      away: away,
      homePlayers: homePlayers,
      awayPlayers: awayPlayers,
      homeFormation: homeFormation,
      awayFormation: awayFormation,
      medicoLevel: medicoLevel,
      startMinute: 1,
      endMinute: 45,
      initialHomeScore: 0,
      initialAwayScore: 0,
      kickoffMessage: "¡Arranca el partido! ${home.name} recibe a ${away.name}.",
    );

    final halfTimeScore = first.isNotEmpty ? first.last : null;
    final homeScore = halfTimeScore?.homeScore ?? 0;
    final awayScore = halfTimeScore?.awayScore ?? 0;

    final second = simulatePeriod(
      home: home,
      away: away,
      homePlayers: homePlayers,
      awayPlayers: awayPlayers,
      homeFormation: homeFormation,
      awayFormation: awayFormation,
      medicoLevel: medicoLevel,
      startMinute: 46,
      endMinute: 90,
      initialHomeScore: homeScore,
      initialAwayScore: awayScore,
      kickoffMessage: "¡Comienza la 2ª parte!",
    );

    return [...first, ...second];
  }

  List<MatchEvent> simulatePeriod({
    required Team home,
    required Team away,
    required List<Player> homePlayers,
    required List<Player> awayPlayers,
    required int startMinute,
    required int endMinute,
    required int initialHomeScore,
    required int initialAwayScore,
    String homeFormation = '4-4-2',
    String awayFormation = '4-4-2',
    double medicoLevel = 1,
    String? kickoffMessage,
  }) {
    int homeScore = initialHomeScore;
    int awayScore = initialAwayScore;
    final events = <MatchEvent>[];
    final homeMod = TacticsService.modifiers(homeFormation);
    final awayMod = TacticsService.modifiers(awayFormation);

    if (kickoffMessage != null) {
      events.add(MatchEvent(
        minute: startMinute == 1 ? 0 : startMinute,
        type: EventType.comment,
        description: kickoffMessage,
        homeScore: homeScore,
        awayScore: awayScore,
      ));
    }

    final homeStrength = _squadStrength(homePlayers) * homeMod.attack;
    final awayStrength = _squadStrength(awayPlayers) * awayMod.attack;
    final homeDef = _squadStrength(homePlayers) * homeMod.defense;
    final awayDef = _squadStrength(awayPlayers) * awayMod.defense;
    final homeBias = homeStrength / (homeStrength + awayStrength + 0.01);
    final homeConcedeBias = awayStrength / (homeDef + awayDef + 0.01);

    for (int min = startMinute; min <= endMinute; min++) {
      final roll = _rng.nextDouble();

      if (roll < 0.055 * homeBias + 0.02) {
        homeScore++;
        final scorer = _pickScorer(homePlayers);
        events.add(MatchEvent(
          minute: min,
          type: EventType.goal,
          isHomeTeam: true,
          description:
              "¡GOOOOL! ${scorer.name} (${home.name}). $homeScore - $awayScore",
          homeScore: homeScore,
          awayScore: awayScore,
        ));
      } else if (roll < 0.11 * homeBias + 0.04) {
        if (_rng.nextDouble() < homeConcedeBias * 0.85 + 0.08) {
          awayScore++;
          final scorer = _pickScorer(awayPlayers);
          events.add(MatchEvent(
            minute: min,
            type: EventType.goal,
            isHomeTeam: false,
            description:
                "¡GOOOOL! ${scorer.name} (${away.name}). $homeScore - $awayScore",
            homeScore: homeScore,
            awayScore: awayScore,
          ));
        }
      } else if (roll < 0.16) {
        final isHome = _rng.nextBool();
        final pool = isHome ? homePlayers : awayPlayers;
        if (pool.isNotEmpty) {
          final p = pool[_rng.nextInt(pool.length)];
          final yellow = _rng.nextDouble() < 0.82;
          events.add(MatchEvent(
            minute: min,
            type: EventType.card,
            isHomeTeam: isHome,
            description: yellow
                ? "Tarjeta amarilla para ${p.name}."
                : "¡ROJA! ${p.name} expulsado.",
            homeScore: homeScore,
            awayScore: awayScore,
            playerId: p.id,
            cardIsRed: !yellow,
          ));
        }
      } else if (roll < 0.19 && medicoLevel >= 1) {
        final injuryChance = (0.35 - (medicoLevel - 1) * 0.08).clamp(0.12, 0.4);
        if (_rng.nextDouble() < injuryChance) {
          final isHome = _rng.nextDouble() < 0.5;
          final pool = isHome ? homePlayers : awayPlayers;
          if (pool.isNotEmpty) {
            final p = pool[_rng.nextInt(pool.length)];
            events.add(MatchEvent(
              minute: min,
              type: EventType.injury,
              isHomeTeam: isHome,
              description: "Lesión de ${p.name}. Sale del campo cojeando.",
              homeScore: homeScore,
              awayScore: awayScore,
              playerId: p.id,
              injuryDays: 3 + _rng.nextInt(10),
            ));
          }
        }
      } else if (roll < 0.26) {
        events.add(MatchEvent(
          minute: min,
          type: EventType.chance,
          description: _pressureComments[_rng.nextInt(_pressureComments.length)],
          homeScore: homeScore,
          awayScore: awayScore,
        ));
      }

      if (min == 45 && endMinute >= 45) {
        events.add(MatchEvent(
          minute: 45,
          type: EventType.comment,
          description: "DESCANSO — ${home.name} $homeScore - $awayScore ${away.name}",
          homeScore: homeScore,
          awayScore: awayScore,
          isHalftime: true,
        ));
      }

      if (min == 90 && endMinute >= 90) {
        events.add(MatchEvent(
          minute: 90,
          type: EventType.comment,
          description: "FINAL — ${home.name} $homeScore - $awayScore ${away.name}",
          homeScore: homeScore,
          awayScore: awayScore,
          isFullTime: true,
        ));
      }
    }

    return events;
  }

  Stream<MatchEvent> playPeriod({
    required Team home,
    required Team away,
    required List<Player> homePlayers,
    required List<Player> awayPlayers,
    required int startMinute,
    required int endMinute,
    required int initialHomeScore,
    required int initialAwayScore,
    String homeFormation = '4-4-2',
    String awayFormation = '4-4-2',
    double speedMultiplier = 1.0,
    double medicoLevel = 1,
    String? kickoffMessage,
  }) async* {
    final timeline = simulatePeriod(
      home: home,
      away: away,
      homePlayers: homePlayers,
      awayPlayers: awayPlayers,
      homeFormation: homeFormation,
      awayFormation: awayFormation,
      medicoLevel: medicoLevel,
      startMinute: startMinute,
      endMinute: endMinute,
      initialHomeScore: initialHomeScore,
      initialAwayScore: initialAwayScore,
      kickoffMessage: kickoffMessage,
    );

    final delayMs = (400 / speedMultiplier).round().clamp(60, 1500);

    for (final event in timeline) {
      if (event.minute > 0) {
        await Future.delayed(Duration(milliseconds: delayMs));
      }
      yield event;
    }
  }

  Stream<MatchEvent> playMatch({
    required Team home,
    required Team away,
    required List<Player> homePlayers,
    required List<Player> awayPlayers,
    String homeFormation = '4-4-2',
    String awayFormation = '4-4-2',
    double speedMultiplier = 1.0,
    double medicoLevel = 1,
  }) async* {
    yield* playPeriod(
      home: home,
      away: away,
      homePlayers: homePlayers,
      awayPlayers: awayPlayers,
      homeFormation: homeFormation,
      awayFormation: awayFormation,
      speedMultiplier: speedMultiplier,
      medicoLevel: medicoLevel,
      startMinute: 1,
      endMinute: 90,
      initialHomeScore: 0,
      initialAwayScore: 0,
      kickoffMessage: "¡Arranca el partido! ${home.name} recibe a ${away.name}.",
    );
  }

  double _squadStrength(List<Player> players) {
    final available =
        players.where((p) => p.injuredDays <= 0 && p.suspendedMatches <= 0);
    final pool = available.isNotEmpty ? available : players;
    if (pool.isEmpty) return 70;
    return pool.map((p) => p.average).reduce((a, b) => a + b) / pool.length;
  }

  Player _pickScorer(List<Player> players) {
    final forwards = players.where((p) => p.position == 'FWD').toList();
    final pool = forwards.isNotEmpty ? forwards : players;
    return pool[_rng.nextInt(pool.length)];
  }
}
