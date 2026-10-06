import 'dart:math';
import 'package:isar/isar.dart';
import '../models/finance_model.dart';
import '../models/league_fixture.dart';
import '../models/game_save.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import '../models/game_message.dart';
import 'game_calendar.dart';
import 'league_service.dart';
import 'message_service.dart';
import 'finance_service.dart';
import 'match_discipline_service.dart';
import 'press_service.dart';
import 'financial_guard_service.dart';
import 'board_service.dart';
import 'transfer_ai_service.dart';
import 'loan_service.dart';
import 'cup_service.dart';
import 'youth_service.dart';

/// Calendario unificado: copa y liga en la misma jornada (PC Fútbol 7).
class CalendarService {
  final Isar isar;
  final _rng = Random();

  CalendarService(this.isar);

  static const cupMatchdays = {1: 6, 2: 18, 3: 30, 4: 38};
  static const int matchdayDay = 7;

  Future<List<LeagueFixture>> getFullUserCalendar(int userTeamApiId) async {
    final all = await isar.leagueFixtures.where().findAll();
    final filtered = all.where((f) =>
        f.homeTeamApiId == userTeamApiId || f.awayTeamApiId == userTeamApiId).toList();
    filtered.sort((a, b) {
      if (a.matchday != b.matchday) return a.matchday.compareTo(b.matchday);
      if (a.competition == b.competition) return 0;
      return a.competition == 'copa' ? -1 : 1;
    });
    return filtered;
  }

  Future<String> advanceDay(int userTeamApiId) async {
    final save = await isar.gameSaves.get(1);
    if (save == null || save.seasonFinished || save.financiallyDismissed) {
      return 'No hay partida activa.';
    }

    final pending = await getUserPendingFixtures(userTeamApiId);
    if (save.currentDay >= matchdayDay && pending.isNotEmpty) {
      return 'Tienes ${pending.length} partido(s) pendiente(s). Juega antes de pasar más días.';
    }

    save.currentDay++;
    if (save.currentDay > 7) {
      save.currentDay = 1;
    }

    save.trainingFocusesUsedToday = [];

    await isar.writeTxn(() => isar.gameSaves.put(save));

    // Movimiento de mercado diario para que ofertas/rumores estén vivos.
    await TransferAiService(isar).generateDailyMarketActivity(userTeamApiId, save.currentMatchday, save.currentDay);

    final pendingAfter = await getUserPendingFixtures(userTeamApiId);
    if (save.currentDay == matchdayDay && pendingAfter.isNotEmpty) {
      await MessageService(isar).add(
        title: 'Día de partido',
        body: 'Hoy hay ${pendingAfter.length} encuentro(s) en tu calendario.',
        type: MessageType.general,
      );
    }

    return '${GameCalendar.formatShort(seasonNumber: save.seasonNumber, matchday: save.currentMatchday, dayOfWeek: save.currentDay)} completado.';
  }

  Future<List<LeagueFixture>> getUserPendingFixtures(int userTeamApiId) async {
    final save = await isar.gameSaves.get(1);
    if (save == null || save.seasonFinished || save.financiallyDismissed) {
      return [];
    }

    final md = save.currentMatchday;
    // Consulta filtrada directamente por el estado del fixture y la jornada
    final all = await isar.leagueFixtures
        .filter()
        .matchdayEqualTo(md)
        .playedEqualTo(false)
        .findAll();

    return all.where((f) {
      final involves = f.homeTeamApiId == userTeamApiId || f.awayTeamApiId == userTeamApiId;
      if (!involves) return false;
      if (f.competition == 'copa') {
        return save.inCup && f.cupRound == save.cupRound;
      }
      return true;
    }).toList()
      ..sort((a, b) {
        if (a.competition == b.competition) return 0;
        return a.competition == 'copa' ? -1 : 1;
      });
  }

  Future<Team?> opponentFor(LeagueFixture f, int userTeamApiId) async {
    final rivalId =
        f.homeTeamApiId == userTeamApiId ? f.awayTeamApiId : f.homeTeamApiId;
    return isar.teams.filter().apiIdEqualTo(rivalId).findFirst();
  }

