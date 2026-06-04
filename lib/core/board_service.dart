import 'dart:math';
import 'package:isar/isar.dart';
import '../models/finance_model.dart';
import '../models/game_save.dart';
import '../models/game_message.dart';
import '../models/team.dart';
import 'message_service.dart';

class BoardWeeklyReport {
  final int acceptance;
  final String feedback;
  final bool canDismiss;

  const BoardWeeklyReport({
    required this.acceptance,
    required this.feedback,
    required this.canDismiss,
  });
}

class BoardService {
  final Isar isar;
  final _rng = Random();

  BoardService(this.isar);

  Future<void> assignObjectives(GameSave save, Team userTeam) async {
    final teams = await isar.teams.where().findAll();
    final avgBudget = teams.isEmpty
        ? 50000000
        : teams.map((t) => t.budget).reduce((a, b) => a + b) / teams.length;

    if (userTeam.budget >= avgBudget * 1.15) {
      save.boardObjectiveMaxPosition = 4;
      save.boardObjectiveLabel = 'Clasificarse para Europa (top 4)';
    } else if (userTeam.budget >= avgBudget * 0.85) {
      save.boardObjectiveMaxPosition = 10;
      save.boardObjectiveLabel = 'Media tabla (top 10)';
    } else {
      save.boardObjectiveMaxPosition = 17;
      save.boardObjectiveLabel = 'Salvar la categoría (top 17)';
    }

    await MessageService(isar).add(
      title: 'Objetivos del presidente',
      body:
          '«${save.boardObjectiveLabel}». El consejo vigilará la liga y la economía.',
      type: MessageType.board,
    );
  }

  /// Evalúa confianza tras cada jornada (resultados, finanzas, gestión del club).
  Future<BoardWeeklyReport> evaluateWeeklyAcceptance({
    required GameSave save,
    required Team userTeam,
    required int leaguePosition,
    required int finishedMatchday,
  }) async {
    double score = save.boardAcceptance.toDouble();

    // Resultados deportivos (~40%)
    final gap = leaguePosition - save.boardObjectiveMaxPosition;
    if (gap <= 0) {
      score += 6;
    } else if (gap <= 3) {
      score -= 4;
    } else if (gap <= 6) {
      score -= 9;
    } else {
      score -= 16;
    }

    final standing = await isar.leagueStandings
        .filter()
        .teamApiIdEqualTo(userTeam.apiId)
        .findFirst();
    if (standing != null && finishedMatchday > 0) {
      final ptsPerGame = standing.points / finishedMatchday;
      if (ptsPerGame >= 2.0) score += 4;
      if (ptsPerGame < 1.0) score -= 5;
    }

    // Finanzas (~35%)
    final finance = await isar.clubFinances.get(1);
    if (finance != null) {
      if (finance.balance < 0) {
        score -= 12 + save.consecutiveRedWeeks * 4.0;
      } else if (finance.balance < userTeam.budget * 0.15) {
        score -= 5;
      } else if (finance.balance >= userTeam.budget * 0.5) {
        score += 5;
      }
      if (finance.wageBill > finance.maxWageBill * 0.9) {
        score -= 4;
      }
    }

    // Gestión del club (~25%): staff, plantilla mínima
    if (save.staffSecretaryLevel >= 3) score += 2;
    if (save.staffPreparatorLevel >= 3) score += 2;
    if (save.staffMedicoLevel >= 3) score += 2;
    final squadCount = await isar.players
        .filter()
        .teamApiIdEqualTo(userTeam.apiId)
        .isYouthEqualTo(false)
        .count();
    if (squadCount < 18) score -= 6;
    if (squadCount >= 22) score += 2;

    final acceptance = score.round().clamp(0, 100);
    save.boardAcceptance = acceptance;
    save.boardLastFeedback = _feedbackFor(acceptance, leaguePosition, save, finance);

    await MessageService(isar).add(
      title: 'Informe del presidente — J$finishedMatchday',
      body: save.boardLastFeedback,
      type: MessageType.board,
    );

    return BoardWeeklyReport(
      acceptance: acceptance,
      feedback: save.boardLastFeedback,
      canDismiss: acceptance <= 20 && !save.financiallyDismissed,
    );
  }

  String _feedbackFor(
    int acceptance,
    int position,
    GameSave save,
    ClubFinance? finance,
  ) {
    if (acceptance >= 80) {
      return 'Excelente trabajo. Vas $positionº y la tesorería respalda el proyecto. Sigue así.';
    }
    if (acceptance >= 60) {
      return 'Aceptable. Posición $positionº; el objetivo sigue siendo ${save.boardObjectiveLabel}. Mantén el rumbo.';
    }
    if (acceptance >= 40) {
      final econ = finance != null && finance.balance < 0
          ? ' Las cuentas preocupan.'
          : '';
      return 'Tensión en el consejo: $positionº en liga, por debajo de lo esperado.$econ Mejora pronto.';
    }
    if (acceptance >= 20) {
      return 'Ultimátum: $positionº no convence y la directiva debate tu continuidad. Resultados y finanzas, ya.';
    }
    return 'Confianza mínima. El presidente puede prescindir de tus servicios en cualquier momento.';
  }

  Future<bool> presidentDismissesManager(GameSave save, Team userTeam) async {
    if (save.financiallyDismissed) return true;

    final chance = save.boardAcceptance <= 10
        ? 0.85
        : save.boardAcceptance <= 20
            ? 0.55
            : 0.0;
    if (chance == 0 || _rng.nextDouble() >= chance) return false;

    save.financiallyDismissed = true;
    save.boardLastFeedback =
        'El presidente de ${userTeam.name} ha decidido cesar tu contrato por falta de confianza.';
    await MessageService(isar).add(
      title: 'DESPEDIDO',
      body: save.boardLastFeedback,
      type: MessageType.board,
    );
    await isar.writeTxn(() => isar.gameSaves.put(save));
    return true;
  }

  Future<void> evaluateSeasonEnd(GameSave save, int finalPosition) async {
    final ok = finalPosition <= save.boardObjectiveMaxPosition;
    await MessageService(isar).add(
      title: ok ? 'Objetivo cumplido' : 'Objetivo incumplido',
      body: ok
          ? 'El presidente renueva la confianza. Has cumplido: ${save.boardObjectiveLabel}.'
          : 'El presidente está furioso. Has acabado $finalPositionº y se pedía ${save.boardObjectiveLabel}.',
      type: MessageType.board,
    );

    const double baseDismissalChance = 0.35;
    final double secretaryReduction = (save.staffSecretaryLevel - 1) * 0.03;
    final double dismissalChance = (baseDismissalChance - secretaryReduction).clamp(0.05, 0.9);

    if (!ok && _rng.nextDouble() < dismissalChance) {
      save.financiallyDismissed = true;
      await MessageService(isar).add(
        title: 'No continuarás',
        body: 'La directiva no renovará tu contrato por resultados deportivos.',
        type: MessageType.board,
      );
      await isar.writeTxn(() => isar.gameSaves.put(save));
    }
  }

  Future<void> maybeMidSeasonWarning(GameSave save, int position) async {
    if (save.currentMatchday != 19) return;
    if (position <= save.boardObjectiveMaxPosition) return;

    await MessageService(isar).add(
      title: 'Ultimátum del presidente',
      body:
          'Vas $positionº y el objetivo es ${save.boardObjectiveLabel}. Mejora o habrá consecuencias.',
      type: MessageType.board,
    );
  }
}
