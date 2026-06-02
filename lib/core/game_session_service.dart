import 'package:isar/isar.dart';
import '../models/game_save.dart';
import '../models/game_message.dart';
import '../models/staff_member.dart';
import '../models/team.dart';
import '../models/finance_model.dart';
import '../models/league_fixture.dart';
import '../models/league_standing.dart';
import '../models/user_lineup.dart';
import 'league_service.dart';
import 'lineup_service.dart';
import 'message_service.dart';
import 'calendar_service.dart';
import 'board_service.dart';
import 'youth_service.dart';
import 'squad_service.dart';
import '../models/player_model.dart';
import '../models/cup_fixture.dart';
import '../models/transfer_offer.dart';

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
      ..staffSecretaryName = staff[StaffRole.secretario]?.name ?? "Sin asignar"
      ..staffSecretaryLevel = staff[StaffRole.secretario]?.level ?? 1
      ..staffPreparatorName = staff[StaffRole.preparador]?.name ?? "Sin asignar"
      ..staffPreparatorLevel = staff[StaffRole.preparador]?.level ?? 1
      ..staffMedicoName = staff[StaffRole.medico]?.name ?? "Sin asignar"
      ..staffMedicoLevel = staff[StaffRole.medico]?.level ?? 1
      ..boardObjectiveLabel = 'En evaluación'
      ..consecutiveRedWeeks = 0
      ..financiallyDismissed = false;

    await BoardService(isar).assignObjectives(save, userTeam);

    await isar.writeTxn(() async {
      await isar.gameSaves.put(save);
      await _initClubFinances(userTeam);
    });

    await SquadService(isar).ensureAllTeams();
    await SquadService(isar).ensureSquad(userTeam.apiId);
    await LineupService(isar).autoPickBest11(userTeam.apiId);
    await CalendarService(isar).initCupForSeason(userTeam.apiId);
    await YouthService(isar).scoutYouth(userTeam.apiId);

    final msg = MessageService(isar);
    await msg.add(
      title: "Bienvenido a la temporada",
      body:
          "Presidente: «${userTeam.name} confía en ti. La liga empieza ya. Revisa la alineación antes del primer partido.»",
      type: MessageType.board,
    );
    await msg.add(
      title: "Secretario técnico",
      body:
          "${save.staffSecretaryName} informa: plantilla lista. Consulta clasificación y mercado cuando quieras.",
      type: MessageType.general,
    );
  }

  Future<void> resetCareer() async {
    await isar.writeTxn(() async {
      await isar.gameSaves.clear();
      await isar.leagueFixtures.clear();
      await isar.leagueStandings.clear();
      await isar.userLineups.clear();
      await isar.gameMessages.clear();
      await isar.cupFixtures.clear();
      await isar.clubFinances.clear();
      await isar.transferOffers.clear();
    });
  }

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
    await YouthService(isar).scoutYouth(userTeam.apiId);
    await SquadService(isar).ensureAllTeams();
    await LineupService(isar).autoPickBest11(userTeam.apiId);

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
    return 1.0 + (save.staffPreparatorLevel - 1) * 0.08;
  }
}
