import 'dart:math';
import 'package:isar/isar.dart';
import '../models/cup_fixture.dart';
import '../models/game_save.dart';
import '../models/team.dart';
import 'message_service.dart';
import '../models/game_message.dart';

/// Copa del Rey simplificada (eliminatoria directa, estilo PC Fútbol 7).
class CupService {
  final Isar isar;
  final _rng = Random();

  CupService(this.isar);

  static const cupMatchdays = {1: 6, 2: 18, 3: 30, 4: 38};

  String roundName(int round) {
    switch (round) {
      case 1:
        return 'Octavos de final';
      case 2:
        return 'Cuartos de final';
      case 3:
        return 'Semifinal';
      case 4:
        return 'Final';
      default:
        return 'Copa del Rey';
    }
  }

  /// Crea el primer cruce de copa para el usuario al iniciar temporada.
  Future<void> initCupForSeason(int userTeamApiId) async {
    final teams = await isar.teams.where().findAll();
    final rivals = teams.where((t) => t.apiId != userTeamApiId).toList();
    if (rivals.isEmpty) return;

    rivals.shuffle(_rng);
    final opponent = rivals.first;
    final userHome = _rng.nextBool();

    await isar.writeTxn(() async {
      await isar.cupFixtures.clear();
      await isar.cupFixtures.put(CupFixture()
        ..round = 1
        ..homeTeamApiId = userHome ? userTeamApiId : opponent.apiId
        ..awayTeamApiId = userHome ? opponent.apiId : userTeamApiId);
    });

    final save = await isar.gameSaves.get(1);
    if (save != null) {
      save.inCup = true;
      save.cupRound = 1;
      await isar.writeTxn(() => isar.gameSaves.put(save));
    }

    await MessageService(isar).add(
      title: 'Copa del Rey',
      body:
          'El sorteo te empareja en octavos. Consulta el menú cuando toque la eliminatoria (jornadas 6, 18, 30 y 38).',
      type: MessageType.general,
    );
  }

  /// ¿Hay partido de copa pendiente en esta jornada de liga?
  Future<bool> hasCupMatchThisMatchday(int leagueMatchday, int userTeamApiId) async {
    final save = await isar.gameSaves.get(1);
    if (save == null || !save.inCup || save.seasonFinished) return false;

    final round = save.cupRound;
    if (round < 1 || round > 4) return false;
    if (cupMatchdays[round] != leagueMatchday) return false;

    final fixture = await _userFixture(round);
    return fixture != null && !fixture.played;
  }

  Future<CupFixture?> getCurrentUserCupFixture() async {
    final save = await isar.gameSaves.get(1);
    if (save == null || !save.inCup) return null;
    return _userFixture(save.cupRound);
  }

  Future<CupFixture?> _userFixture(int round) async {
    return await isar.cupFixtures.filter().roundEqualTo(round).findFirst();
  }

  Future<Team?> getCupOpponent(int userTeamApiId) async {
    final f = await getCurrentUserCupFixture();
    if (f == null) return null;
    final rivalId =
        f.homeTeamApiId == userTeamApiId ? f.awayTeamApiId : f.homeTeamApiId;
    return isar.teams.filter().apiIdEqualTo(rivalId).findFirst();
  }

  Future<bool> userIsHome(int userTeamApiId) async {
    final f = await getCurrentUserCupFixture();
    if (f == null) return true;
    return f.homeTeamApiId == userTeamApiId;
  }

  Future<void> recordCupResult({
    required int userTeamApiId,
    required int userGoals,
    required int opponentGoals,
    required bool userWasHome,
  }) async {
    final save = await isar.gameSaves.get(1);
    if (save == null || !save.inCup) return;

    final f = await _userFixture(save.cupRound);
    if (f == null || f.played) return;

    final homeGoals = userWasHome ? userGoals : opponentGoals;
    final awayGoals = userWasHome ? opponentGoals : userGoals;

    f.played = true;
    f.homeGoals = homeGoals;
    f.awayGoals = awayGoals;

    var userWon = userWasHome ? homeGoals > awayGoals : awayGoals > homeGoals;
    if (homeGoals == awayGoals) {
      userWon = _rng.nextBool();
    }
    final messages = MessageService(isar);

    if (!userWon) {
      save.inCup = false;
      await messages.add(
        title: 'Eliminados de Copa',
        body:
            'Derrota en ${roundName(save.cupRound)}. La afición lamenta la eliminación.',
        type: MessageType.match,
      );
    } else if (save.cupRound >= 4) {
      save.inCup = false;
      save.trophies = [...save.trophies, 'Copa del Rey ${save.seasonNumber}'];
      await messages.add(
        title: '¡CAMPEONES DE COPA!',
        body: 'Histórica final. El trofeo vuelve a las vitrinas del club.',
        type: MessageType.board,
      );
    } else {
      final nextRound = save.cupRound + 1;
      final teams = await isar.teams.where().findAll();
      final rivals = teams.where((t) => t.apiId != userTeamApiId).toList();
      rivals.shuffle(_rng);
      final nextOpp = rivals.first;
      final userHome = _rng.nextBool();

      await isar.cupFixtures.put(CupFixture()
        ..round = nextRound
        ..homeTeamApiId = userHome ? userTeamApiId : nextOpp.apiId
        ..awayTeamApiId = userHome ? nextOpp.apiId : userTeamApiId);

      save.cupRound = nextRound;
      await messages.add(
        title: 'Copa — clasificados',
        body:
            'Pasan a ${roundName(nextRound)}. El presidente felicita al vestuario.',
        type: MessageType.match,
      );
    }

    await isar.writeTxn(() async {
      await isar.cupFixtures.put(f);
      await isar.gameSaves.put(save);
    });
  }
}
