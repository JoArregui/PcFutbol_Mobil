import 'package:isar/isar.dart';
import '../models/game_save.dart';
import '../models/game_message.dart';
import '../models/player_model.dart';
import '../models/staff_member.dart';
import '../models/team.dart';
import '../models/finance_model.dart';
import '../models/league_fixture.dart';
import 'league_service.dart';
import 'message_service.dart';
import 'calendar_service.dart';
import 'board_service.dart';
import 'youth_service.dart';
import 'squad_service.dart';

class GameSessionService {
  final Isar isar;

  GameSessionService(this.isar);

  static const int singletonId = 1;

  Future<GameSave?> getSave() => isar.gameSaves.get(singletonId);

  Future<bool> hasActiveSave() async {
    final save = await getSave();
    return save != null && !save.seasonFinished && !save.financiallyDismissed;
  }

  Future<bool> hasAnySave() async => (await getSave()) != null;

  Future<Team?> getUserTeam() async {
    final save = await getSave();
    if (save == null) return null;
    return isar.teams.filter().apiIdEqualTo(save.userTeamApiId).findFirst();
  }

  Future<LeagueFixture?> getCurrentUserFixture() async {
    final save = await getSave();
    if (save == null) return null;
    return LeagueService(isar).getUserFixture(save.userTeamApiId, save.currentMatchday);
  }

  Future<Team?> getCurrentOpponent() async {
    final fixture = await getCurrentUserFixture();
    if (fixture == null) return null;
    final save = await getSave();
    if (save == null) return null;
    final rivalId = fixture.homeTeamApiId == save.userTeamApiId
        ? fixture.awayTeamApiId
        : fixture.homeTeamApiId;
    return isar.teams.filter().apiIdEqualTo(rivalId).findFirst();
  }

  /// Verifica si el usuario ha jugado su partido y avanza la jornada simulando el resto.
  Future<void> checkAndAdvanceMatchday(Team userTeam) async {
    final save = await getSave();
    if (save == null || save.seasonFinished) return;

    final calendarService = CalendarService(isar);
    final pendingFixtures = await calendarService.getUserPendingFixtures(userTeam.apiId);

    // Si ya no quedan partidos del usuario pendientes en esta jornada, cerramos la jornada global
    if (pendingFixtures.isEmpty) {
      final leagueService = LeagueService(isar);
      
      // Simula el resto de partidos de la IA para la jornada actual
      await leagueService.simulateRestOfMatchday(save.currentMatchday, userTeam.apiId);

      // Avanzamos los parámetros del guardado hacia la nueva semana
      await isar.writeTxn(() async {
        if (save.currentMatchday >= save.totalMatchdays) {
          save.seasonFinished = true;
        } else {
          save.currentMatchday++;
          save.currentDay = 1; // Volvemos al Lunes (Día 1) de la nueva jornada
        }
        await isar.gameSaves.put(save);
      });

      // Enviamos notificación de resumen semanal a través del secretario
      await MessageService(isar).add(
        title: "Nueva Jornada ${save.currentMatchday}",
        body: "La jornada anterior ha concluido. Consulta las clasificaciones actualizadas y planifica los entrenamientos de esta semana.",
        type: MessageType.general,
      );
    }
  }

  Future<void> startSeason(Team userTeam, Map<StaffRole, StaffMember> staff) async {
    final league = LeagueService(isar);
    await league.createSeason(userTeam.apiId);

    final fixtures = await isar.leagueFixtures.where().findAll();
    var totalMatchdays = 38;
    for (final f in fixtures) {
      if (f.matchday > totalMatchdays) totalMatchdays = f.matchday;
    }

    final save = GameSave()
      ..id = singletonId
      ..userTeamApiId = userTeam.apiId
      ..currentMatchday = 1
      ..currentDay = 1
      ..totalMatchdays = totalMatchdays
      ..staffSecretaryName = staff[StaffRole.secretario]?.name ?? ''
      ..staffSecretaryLevel = staff[StaffRole.secretario]?.level ?? 0
      ..staffPreparatorName = staff[StaffRole.preparador]?.name ?? ''
      ..staffPreparatorLevel = staff[StaffRole.preparador]?.level ?? 0
      ..staffMedicoName = staff[StaffRole.medico]?.name ?? ''
      ..staffMedicoLevel = staff[StaffRole.medico]?.level ?? 0
      ..boardObjectiveLabel = 'En evaluación'
      ..boardAcceptance = 75
      ..boardLastFeedback =
          'El presidente te da la bienvenida. Cumple el objetivo deportivo y cuida las finanzas del club.'
      ..consecutiveRedWeeks = 0
      ..financiallyDismissed = false;

    await BoardService(isar).assignObjectives(save, userTeam);

    await SquadService(isar).ensureAllTeams();
    await SquadService(isar).ensureSquad(userTeam.apiId);

    await isar.writeTxn(() async {
      await isar.gameSaves.put(save);
      await _initClubFinances(userTeam);
    });

    await CalendarService(isar).initCupForSeason(userTeam.apiId);
    
    await YouthService(isar).scoutYouth(teamApiId: userTeam.apiId, count: 4);

    final msg = MessageService(isar);
    await msg.add(
      title: "Bienvenido a la temporada",
      body:
          "Presidente: «${userTeam.name} confía en ti. La liga empieza ya. Revisa la alineación antes del primer partido.»",
      type: MessageType.board,
    );
    await msg.add(
      title: "Plantilla lista",
      body:
          "Tu equipo está preparado. Contrata el cuerpo técnico en Staff y revisa la alineación antes del primer partido.",
      type: MessageType.general,
    );
  }