  bool userIsHome(LeagueFixture f, int userTeamApiId) =>
      f.homeTeamApiId == userTeamApiId;

  Future<void> recordUserMatch({
    required LeagueFixture fixture,
    required int userTeamApiId,
    required int userGoals,
    required int opponentGoals,
    required bool userWasHome,
    required Team userTeam,
  }) async {
    final save = await isar.gameSaves.get(1);
    if (save == null || fixture.played) return;

    final homeGoals = userWasHome ? userGoals : opponentGoals;
    final awayGoals = userWasHome ? opponentGoals : userGoals;

    fixture.played = true;
    fixture.homeGoals = homeGoals;
    fixture.awayGoals = awayGoals;

    final league = LeagueService(isar);
    await league.loadStandingsCachePublic();

    if (fixture.competition == 'liga') {
      league.updateStandingInMemoryPublic(
        fixture.homeTeamApiId,
        fixture.awayTeamApiId,
        homeGoals,
        awayGoals,
      );

      await league.persistStandingsCache();
    } else {
      await _resolveCup(fixture, userTeamApiId, userWasHome, homeGoals, awayGoals, save);
    }

    await PressService(isar).publishMatchReaction(
      userTeam: userTeam,
      userGoals: userGoals,
      opponentGoals: opponentGoals,
      competition: fixture.competition,
    );

    await isar.writeTxn(() => isar.leagueFixtures.put(fixture));

    final pending = await getUserPendingFixtures(userTeamApiId);
    if (pending.isEmpty) {
      await _completeMatchday(userTeamApiId, userTeam, save);
    }
  }

  String _safeRoundName(int round) {
    const names = ['', 'Octavos', 'Cuartos', 'Semifinal', 'Final'];
    if (round < 1 || round > 4) return 'Copa del Rey';
    return names[round];
  }

  Future<void> _resolveCup(
    LeagueFixture f,
    int userTeamApiId,
    bool userWasHome,
    int homeGoals,
    int awayGoals,
    GameSave save,
  ) async {
    var userWon = userWasHome ? homeGoals > awayGoals : awayGoals > homeGoals;
    if (homeGoals == awayGoals) userWon = _rng.nextBool();

    final messages = MessageService(isar);

    if (!userWon) {
      save.inCup = false;
      await messages.add(
        title: 'Eliminados de Copa',
        body: 'Derrota en ${_safeRoundName(f.cupRound)}. La prensa habla de decepción.',
        type: MessageType.match,
      );
    } else if (f.cupRound >= 4) {
      save.inCup = false;
      save.trophies = [...save.trophies, 'Copa del Rey ${save.seasonNumber}'];
      await messages.add(
        title: '¡Campeones de Copa!',
        body: 'La ciudad celebra el título copero.',
        type: MessageType.board,
      );
    } else {
      final next = f.cupRound + 1;
      // Guard ante datos corruptos: si next fuera de rango, cerrar copa.
      if (next < 1 || next > 4) {
        save.inCup = false;
      } else {
        save.cupRound = next;
        final md = cupMatchdays[next]!;
        await _scheduleCupFixture(userTeamApiId, next, md);
        await messages.add(
          title: 'Copa — clasificados',
          body: 'Pasan a ${_safeRoundName(next)}.',
          type: MessageType.match,
        );
      }
    }
    // Sincronizar CupFixture espejo (CupService) para no tener doble fuente
    // divergente: marcamos la misma ronda como jugada con el mismo marcador.
    try {
      await CupService(isar).syncMirrorFromLeague(
        round: f.cupRound,
        homeGoals: homeGoals,
        awayGoals: awayGoals,
      );
    } catch (_) {
      // No bloquear jornada si el espejo falla.
    }
    await isar.writeTxn(() => isar.gameSaves.put(save));
  }

