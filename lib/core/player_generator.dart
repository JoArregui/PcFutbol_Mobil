import 'dart:math';
import '../models/player_model.dart';

/// Genera jugadores ficticios para complementar datos reales de la API.
class PlayerGenerator {
  static final _rng = Random();

  static const _first = [
    'Aitor', 'Bruno', 'César', 'Dani', 'Eneko', 'Fabio', 'Gorka', 'Hugo', 'Iker', 'Joel',
    'Kike', 'Luis', 'Mikel', 'Nico', 'Óscar', 'Pau', 'Quique', 'Raúl', 'Santi', 'Thiago',
    'Unai', 'Víctor', 'Yeray', 'Zak', 'Adrián', 'Borja', 'Cristian', 'Diego', 'Enzo', 'Fran',
  ];
  static const _last = [
    'Aguirre', 'Benítez', 'Carrasco', 'Domínguez', 'Espinosa', 'Fuentes', 'Gallego', 'Herrero',
    'Ibáñez', 'Jurado', 'Lozano', 'Mesa', 'Noriega', 'Otero', 'Paredes', 'Quintana', 'Rivas',
    'Soto', 'Tejero', 'Uribe', 'Valero', 'Yuste', 'Zabala', 'Arroyo', 'Blasco', 'Cuesta',
  ];
  static const _nations = ['ESP', 'ARG', 'BRA', 'FRA', 'POR', 'NED', 'GER', 'ITA', 'URU', 'COL'];

  static const _positions = ['GK', 'DEF', 'DEF', 'DEF', 'MID', 'MID', 'MID', 'FWD', 'FWD'];

  /// Genera [count] jugadores inventados para ampliar plantilla.
  /// [seasonNumber] incrementa la probabilidad de generar apuestas jóvenes con el paso del tiempo.
  static List<Player> generateSupplementalPlayers(
    int teamApiId,
    int count, {
    int seasonNumber = 1,
  }) {
    final out = <Player>[];
    final youthBetChance = (0.14 + (seasonNumber - 1) * 0.05).clamp(0.14, 0.45);
    for (var i = 0; i < count; i++) {
      final youthBet = _rng.nextDouble() < youthBetChance;
      out.add(_regular(teamApiId, youthBet: youthBet));
    }
    return out;
  }

  /// Plantilla solo inventada (fallback extremo cuando no hay API).
  static List<Player> generateFullSquad(int teamApiId, {int size = 24, int seasonNumber = 1}) {
    return generateSupplementalPlayers(teamApiId, size, seasonNumber: seasonNumber);
  }

  static Player _regular(int teamApiId, {required bool youthBet}) {
    final pos = _positions[_rng.nextInt(_positions.length)];
    final age = youthBet ? 16 + _rng.nextInt(4) : 19 + _rng.nextInt(17);
    final base = _baseForAge(age, unicorn: false);
    final stats = _statsForPosition(pos, base);
    final potential = _potentialFromStats(stats, age, unicorn: youthBet);

    return Player()
      ..name = '${_first[_rng.nextInt(_first.length)]} ${_last[_rng.nextInt(_last.length)]}'
      ..teamApiId = teamApiId
      ..teamId = 'GEN'
      ..age = age
      ..position = pos
      ..stats = stats
      ..potential = potential
      ..marketValue = _value(stats, age)
      ..salary = _value(stats, age) * 0.04
      ..personality = youthBet ? Personality.ambitious : Personality.values[_rng.nextInt(Personality.values.length)]
      ..contractYearsRemaining = 2 + _rng.nextInt(4)
      ..nationality = _nations[_rng.nextInt(_nations.length)]
      ..isGenerated = true
      ..isUnicorn = youthBet;
  }

  static int _baseForAge(int age, {required bool unicorn}) {
    if (unicorn) return 55 + _rng.nextInt(12);
    if (age <= 21) return 62 + _rng.nextInt(14);
    if (age <= 26) return 70 + _rng.nextInt(12);
    if (age <= 30) return 74 + _rng.nextInt(10);
    return 68 + _rng.nextInt(12);
  }

  static List<int> _statsForPosition(String pos, int base) {
    int jitter() => (base + _rng.nextInt(9) - 4).clamp(40, 99);
    switch (pos) {
      case 'GK':
        return [jitter(), jitter() - 8, jitter() - 5, jitter() + 5, jitter() + 3];
      case 'DEF':
        return [jitter() - 3, jitter() - 10, jitter() - 2, jitter() + 8, jitter() + 4];
      case 'FWD':
        return [jitter() + 5, jitter() + 8, jitter() - 2, jitter() - 8, jitter() + 2];
      default:
        return [jitter(), jitter(), jitter() + 4, jitter() - 2, jitter()];
    }
  }

  static int _potentialFromStats(List<int> stats, int age, {required bool unicorn}) {
    if (unicorn) return 88 + _rng.nextInt(10);
    final avg = stats.reduce((a, b) => a + b) / stats.length;
    var pot = (avg + 8 + (25 - age).clamp(0, 12)).round();
    return pot.clamp(72, 94);
  }

  static double _value(List<int> stats, int age) {
    final avg = stats.reduce((a, b) => a + b) / stats.length;
    return avg * avg * 12000 * (1.0 + (25 - age).clamp(0, 10) * 0.05);
  }
}
