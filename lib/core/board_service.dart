import 'dart:math';
import 'package:isar/isar.dart';
import '../models/finance_model.dart';
import '../models/game_save.dart';
import '../models/game_message.dart';
import '../models/league_standing.dart';
import '../models/player_model.dart';
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

/// Tipo de tema en la reunión semanal
enum MeetingTopic {
  results,
  finances,
  transfers,
  youth,
  tactics,
  morale
}

/// Resultado de una reunión semanal
class WeeklyMeeting {
  final MeetingTopic mainTopic;
  final String presidentMessage;
  final int acceptanceChange;
  final List<String> actionPoints;
  final bool warning;

  WeeklyMeeting({
    required this.mainTopic,
    required this.presidentMessage,
    required this.acceptanceChange,
    required this.actionPoints,
    required this.warning,
  });
}

class BoardService {
  final Isar isar;
  final _rng = Random();

  BoardService(this.isar);

  /// Asigna objetivos y requerimientos específicos al inicio de temporada
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

    // Añadir requerimientos específicos
    save.boardRequirements = _generateRequirements(save, userTeam);

    await MessageService(isar).add(
      title: 'Objetivos del presidente',
      body:
          '«${save.boardObjectiveLabel}». El consejo vigilará la liga y la economía.',
      type: MessageType.board,
    );

