import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/player_model.dart';

/// Entry de nombre real extraído de assets/data/players.json.
class _RealPlayerRecord {
  final String name;
  final String position;
  final int age;
  final String nationality;
  _RealPlayerRecord({
    required this.name,
    required this.position,
    required this.age,
    required this.nationality,
  });
}

/// Pool global de nombres REALES precargados desde assets/data/players.json.
/// Si la carga del JSON falla, se usa el pool legacy de nombres como último recurso.
class _RealNamePool {
  _RealNamePool._();
  static final _RealNamePool instance = _RealNamePool._();

  final List<_RealPlayerRecord> _all = [];
  final Map<String, List<_RealPlayerRecord>> _byPosition = {};
  bool _loaded = false;
  final _rng = Random();

  bool get isLoaded => _loaded;

  Future<void> load() async {
    if (_loaded) return;
    try {
      final data = await rootBundle.loadString('assets/data/players.json');
      final List<dynamic> list = json.decode(data);
      for (final e in list) {
        final map = e as Map<String, dynamic>;
        final name = (map['name'] as String? ?? '').trim();
        final posRaw = (map['position'] as String? ?? '').trim().toUpperCase();
        final age = (map['age'] as num?)?.toInt() ?? 24;
        if (name.isEmpty) continue;
        final pos = _normalizePosition(posRaw);
        final nationality = (map['nationality'] as String? ?? '').isEmpty
            ? 'ESP'
            : (map['nationality'] as String).toUpperCase();
        final rec = _RealPlayerRecord(
          name: name,
          position: pos,
          age: age.clamp(15, 38),
          nationality: nationality == 'ESP' ||
                  nationality == 'ARG' ||
                  nationality == 'BRA' ||
                  nationality == 'FRA' ||
                  nationality == 'POR' ||
                  nationality == 'NED' ||
                  nationality == 'GER' ||
                  nationality == 'ITA' ||
                  nationality == 'URU' ||
                  nationality == 'COL'
              ? nationality
              : 'ESP',
        );
        _all.add(rec);
        _byPosition.putIfAbsent(pos, () => []).add(rec);
      }
      _loaded = _all.isNotEmpty;
    } catch (e) {
      _loaded = false;
    }
  }

  String _normalizePosition(String raw) {
    if (raw.isEmpty) return 'MID';
    if (raw == 'POR' || raw == 'GK') return 'GK';
    if (raw == 'LI' || raw == 'LD' || raw == 'DFC' || raw == 'DEF' || raw == 'ED' || raw == 'EI') return 'DEF';
    if (raw == 'MCO' || raw == 'MC' || raw == 'MID' || raw == 'MOC' || raw == 'MD' || raw == 'MI') return 'MID';
    if (raw == 'DC' || raw == 'FWD' || raw == 'DL' || raw == 'DR' || raw == 'ED' || raw == 'EI') {
      if (raw == 'ED' || raw == 'EI') return 'DEF';
      return 'FWD';
    }
    if (raw == 'DC') return 'FWD';
    return 'MID';
  }

  _RealPlayerRecord pickAny() {
    if (!_loaded || _all.isEmpty) {
      return _legacyFallback();
    }
    return _all[_rng.nextInt(_all.length)];
  }

  _RealPlayerRecord pickForPosition(String pos) {
    final list = _byPosition[pos] ?? <_RealPlayerRecord>[];
    if (!_loaded || list.isEmpty) {
      return pickAny();
    }
    return list[_rng.nextInt(list.length)];
  }

  final _legacyFirsts = const [
    'Aitor', 'Bruno', 'César', 'Dani', 'Eneko', 'Fabio', 'Gorka', 'Hugo',
    'Iker', 'Joel', 'Kike', 'Luis', 'Mikel', 'Nico', 'Óscar', 'Pau',
    'Quique', 'Raúl', 'Santi', 'Thiago', 'Unai', 'Víctor', 'Yeray', 'Zak',
    'Adrián', 'Borja', 'Cristian', 'Diego', 'Enzo', 'Fran',
  ];
  final _legacyLasts = const [
    'Aguirre', 'Benítez', 'Carrasco', 'Domínguez', 'Espinosa', 'Fuentes',
    'Gallego', 'Herrero', 'Ibáñez', 'Jurado', 'Lozano', 'Mesa', 'Noriega',
    'Otero', 'Paredes', 'Quintana', 'Rivas', 'Soto', 'Tejero', 'Uribe',
    'Valero', 'Yuste', 'Zabala', 'Arroyo', 'Blasco', 'Cuesta',
  ];

  _RealPlayerRecord _legacyFallback() {
    return _RealPlayerRecord(
      name:
          '${_legacyFirsts[_rng.nextInt(_legacyFirsts.length)]} ${_legacyLasts[_rng.nextInt(_legacyLasts.length)]}',
      position: 'MID',
      age: 22 + _rng.nextInt(12),
      nationality: 'ESP',
    );
  }
}

/// Genera jugadores con NOMBRES REALES extraídos de assets/data/players.json
/// para complementar datos reales de la API. Si la API no devuelve suficientes
/// jugadores reales, estos rellenos usan nombres reales del pool y NUNCA
/// nombres inventados (salvo fallback extremo si el JSON no se puede leer).
class PlayerGenerator {
  static final _rng = Random();

