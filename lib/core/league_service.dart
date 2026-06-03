import 'dart:math';
import 'package:isar/isar.dart';
import '../models/league_fixture.dart';
import '../models/league_standing.dart';
import '../models/team.dart';
import '../models/finance_model.dart';
import '../models/player_model.dart';

class LeagueService {
  final Isar isar;
  final _rng = Random();

  LeagueService(this.isar);

  Future<void> createSeason(int userTeamApiId) async {
    final teams = await isar.teams.where().findAll();
    if (teams.length < 2) {
      throw StateError("Se necesitan al menos 2 equipos en la liga.");
    }

    final teamIds = teams.map((t) => t.apiId).toList();
    final firstLeg = _generateRoundRobinRounds(teamIds);
    final secondLeg = firstLeg
        .map((round) => round.map((p) => (p.$2, p.$1)).toList())
        .toList();
    final allRounds = [...firstLeg, ...secondLeg];

    final fixtures = <LeagueFixture>[];
    for (int i = 0; i < allRounds.length; i++) {
      final matchday = i + 1;
      for (final pair in allRounds[i]) {
        fixtures.add(LeagueFixture()
          ..matchday = matchday
          ..homeTeamApiId = pair.$1
          ..awayTeamApiId = pair.$2);
      }
    }

    final standings = teamIds
        .map((id) => LeagueStanding()..teamApiId = id)
        .toList();

    await isar.writeTxn(() async {
      await isar.leagueFixtures.clear();
      await isar.leagueStandings.clear();
      await isar.leagueFixtures.putAll(fixtures);
      await isar.leagueStandings.putAll(standings);
    });
  }

  List<List<(int, int)>> _generateRoundRobinRounds(List<int> teamIds) {
    final teams = List<int>.from(teamIds);
    if (teams.length % 2 == 1) teams.add(-1);

    final n = teams.length;
    final rounds = <List<(int, int)>>[];

    for (int r = 0; r < n - 1; r++) {
      final pairs = <(int, int)>[];
      for (int i = 0; i < n ~/ 2; i++) {
        final a = teams[i];
        final b = teams[n - 1 - i];
        if (a != -1 && b != -1) pairs.add((a, b));
      }
      rounds.add(pairs);
      final fixed = teams.first;
      final rotating = teams.sublist(1);
      final last = rotating.removeLast();
      rotating.insert(0, last);
      teams
        ..clear()
        ..add(fixed)
        ..addAll(rotating);
    }
    return rounds;
  }

  Future<LeagueFixture?> getUserFixture(int userTeamApiId, int matchday) async {
    final fixtures = await isar.leagueFixtures.filter().matchdayEqualTo(matchday).findAll();
    for (final f in fixtures) {
      if (f.competition != 'liga') continue;
      if (f.homeTeamApiId == userTeamApiId || f.awayTeamApiId == userTeamApiId) {
        return f;
      }
    }
    return null;
  }

