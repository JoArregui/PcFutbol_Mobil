import 'dart:math';
import 'package:isar/isar.dart';
import '../models/game_save.dart';
import '../models/game_message.dart';
import '../models/team.dart';
import 'message_service.dart';

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

  Future<void> evaluateSeasonEnd(GameSave save, int finalPosition) async {
    final ok = finalPosition <= save.boardObjectiveMaxPosition;
    await MessageService(isar).add(
      title: ok ? 'Objetivo cumplido' : 'Objetivo incumplido',
      body: ok
          ? 'El presidente renueva la confianza. Has cumplido: ${save.boardObjectiveLabel}.'
          : 'El presidente está furioso. Has acabado $finalPositionº y se pedía ${save.boardObjectiveLabel}.',
      type: MessageType.board,
    );

    if (!ok && _rng.nextDouble() < 0.35) {
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