    await MessageService(isar).add(
      title: 'Requerimientos adicionales',
      body: _formatRequirements(save.boardRequirements),
      type: MessageType.board,
    );
  }

  /// Genera requerimientos específicos para la temporada
  List<BoardRequirement> _generateRequirements(GameSave save, Team userTeam) {
    final requirements = <BoardRequirement>[];

    // Siempre un requerimiento de cantera
    requirements.add(BoardRequirement()
      ..type = BoardRequirementType.promoteYouth
      ..description = 'Promover al menos 2 canteranos al primer equipo'
      ..targetValue = 2
      ..currentValue = 0
      ..deadline = DateTime.now().add(const Duration(days: 300)));

    // Requerimiento de porterías a cero
    requirements.add(BoardRequirement()
      ..type = BoardRequirementType.keepCleanSheets
      ..description = 'Mantener al menos 8 porterías a cero en liga'
      ..targetValue = 8
      ..currentValue = 0);

    // Requerimiento adicional según presupuesto
    if (userTeam.budget >= 100000000) {
      requirements.add(BoardRequirement()
        ..type = BoardRequirementType.signPlayer
        ..description = 'Fichar un delantero internacional (media >= 85)'
        ..targetValue = 1);
    }

    return requirements;
  }

  /// Formatea los requerimientos para mostrar en mensajes
  String _formatRequirements(List<BoardRequirement> requirements) {
    final buffer = StringBuffer();
    buffer.writeln('El presidente ha establecido estos requerimientos adicionales:');
    buffer.writeln('');
    
    for (var req in requirements) {
      final icon = req.completed ? '✅' : '⏳';
      buffer.writeln('$icon ${req.description}');
      if (!req.completed) {
        buffer.writeln('   Progreso: ${req.currentValue}/${req.targetValue}');
      }
    }
    
    return buffer.toString();
  }

  /// Realiza una reunión semanal con el presidente
  Future<WeeklyMeeting> conductWeeklyMeeting({
    required GameSave save,
    required Team userTeam,
    required int leaguePosition,
    ClubFinance? finance,
  }) async {
    const topics = MeetingTopic.values;
    final mainTopic = topics[_rng.nextInt(topics.length)];
    
    final meeting = _createMeetingContent(
      mainTopic: mainTopic,
      save: save,
      userTeam: userTeam,
      leaguePosition: leaguePosition,
      finance: finance,
    );

    // Aplicar cambio en la confianza
    save.boardAcceptance = (save.boardAcceptance + meeting.acceptanceChange).clamp(0, 100);

    // Añadir mensaje al buzón
    await MessageService(isar).add(
      title: 'Reunión semanal con el presidente',
      body: meeting.presidentMessage,
      type: MessageType.board,
    );

    // Si hay advertencia y la confianza está baja
    if (meeting.warning && save.boardAcceptance <= 40) {
      await MessageService(isar).add(
        title: '¡ADVERTENCIA!',
        body: 'El presidente está muy preocupado por la situación.',
        type: MessageType.board,
      );
    }

    return meeting;
  }

  /// Crea el contenido de la reunión según el tema principal
  WeeklyMeeting _createMeetingContent({
    required MeetingTopic mainTopic,
    required GameSave save,
    required Team userTeam,
    required int leaguePosition,
    ClubFinance? finance,
  }) {
    String message;
    int acceptanceChange = 0;
    final actionPoints = <String>[];
    bool warning = false;

    switch (mainTopic) {
      case MeetingTopic.results:
        final gap = leaguePosition - save.boardObjectiveMaxPosition;
        if (gap <= 0) {
          message = '¡Excelente! Vas $leaguePositionº y cumpliendo el objetivo. Sigue así.';
          acceptanceChange = 4;
          actionPoints.add('Mantener la misma intensidad');
        } else if (gap <= 3) {
          message = 'Vas $leaguePositionº, a un paso del objetivo. Necesitamos mejorar.';
          acceptanceChange = -2;
          actionPoints.add('Mejorar los resultados en casa');
          warning = true;
        } else {
          message = 'Estamos $leaguePositionº, muy por debajo de lo esperado. ¡Mejora YA!';
          acceptanceChange = -6;
          actionPoints.add('Revisar la táctica');
          actionPoints.add('Considerar cambios en la alineación');
          warning = true;
        }

      case MeetingTopic.finances:
        if (finance != null && finance.balance > 0) {
          message = 'Las finanzas son saludables. Buen trabajo gestionando el presupuesto.';
          acceptanceChange = 3;
          actionPoints.add('Mantener el control salarial');
        } else {
          message = 'Las cuentas preocupan. No podemos seguir gastando así.';
          acceptanceChange = -4;
          actionPoints.add('Reducir gastos');
          actionPoints.add('Considerar ventas de jugadores');
          warning = true;
        }

      case MeetingTopic.transfers:
        message = 'El mercado se acerca. ¿Tienes claros los objetivos para fichar?';
        acceptanceChange = 1;
        actionPoints.add('Hacer una lista de objetivos');
        actionPoints.add('Consultar con el secretario técnico');

      case MeetingTopic.youth:
        message = 'La cantera es el futuro del club. Debes dar chances a los jóvenes.';
        acceptanceChange = 2;
        actionPoints.add('Revisar la plantilla juvenil');
        actionPoints.add('Promover talentos');

      case MeetingTopic.tactics:
        message = 'Hablemos de la táctica. ¿Estás contento con el planteamiento?';
        acceptanceChange = 1;
        actionPoints.add('Analizar partidos anteriores');
        actionPoints.add('Probar variantes en entrenamientos');

      case MeetingTopic.morale:
        message = 'La moral del vestuario es crucial. Mantén a los jugadores motivados.';
        acceptanceChange = 1;
        actionPoints.add('Hablar con los capitánes');
        actionPoints.add('Gestionar los egos');
    }

    return WeeklyMeeting(
      mainTopic: mainTopic,
      presidentMessage: message,
      acceptanceChange: acceptanceChange,
      actionPoints: actionPoints,
      warning: warning,
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
    // Nivel 0 (sin secretario) → tratar como 1 (base).
    final secLevel = save.staffSecretaryLevel <= 1 ? 1 : save.staffSecretaryLevel;
    final double secretaryReduction = (secLevel - 1) * 0.03;
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

  // === ENCUESTAS A LA AFICIÓN ===

  /// Realiza una encuesta a la afición
  Future<FanSurvey> conductFanSurvey(GameSave save, List<Player> players) async {
    final survey = FanSurvey();
    
    // Calcular aprobación según confianza y resultados
    survey.approvalRating = ((save.boardAcceptance * 0.7 + _rng.nextInt(30)).clamp(0, 100)).toInt();
    
    // Elegir jugador favorito
    if (players.isNotEmpty) {
      final sorted = List<Player>.from(players)
        ..sort((a, b) => b.average.compareTo(a.average));
      survey.favoritePlayer = sorted.first.name;
      
      // Jugador más criticado (al azar, pero con media baja)
      final lowRated = players.where((p) => p.average < 65).toList();
      if (lowRated.isNotEmpty) {
        survey.mostCriticizedPlayer = lowRated[_rng.nextInt(lowRated.length)].name;
      } else {
        survey.mostCriticizedPlayer = 'Ninguno en específico';
      }
    } else {
      survey.favoritePlayer = 'Todo el equipo';
      survey.mostCriticizedPlayer = 'Ninguno';
    }

    // Feedback según aprobación
    survey.feedback = _generateFanFeedback(survey.approvalRating);
    survey.surveyDate = DateTime.now();

    // Guardar en la partida
    save.lastFanSurvey = survey;
    save.lastSurveyDate = DateTime.now();

    // Añadir mensaje con los resultados
    await MessageService(isar).add(
      title: 'Resultados de la encuesta a la afición',
      body: _formatSurveyResults(survey),
      type: MessageType.general,
    );

    return survey;
  }

  String _generateFanFeedback(int approval) {
    if (approval >= 80) {
      return 'La afición está muy contenta con tu trabajo. ¡Sigue así!';
    } else if (approval >= 60) {
      return 'La afición apoya tu proyecto, pero quiere ver más resultados.';
    } else if (approval >= 40) {
      return 'La afición está dividida. Hay dudas sobre tu planteamiento.';
    } else {
      return 'La afición está muy descontenta. Piden cambios inmediatos.';
    }
  }

  String _formatSurveyResults(FanSurvey survey) {
    final buffer = StringBuffer();
    buffer.writeln('📊 Resultados de la última encuesta:');
    buffer.writeln('');
    buffer.writeln('• Aprobación del entrenador: ${survey.approvalRating}%');
    buffer.writeln('• Jugador favorito: ${survey.favoritePlayer}');
    buffer.writeln('• Jugador más criticado: ${survey.mostCriticizedPlayer}');
    buffer.writeln('');
    buffer.writeln(survey.feedback);
    return buffer.toString();
  }

  // === RUMORES EN LA PRENSA ===

  /// Genera un rumor en la prensa
  Future<void> generatePressRumor(GameSave save, Team userTeam, [String? otherClub]) async {
    final rumorTypes = [
      'dismissal',
      'transfer',
      'president',
      'tactics',
      'form'
    ];
    
    final type = rumorTypes[_rng.nextInt(rumorTypes.length)];
    String title;
    String body;

    switch (type) {
      case 'dismissal':
        if (save.boardAcceptance <= 40) {
          title = '¡Alerta en el vestuario!';
          body = 'Los rumores sobre tu futuro crecen. El presidente podría tomar decisiones drásticas si no mejoran los resultados.';
        } else {
          title = 'Calma en el club';
          body = 'Fuentes cercanas aseguran que el presidente confía plenamente en ti.';
        }

      case 'transfer':
        final clubs = ['Real Madrid', 'Barcelona', 'Atlético', 'Bayern', 'Man City'];
        final club = otherClub ?? clubs[_rng.nextInt(clubs.length)];
        title = '¡Rumor de fichaje!';
        body = '$club estaría interesado en uno de tus jugadores estrellas. Habrá que estar atentos al mercado.';

      case 'president':
        title = 'Reunión clave';
        body = 'Se espera una reunión importante entre tú y el presidente en los próximos días.';

      case 'tactics':
        title = 'Cambio de sistema?';
        body = 'Los periodistas especulan con que podrías cambiar de táctica en el próximo partido.';

      case 'form':
        title = 'Racha preocupante';
        body = 'La afición empieza a preguntarse si el equipo puede salir de esta mala racha.';

      default:
        title = 'Noticias del club';
        body = 'Todo tranquilo en el vestuario de $userTeam.';
    }

    await MessageService(isar).add(
      title: '📰 $title',
      body: body,
      type: MessageType.press,
    );
  }

  /// Actualiza el progreso de los requerimientos de la directiva
  Future<void> updateRequirementsProgress(GameSave save, {
    int youthPromoted = 0,
    int cleanSheetsAdded = 0,
    bool signedPlayer = false,
  }) async {
    bool changed = false;

    for (var req in save.boardRequirements) {
      switch (req.type) {
        case BoardRequirementType.promoteYouth:
          if (youthPromoted > 0) {
            req.currentValue += youthPromoted;
            changed = true;
          }
          break;

        case BoardRequirementType.keepCleanSheets:
          if (cleanSheetsAdded > 0) {
            req.currentValue += cleanSheetsAdded;
            changed = true;
          }
          break;

        case BoardRequirementType.signPlayer:
          if (signedPlayer && !req.completed) {
            req.currentValue = 1;
            changed = true;
          }
          break;

        default:
          break;
      }

      // Marcar como completado si llega al objetivo
      if (req.currentValue >= req.targetValue && !req.completed) {
        req.completed = true;
        await MessageService(isar).add(
          title: '¡Requerimiento cumplido!',
          body: 'Has cumplido: ${req.description}',
          type: MessageType.board,
        );
        save.boardAcceptance = (save.boardAcceptance + 5).clamp(0, 100);
      }
    }

    if (changed) {
      await isar.writeTxn(() => isar.gameSaves.put(save));
    }
  }
}