  static const _positions = [
    'GK', 'DEF', 'DEF', 'DEF', 'MID', 'MID', 'MID', 'FWD', 'FWD'
  ];

  /// Carga asíncrona del pool de nombres reales. Debe llamarse en init().
  static Future<void> preloadRealNames() => _RealNamePool.instance.load();

  // ── Plantilla completa (fallback extremo sin API) ─────────────────────────
  //
  // Devuelve 75% de jugadores con NOMBRES REALES del pool (isGenerated=false)
  // y 25% restante generado (isGenerated=true). Así se cumple la regla 75/25
  // incluso si la API falla completamente.
  static List<Player> generateFullSquad(
    int teamApiId, {
    int size = 24,
    int seasonNumber = 1,
  }) {
    final out = <Player>[];
    final realCount = (size * 0.75).ceil();
    final genCount = size - realCount;
    final youthBetChance =
        (0.14 + (seasonNumber - 1) * 0.05).clamp(0.14, 0.45);

    for (var i = 0; i < realCount; i++) {
      final youthBet = _rng.nextDouble() < youthBetChance;
      out.add(_buildPlayer(
        teamApiId,
        youthBet: youthBet,
        markAsReal: true,
      ));
    }
    for (var i = 0; i < genCount; i++) {
      final youthBet = _rng.nextDouble() < youthBetChance;
      out.add(_buildPlayer(
        teamApiId,
        youthBet: youthBet,
        markAsReal: false,
      ));
    }
    return out;
  }

  // ── Complemento a plantilla real ─────────────────────────────────────────
  //
  // Rellena con jugadores (por defecto con nombres reales del pool, isGenerated=false).
  static List<Player> generateSupplementalPlayers(
    int teamApiId,
    int count, {
    int seasonNumber = 1,
    bool markAsReal = true,
  }) {
    final out = <Player>[];
    final youthBetChance =
        (0.14 + (seasonNumber - 1) * 0.05).clamp(0.14, 0.45);
    for (var i = 0; i < count; i++) {
      final youthBet = _rng.nextDouble() < youthBetChance;
      out.add(_buildPlayer(
        teamApiId,
        youthBet: youthBet,
        markAsReal: markAsReal,
      ));
    }
    return out;
  }

  // ── Jóvenes de reemplazo tras retirada ───────────────────────────────────
  //
  // Estos jugadores salen directamente como cantera (isYouth = true) y se
  // marcan con edades muy jóvenes para representar la siguiente generación.
  // Usan nombres reales del pool para que la cantera también tenga nombres veraces.

  static List<Player> generateYouthReplacements(
    int teamApiId,
    int count, {
    int seasonNumber = 1,
  }) {
    final out = <Player>[];
    for (var i = 0; i < count; i++) {
      final p = _buildPlayer(
        teamApiId,
        youthBet: true,
        forceYouth: true,
        markAsReal: true,
      );
      out.add(p);
    }
    return out;
  }

  // ── Generación de un jugador específico ───────────────────────────────────
  // Coge un NOMBRE REAL del pool para la posición dada.
  static Player generateSpecificPosition(
    int teamApiId,
    String position,
    int seasonNumber, {
    bool markAsReal = true,
  }) {
    final p = _buildPlayer(
      teamApiId,
      youthBet: false,
      markAsReal: markAsReal,
      preferredPosition: position,
    );
    p.position = position;
    p.stats = _statsForPosition(position, 70);
    return p;
  }

  // ── Constructor interno ───────────────────────────────────────────────────

  static Player _buildPlayer(
    int teamApiId, {
    required bool youthBet,
    bool forceYouth = false,
    bool markAsReal = true,
    String? preferredPosition,
  }) {
    String pos;
    _RealPlayerRecord record;
    if (preferredPosition != null) {
      pos = preferredPosition;
      record = _RealNamePool.instance.pickForPosition(pos);
    } else {
      pos = _positions[_rng.nextInt(_positions.length)];
      record = markAsReal
          ? _RealNamePool.instance.pickForPosition(pos)
          : _RealNamePool.instance.pickAny();
    }

    final age = forceYouth
        ? 15 + _rng.nextInt(4)
        : youthBet
            ? 16 + _rng.nextInt(4)
            : (record.age >= 15 ? record.age : 19 + _rng.nextInt(17));

    final base = _baseForAge(age, unicorn: youthBet);
    final stats = _statsForPosition(pos, base);
    final potential = _potentialFromStats(stats, age, unicorn: youthBet);
    final personality = _personalityForAge(age, youthBet);

    final marketValue = _value(stats, age);
    final salary = _salaryFromValue(marketValue, age);
    final contractYears = _contractDuration(age, personality);
    final buyoutClause = _buyoutClause(marketValue, personality, contractYears);

    return Player()
      ..name = record.name
      ..teamApiId = teamApiId
      ..teamId = markAsReal ? 'POOL' : 'GEN'
      ..age = age
      ..position = pos
      ..stats = stats
      ..potential = potential
      ..marketValue = marketValue
      ..salary = salary
      ..buyoutClause = buyoutClause
      ..contractYearsRemaining = contractYears
      ..personality = personality
      ..nationality = record.nationality
      ..isGenerated = !markAsReal
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