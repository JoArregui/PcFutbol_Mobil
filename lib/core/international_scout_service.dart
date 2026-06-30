import 'dart:math';
import 'package:isar/isar.dart';
import '../models/finance_model.dart';
import '../models/game_message.dart';
import '../models/game_save.dart';
import '../models/player_model.dart';
import 'message_service.dart';
import 'press_service.dart';

class InternationalScoutService {
  final Isar isar;
  final _rng = Random();

  static const _nations = ['BRA', 'ARG', 'FRA', 'POR', 'NED', 'GER', 'ITA', 'ENG', 'URU', 'COL'];

  InternationalScoutService(this.isar);

  Future<String> runScoutMission(int userTeamApiId, {double cost = 350000}) async {
    final finance = await isar.clubFinances.get(1);
    final save = await isar.gameSaves.get(1);
    if (finance == null || save == null) return 'Sin datos de partida.';
    if (finance.transferBudget < cost) return 'Presupuesto de scouting insuficiente.';

    final foreign = await isar.players
        .filter()
        .teamApiIdGreaterThan(0)
        .isYouthEqualTo(false)
        .findAll();
    final pool = foreign.where((p) => p.teamApiId != userTeamApiId && p.onLoanFromTeamApiId == 0).toList();
    if (pool.isEmpty) return 'No hay jugadores disponibles en el informe.';

    pool.shuffle(_rng);
    final target = pool.first;
    target.nationality = _nations[_rng.nextInt(_nations.length)];

    finance.transferBudget -= cost;
    save.internationalScoutsUsed++;

    await isar.writeTxn(() async {
      await isar.clubFinances.put(finance);
      await isar.gameSaves.put(save);
      await isar.players.put(target);
    });

    await MessageService(isar).add(
      title: 'Informe del ojeador',
      body:
          'Detectado ${target.name} (${target.nationality}) — media ${target.average.toStringAsFixed(0)}. Negocia en el mercado.',
      type: MessageType.transfer,
    );
    await PressService(isar).publishTransferNews(
      'Rumor internacional',
      'Tu club sigue de cerca a ${target.name}.',
    );

    return 'Informe listo: ${target.name} (${target.nationality}).';
  }
}