  /// Simula todos los encuentros de IA de la jornada actual que aún estén pendientes.
  Future<void> simulateRestOfMatchday(int matchday, int userTeamApiId) async {
    // 1. Cargamos el mapa de clasificaciones en memoria caché para modificarlo rápidamente
    await _loadStandingCache();

    // 2. Traemos todos los partidos de la liga para la jornada actual
    final fixtures = await isar.leagueFixtures
        .filter()
        .matchdayEqualTo(matchday)
        .competitionEqualTo('liga')
        .findAll();

    final fixturesToUpdate = <LeagueFixture>[];

    for (final f in fixtures) {
      // Ignoramos los partidos jugados por el usuario o aquellos que ya fueron simulados previamente
      if (f.homeTeamApiId == userTeamApiId || f.awayTeamApiId == userTeamApiId || f.played) {
        continue;
      }

      // 3. Calculamos fuerzas y generamos marcador
      final hStr = await _teamStrength(f.homeTeamApiId);
      final aStr = await _teamStrength(f.awayTeamApiId);
      final (hg, ag) = _simulateScore(hStr, aStr);

      // 4. Actualizamos el objeto de partido
      f.homeGoals = hg;
      f.awayGoals = ag;
      f.played = true;

      fixturesToUpdate.add(f);

      // 5. Impactamos de manera local los puntos y estadísticas en la clasificación mapeada
      _updateStandingInMemory(f.homeTeamApiId, f.awayTeamApiId, hg, ag);
    }

    // 6. Guardamos todos los cambios de forma síncrona en una sola transacción Isar
    if (fixturesToUpdate.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.leagueFixtures.putAll(fixturesToUpdate);
        await isar.leagueStandings.putAll(_standingCache.values.toList());
      });
    }
  }

  Future<List<LeagueStanding>> getStandingsSorted() async {
    final all = await isar.leagueStandings.where().findAll();
    all.sort((a, b) {
      if (b.points != a.points) return b.points.compareTo(a.points);
      if (b.goalDifference != a.goalDifference) {
        return b.goalDifference.compareTo(a.goalDifference);
      }
      return b.goalsFor.compareTo(a.goalsFor);
    });
    return all;
  }

  Future<int?> getUserLeaguePosition(int userTeamApiId) async {
    final sorted = await getStandingsSorted();
    final idx = sorted.indexWhere((s) => s.teamApiId == userTeamApiId);
    return idx >= 0 ? idx + 1 : null;
  }

  Future<LeagueStanding?> getStanding(int teamApiId) async {
    return await isar.leagueStandings.filter().teamApiIdEqualTo(teamApiId).findFirst();
  }

  Future<void> loadStandingsCachePublic() => _loadStandingCache();

  void updateStandingInMemoryPublic(int homeId, int awayId, int hg, int ag) =>
      _updateStandingInMemory(homeId, awayId, hg, ag);

  int? userPositionFromCachePublic(int userTeamApiId) =>
      _userPositionFromCache(userTeamApiId);

  Future<void> persistStandingsCache() async {
    await isar.writeTxn(
      () => isar.leagueStandings.putAll(_standingCache.values.toList()),
    );
  }

  Future<(int, int)> simulateFixtureScore(int homeId, int awayId) async {
    final hStr = await _teamStrength(homeId);
    final aStr = await _teamStrength(awayId);
    return _simulateScore(hStr, aStr);
  }

  Future<void> applyMatchFinancePublic(ClubFinance finance, Team userTeam) async {
    await _applyMatchFinance(finance, userTeam);
  }

  Future<void> _applyMatchFinance(ClubFinance finance, Team userTeam) async {
    final attendance = (await _estimateAttendance(userTeam, finance.ticketPrice)).round();
    final ticketIncome = attendance * finance.ticketPrice;
    final sponsors = finance.sponsorSlot1Income +
        finance.sponsorSlot2Income +
        finance.sponsorSlot3Income;
    finance.sponsorIncomePerMatch = sponsors;
    final matchIncome = ticketIncome + sponsors - finance.stadiumMaintenance;
    finance.balance += matchIncome;
    finance.transferBudget += matchIncome * 0.12;
  }

  Future<double> _estimateAttendance(Team team, double ticketPrice) async {
    final finance = await isar.clubFinances.get(1);
    final capacity = team.stadiumCapacity + (finance?.stadiumExtraCapacity ?? 0);
    final fillRate = (45.0 / ticketPrice).clamp(0.35, 0.98);
    return capacity * fillRate;
  }

  final Map<int, LeagueStanding> _standingCache = {};

  Future<void> _loadStandingCache() async {
    _standingCache.clear();
    final all = await isar.leagueStandings.where().findAll();
    for (final s in all) {
      _standingCache[s.teamApiId] = s;
    }
  }

  int? _userPositionFromCache(int userTeamApiId) {
    final sorted = _standingCache.values.toList()
      ..sort((a, b) {
        if (b.points != a.points) return b.points.compareTo(a.points);
        if (b.goalDifference != a.goalDifference) {
          return b.goalDifference.compareTo(a.goalDifference);
        }
        return b.goalsFor.compareTo(a.goalsFor);
      });
    final idx = sorted.indexWhere((s) => s.teamApiId == userTeamApiId);
    return idx >= 0 ? idx + 1 : null;
  }

  void _updateStandingInMemory(int homeId, int awayId, int hg, int ag) {
    final home = _standingCache[homeId];
    final away = _standingCache[awayId];
    if (home == null || away == null) return;

    home.played++;
    away.played++;
    home.goalsFor += hg;
    home.goalsAgainst += ag;
    away.goalsFor += ag;
    away.goalsAgainst += hg;

    if (hg > ag) {
      home.wins++;
      home.points += 3;
      away.losses++;
    } else if (hg == ag) {
      home.draws++;
      away.draws++;
      home.points++;
      away.points++;
    } else {
      away.wins++;
      away.points += 3;
      home.losses++;
    }
  }

  Future<double> _teamStrength(int teamApiId) async {
    final players = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    if (players.isEmpty) return 70;
    return players.map((p) => p.average).reduce((a, b) => a + b) / players.length;
  }

  (int, int) _simulateScore(double homeStr, double awayStr) {
    final homeBias = homeStr / (homeStr + awayStr);
    int hg = 0, ag = 0;
    for (int i = 0; i < 8; i++) {
      if (_rng.nextDouble() < 0.12 * homeBias + 0.04) hg++;
      if (_rng.nextDouble() < 0.12 * (1 - homeBias) + 0.04) ag++;
    }
    return (hg.clamp(0, 5), ag.clamp(0, 5));
  }
}