  Future<void> _scheduleCupFixture(int userTeamApiId, int round, int matchday) async {
    final teams = await isar.teams.where().findAll();
    final rivals = teams.where((t) => t.apiId != userTeamApiId).toList();
    if (rivals.isEmpty) return;
    rivals.shuffle(_rng);
    final opp = rivals.first;
    final userHome = _rng.nextBool();
    final homeId = userHome ? userTeamApiId : opp.apiId;
    final awayId = userHome ? opp.apiId : userTeamApiId;

    await isar.writeTxn(() => isar.leagueFixtures.put(LeagueFixture()
      ..matchday = matchday
      ..competition = 'copa'
      ..cupRound = round
      ..homeTeamApiId = homeId
      ..awayTeamApiId = awayId));
    // Espejo en CupFixture con los mismos equipos para la UI de copa.
    try {
      await CupService(isar).syncMirrorSchedule(
        round: round,
        homeTeamApiId: homeId,
        awayTeamApiId: awayId,
      );
    } catch (_) {
      // No bloquear si el espejo falla.
    }
  }

  Future<void> initCupForSeason(int userTeamApiId) async {
    final save = await isar.gameSaves.get(1);
    if (save == null) return;
    save.inCup = true;
    save.cupRound = 1;
    await isar.writeTxn(() => isar.gameSaves.put(save));
    await _scheduleCupFixture(userTeamApiId, 1, cupMatchdays[1]!);
    await MessageService(isar).add(
      title: 'Copa del Rey',
      body: 'Tu eliminatoria empieza en la jornada 6, el mismo día que la liga.',
      type: MessageType.general,
    );
  }

  Future<bool> _userPlayedHomeInMatchday(int userTeamApiId, int matchday) async {
    final played = await isar.leagueFixtures
        .filter()
        .matchdayEqualTo(matchday)
        .playedEqualTo(true)
        .findAll();
    return played.any((f) => f.homeTeamApiId == userTeamApiId);
  }

  Future<void> _completeMatchday(int userTeamApiId, Team userTeam, GameSave save) async {
    final md = save.currentMatchday;
    final league = LeagueService(isar);
    await league.loadStandingsCachePublic();

    final others = await isar.leagueFixtures
        .filter()
        .matchdayEqualTo(md)
        .competitionEqualTo('liga')
        .playedEqualTo(false)
        .findAll();

    for (final f in others) {
      final sim = await league.simulateFixtureScore(f.homeTeamApiId, f.awayTeamApiId);
      f.played = true;
      f.homeGoals = sim.$1;
      f.awayGoals = sim.$2;
      league.updateStandingInMemoryPublic(f.homeTeamApiId, f.awayTeamApiId, sim.$1, sim.$2);
    }

    final position = league.userPositionFromCachePublic(userTeamApiId);
    // Fallback: si la caché se perdió, intentar lectura directa antes de
    // mostrar "?".
    int? shownPos = position;
    shownPos ??= await league.getUserLeaguePosition(userTeamApiId);
    await MessageService(isar).add(
      title: 'Jornada $md cerrada',
      body: 'Posición en liga: ${position ?? "?"}º.',
      type: MessageType.match,
    );

    await FinanceService(isar).deductStaffAndWages(save);
    await MatchDisciplineService(isar).tickRecovery(userTeamApiId);
    await LoanService(isar).tickLoanContracts(userTeamApiId, md);

    final finance = await isar.clubFinances.get(1);
    if (finance != null) {
      final playedHome = await _userPlayedHomeInMatchday(userTeamApiId, md);
      await league.applyMatchFinancePublic(
        finance,
        userTeam,
        userPlayedAtHome: playedHome,
      );
    }

    await FinancialGuardService(isar).afterMatchdayWeek(save, userTeam.name);

    if (!save.financiallyDismissed) {
      final board = BoardService(isar);
      await board.evaluateWeeklyAcceptance(
        save: save,
        userTeam: userTeam,
        leaguePosition: position ?? 10,
        finishedMatchday: md,
      );
      if (save.boardAcceptance <= 10) {
        await board.presidentDismissesManager(save, userTeam);
      }
    }

    save.currentMatchday++;
    save.currentDay = 1;
    if (save.currentMatchday > save.totalMatchdays) {
      // Última jornada jugada: evaluamos el cierre de temporada y, si el
      // entrenador no ha sido despedido, encadenamos automáticamente con
      // una nueva temporada y un calendario regenerado.
      await _finalizeAndChainNextSeason(userTeamApiId, userTeam, save, position);
      return;
    } else {
      await BoardService(isar).maybeMidSeasonWarning(save, position ?? 10);
    }

    await TransferAiService(isar).generateMatchdayOffers(userTeamApiId, save.currentMatchday);

    await isar.writeTxn(() async {
      await isar.leagueFixtures.putAll(others);
      await league.persistStandingsCache();
      await isar.gameSaves.put(save);
      if (finance != null) await isar.clubFinances.put(finance);
    });
  }