  /* /// ===========================================================================
  /// REINICIA TODO EL JUEGO:
  /// - Borra TODOS los datos (partida, equipos, jugadores, finanzas...)
  /// - Después, se volverá a sincronizar la API desde cero para datos frescos
  /// ===========================================================================
  Future<void> resetCareer() async {
    await isar.writeTxn(() async {
      // Datos de la partida
      await isar.gameSaves.clear();
      await isar.leagueFixtures.clear();
      await isar.leagueStandings.clear();
      await isar.userLineups.clear();
      await isar.gameMessages.clear();
      await isar.cupFixtures.clear();
      await isar.clubFinances.clear();
      await isar.transferOffers.clear();
      
      // 🔒 BORRAMOS TAMBIÉN EQUIPOS Y JUGADORES para volver a sincronizar desde API
      await isar.teams.clear();
      await isar.players.clear();
      
      debugPrint("🧹 CARRERA REINICIADA - TODOS los datos borrados.");
    });
  } */

  /// Nueva temporada con el mismo club (modo Liga Manager PCF7).
  Future<void> startNextSeason(Team userTeam) async {
    final save = await getSave();
    if (save == null || !save.seasonFinished) return;

    save.seasonFinished = false;
    save.currentMatchday = 1;
    save.currentDay = 1;
    save.seasonNumber++;
    save.inCup = true;
    save.cupRound = 1;
    save.consecutiveRedWeeks = 0;
    save.financiallyDismissed = false;

    await LeagueService(isar).createSeason(userTeam.apiId);
    await CalendarService(isar).initCupForSeason(userTeam.apiId);
    
    await YouthService(isar).scoutYouth(teamApiId: userTeam.apiId, count: 4);
    
    await SquadService(isar).ensureAllTeams();

    await isar.writeTxn(() => isar.gameSaves.put(save));

    await MessageService(isar).add(
      title: 'Temporada ${save.seasonNumber}',
      body:
          'El presidente confirma tu continuidad. Objetivo: repetir o superar el curso anterior.',
      type: MessageType.board,
    );
  }

  Future<int> professionalSquadCount(int userTeamApiId) async {
    return await isar.players
        .filter()
        .teamApiIdEqualTo(userTeamApiId)
        .isYouthEqualTo(false)
        .count();
  }

  Future<bool> meetsMinimumSquad(int userTeamApiId) async {
    final n = await professionalSquadCount(userTeamApiId);
    return n >= 16;
  }

  Future<void> _initClubFinances(Team team) async {
    await isar.clubFinances.put(ClubFinance()
      ..id = singletonId
      ..balance = team.budget.toDouble()
      ..transferBudget = team.budget * 0.5
      ..wageBill = team.budget * 0.12
      ..maxWageBill = team.budget * 0.35
      ..ticketPrice = 25.0
      ..stadiumMaintenance = 45000.0
      ..sponsorSlot1Brand = ""
      ..sponsorSlot1Income = 0
      ..sponsorSlot2Brand = ""
      ..sponsorSlot2Income = 0
      ..sponsorSlot3Brand = ""
      ..sponsorSlot3Income = 0
      ..sponsorIncomePerMatch = 0);
  }

  Future<bool> isDismissed() async {
    final save = await getSave();
    return save?.financiallyDismissed == true;
  }

  Future<double> trainingMultiplier() async {
    final save = await getSave();
    if (save == null) return 1.0;
    // Nivel 0 (sin preparador) → tratar como 1 (base) para no penalizar.
    final level = save.staffPreparatorLevel <= 1 ? 1 : save.staffPreparatorLevel;
    return 1.0 + (level - 1) * 0.08;
  }
}