import 'dart:math';
import '../models/player_model.dart';

/// Genera jugadores ficticios para complementar datos reales de la API.
/// Todos los jugadores salen con sueldo, duración de contrato y cláusula de
/// rescisión realistas desde el primer momento.
class PlayerGenerator {
  static final _rng = Random();

  static const _first = [
    'Aitor', 'Bruno', 'César', 'Dani', 'Eneko', 'Fabio', 'Gorka', 'Hugo',
    'Iker', 'Joel', 'Kike', 'Luis', 'Mikel', 'Nico', 'Óscar', 'Pau',
    'Quique', 'Raúl', 'Santi', 'Thiago', 'Unai', 'Víctor', 'Yeray', 'Zak',
    'Adrián', 'Borja', 'Cristian', 'Diego', 'Enzo', 'Fran',
  ];
  static const _last = [
    'Aguirre', 'Benítez', 'Carrasco', 'Domínguez', 'Espinosa', 'Fuentes',
    'Gallego', 'Herrero', 'Ibáñez', 'Jurado', 'Lozano', 'Mesa', 'Noriega',
    'Otero', 'Paredes', 'Quintana', 'Rivas', 'Soto', 'Tejero', 'Uribe',
    'Valero', 'Yuste', 'Zabala', 'Arroyo', 'Blasco', 'Cuesta',
  ];
  static const _nations = [
    'ESP', 'ARG', 'BRA', 'FRA', 'POR', 'NED', 'GER', 'ITA', 'URU', 'COL'
  ];
  static const _positions = [
    'GK', 'DEF', 'DEF', 'DEF', 'MID', 'MID', 'MID', 'FWD', 'FWD'
  ];

  // ── Plantilla completa (fallback extremo sin API) ─────────────────────────

  static List<Player> generateFullSquad(
    int teamApiId, {
    int size = 24,
    int seasonNumber = 1,
  }) {
    return generateSupplementalPlayers(teamApiId, size,
        seasonNumber: seasonNumber);
  }

  // ── Complemento a plantilla real ─────────────────────────────────────────

  static List<Player> generateSupplementalPlayers(
    int teamApiId,
    int count, {
    int seasonNumber = 1,
  }) {
    final out = <Player>[];
    final youthBetChance =
        (0.14 + (seasonNumber - 1) * 0.05).clamp(0.14, 0.45);
    for (var i = 0; i < count; i++) {
      final youthBet = _rng.nextDouble() < youthBetChance;
      out.add(_buildPlayer(teamApiId, youthBet: youthBet));
    }
    return out;
  }

  // ── Jóvenes de reemplazo tras retirada ───────────────────────────────────
  //
  // Estos jugadores salen directamente como cantera (isYouth = true) y se
  // marcan con edades muy jóvenes para representar la siguiente generación.

  static List<Player> generateYouthReplacements(
    int teamApiId,
    int count, {
    int seasonNumber = 1,
  }) {
    final out = <Player>[];
    for (var i = 0; i < count; i++) {
      final p = _buildPlayer(teamApiId, youthBet: true, forceYouth: true);
      out.add(p);
    }
    return out;
  }

  // ── Generación de un jugador específico ───────────────────────────────────
  static Player generateSpecificPosition(int teamApiId, String position, int seasonNumber) {
    final p = _buildPlayer(teamApiId, youthBet: false);
    p.position = position;
    p.stats = _statsForPosition(position, 70); // Base media adecuada para inicio
    return p;
  }

  // ── Constructor interno ───────────────────────────────────────────────────

  static Player _buildPlayer(
    int teamApiId, {
    required bool youthBet,
    bool forceYouth = false,
  }) {
    final pos = _positions[_rng.nextInt(_positions.length)];
    final age = forceYouth
        ? 15 + _rng.nextInt(4) // 15-18 para canteranos
        : youthBet
            ? 16 + _rng.nextInt(4) // 16-19 para apuestas
            : 19 + _rng.nextInt(17); // 19-35 para el resto

    final base = _baseForAge(age, unicorn: youthBet);
    final stats = _statsForPosition(pos, base);
    final potential = _potentialFromStats(stats, age, unicorn: youthBet);
    final personality = _personalityForAge(age, youthBet);

    final marketValue = _value(stats, age);
    final salary = _salaryFromValue(marketValue, age);
    final contractYears = _contractDuration(age, personality);
    final buyoutClause = _buyoutClause(marketValue, personality, contractYears);

    return Player()
      ..name =
          '${_first[_rng.nextInt(_first.length)]} ${_last[_rng.nextInt(_last.length)]}'
      ..teamApiId = teamApiId
      ..teamId = 'GEN'
      ..age = age
      ..position = pos
      ..stats = stats
      ..potential = potential
      ..marketValue = marketValue
      ..salary = salary
      ..buyoutClause = buyoutClause
      ..contractYearsRemaining = contractYears
      ..personality = personality
      ..nationality = _nations[_rng.nextInt(_nations.length)]
      ..isGenerated = true
      ..isUnicorn = youthBet
      ..isYouth = forceYouth;
  }