  /// Cierra la temporada actual, evalúa al presidente y, salvo despido,
  /// regenera el calendario de liga y copa y deja al usuario en la J1 de
  /// la siguiente temporada. Así la carrera avanza sin necesidad de
  /// pulsar manualmente "NUEVA TEMPORADA" en el menú.
  Future<void> _finalizeAndChainNextSeason(
    int userTeamApiId,
    Team userTeam,
    GameSave save,
    int? position,
  ) async {
    final league = LeagueService(isar);
    final pos = position ?? 20;

    // Cerramos la temporada actual: trofeos y despido.
    save.seasonFinished = true;
    if (pos == 1) {
      save.trophies = [...save.trophies, 'Liga ${save.seasonNumber}'];
    }
    await _tickContractsEndOfSeason(userTeamApiId);
    await BoardService(isar).evaluateSeasonEnd(save, pos);

    if (save.financiallyDismissed) {
      // No encadenamos nueva temporada si el entrenador ha sido cesado:
      // el juego se queda en la pantalla de despido como hasta ahora.
      await isar.writeTxn(() async {
        await league.persistStandingsCache();
        await isar.gameSaves.put(save);
      });
      return;
    }

    // Reseteo de flags de temporada para empezar la siguiente limpia.
    save.seasonFinished = false;
    save.currentMatchday = 1;
    save.currentDay = 1;
    save.seasonNumber++;
    save.inCup = true;
    save.cupRound = 1;
    save.consecutiveRedWeeks = 0;

    // Regeneramos liga (round-robin) y copa del Rey desde la J1.
    await league.createSeason(userTeamApiId);
    await CupService(isar).initCupForSeason(userTeamApiId);

    // Mensaje de "nueva temporada" y refresco de mercado y cantera.
    await MessageService(isar).add(
      title: 'Temporada ${save.seasonNumber}',
      body:
          'La liga se ha rehecho: nuevo calendario de 38 jornadas y Copa del Rey reiniciada. '
          'Mercado de fichajes abierto.',
      type: MessageType.board,
    );

    await YouthService(isar).scoutYouth(teamApiId: userTeamApiId, count: 4);
    await TransferAiService(isar)
        .generateMatchdayOffers(userTeamApiId, save.currentMatchday);

    await isar.writeTxn(() async {
      await league.persistStandingsCache();
      await isar.gameSaves.put(save);
    });
  }

  Future<void> _tickContractsEndOfSeason(int userTeamApiId) async {
    final squad = await isar.players
        .filter()
        .teamApiIdEqualTo(userTeamApiId)
        .isYouthEqualTo(false)
        .findAll();
    final toRemove = <Id>[];
    for (final p in squad) {
      if (p.onLoanFromTeamApiId > 0 || p.loanedOutToTeamApiId > 0) continue;
      p.contractYearsRemaining--;
      if (p.contractYearsRemaining <= 0) {
        toRemove.add(p.id);
        await MessageService(isar).add(
          title: 'Fin de contrato',
          body: '${p.name} no renueva y abandona el club.',
          type: MessageType.transfer,
        );
      }
    }
    await isar.writeTxn(() async {
      await isar.players.putAll(squad.where((p) => !toRemove.contains(p.id)).toList());
      for (final id in toRemove) {
        await isar.players.delete(id);
      }
    });
  }
}