  // ── Helpers de estadísticas ───────────────────────────────────────────────

  static int _baseForAge(int age, {required bool unicorn}) {
    if (unicorn) return 50 + _rng.nextInt(14);
    if (age <= 21) return 62 + _rng.nextInt(14);
    if (age <= 26) return 70 + _rng.nextInt(12);
    if (age <= 30) return 74 + _rng.nextInt(10);
    return 68 + _rng.nextInt(12);
  }

  static List<int> _statsForPosition(String pos, int base) {
    int j() => (base + _rng.nextInt(9) - 4).clamp(40, 99);
    switch (pos) {
      case 'GK':
        return [j(), j() - 8, j() - 5, j() + 5, j() + 3];
      case 'DEF':
        return [j() - 3, j() - 10, j() - 2, j() + 8, j() + 4];
      case 'FWD':
        return [j() + 5, j() + 8, j() - 2, j() - 8, j() + 2];
      default:
        return [j(), j(), j() + 4, j() - 2, j()];
    }
  }

  static int _potentialFromStats(List<int> stats, int age,
      {required bool unicorn}) {
    if (unicorn) return 86 + _rng.nextInt(12);
    final avg = stats.reduce((a, b) => a + b) / stats.length;
    return (avg + 8 + (25 - age).clamp(0, 12)).round().clamp(72, 94);
  }

  static Personality _personalityForAge(int age, bool youthBet) {
    if (youthBet) return Personality.ambitious;
    if (age >= 30) {
      // Más variación en veteranos
      return [
        Personality.professional,
        Personality.loyal,
        Personality.greedy,
      ][_rng.nextInt(3)];
    }
    return Personality.values[_rng.nextInt(Personality.values.length)];
  }

  // ── Financiero (públicos para uso desde ApiService) ──────────────────────

  /// Sueldo a partir del valor de mercado y la edad.
  static double salaryFromValue(double value, int age) =>
      _salaryFromValue(value, age);

  /// Duración del contrato según edad y personalidad.
  static int contractDuration(int age, Personality personality) =>
      _contractDuration(age, personality);

  /// Cláusula de rescisión según valor, personalidad y años de contrato.
  static double buyoutClause(
          double value, Personality personality, int contractYears) =>
      _buyoutClause(value, personality, contractYears);

  static double _value(List<int> stats, int age) {
    final avg = stats.reduce((a, b) => a + b) / stats.length;
    final ageFactor = age <= 28
        ? 1.0 + (age - 20) * 0.04
        : 1.0 - (age - 28) * 0.07;
    return (avg * avg * 12000 * ageFactor.clamp(0.2, 1.6))
        .clamp(100000, 180000000);
  }

  /// Sueldo = ~4-5% del valor de mercado, con bandas por edad
  static double _salaryFromValue(double value, int age) {
    double ratio = 0.045;
    if (age <= 21) ratio = 0.030; // jóvenes cobran menos
    if (age >= 32) ratio = 0.050; // veteranos negocian más
    return (value * ratio).clamp(15000, 750000);
  }

  /// Duración del contrato: jóvenes firman más corto, pico más largo
  static int _contractDuration(int age, Personality personality) {
    if (age <= 19) return 2 + _rng.nextInt(2); // 2-3 años
    if (age <= 24) return 3 + _rng.nextInt(3); // 3-5 años
    if (age <= 29) return 2 + _rng.nextInt(3); // 2-4 años
    if (age <= 32) return 1 + _rng.nextInt(2); // 1-2 años
    return 1; // veteranos: 1 año
  }

  /// Cláusula de rescisión según personalidad y duración del contrato.
  /// - greedy: cláusula muy alta (4-5x valor)
  /// - ambitious: alta si contrato largo (3-4x)
  /// - loyal: baja (2-3x) — prefiere renovar a marcharse caro
  /// - professional: media (3-3.5x)
  static double _buyoutClause(
      double value, Personality personality, int contractYears) {
    double multiplier;
    switch (personality) {
      case Personality.greedy:
        multiplier = 4.5 + _rng.nextDouble() * 0.5; // 4.5-5x
        break;
      case Personality.ambitious:
        multiplier = contractYears >= 3
            ? 3.5 + _rng.nextDouble() * 0.5 // 3.5-4x si contrato largo
            : 2.8 + _rng.nextDouble() * 0.4; // 2.8-3.2x si corto
        break;
      case Personality.loyal:
        multiplier = 2.2 + _rng.nextDouble() * 0.6; // 2.2-2.8x
        break;
      case Personality.professional:
        multiplier = 3.0 + _rng.nextDouble() * 0.5; // 3.0-3.5x
        break;
    }
    // Si solo queda 1 año de contrato, la cláusula es irrelevante
    // (el jugador puede irse libre al terminar)
    if (contractYears <= 1) multiplier = 1.3;
    return value * multiplier;
  }
}