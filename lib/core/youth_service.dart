import 'dart:math';
import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/game_message.dart';
import 'message_service.dart';

/// Cantera juvenil al estilo PC Fútbol 7.
class YouthService {
  final Isar isar;
  final _rng = Random();

  static const _firstNames = [
    'Iván', 'Sergio', 'Marcos', 'Álex', 'Pablo', 'Diego', 'Raúl', 'Hugo',
    'Adrián', 'Rubén', 'Jorge', 'Mario', 'Óscar', 'Víctor', 'Andrés',
  ];
  static const _lastNames = [
    'García', 'López', 'Martínez', 'Sánchez', 'Fernández', 'Ruiz', 'Torres',
    'Díaz', 'Moreno', 'Jiménez', 'Navarro', 'Romero', 'Vega', 'Castro',
  ];

  YouthService(this.isar);

  Future<List<Player>> getYouthSquad(int userTeamApiId) async {
    return await isar.players
        .filter()
        .teamApiIdEqualTo(userTeamApiId)
        .isYouthEqualTo(true)
        .findAll();
  }

  Future<int> youthCount(int userTeamApiId) =>
      getYouthSquad(userTeamApiId).then((l) => l.length);

  /// Genera hasta 3 promesas si la cantera tiene menos de 5.
  Future<int> scoutYouth(int userTeamApiId) async {
    final current = await getYouthSquad(userTeamApiId);
    if (current.length >= 8) return 0;

    final toCreate = (3).clamp(0, 8 - current.length);
    final players = <Player>[];

    for (int i = 0; i < toCreate; i++) {
      final pos = ['GK', 'DEF', 'MID', 'FWD'][_rng.nextInt(4)];
      final base = 52 + _rng.nextInt(18);
      players.add(Player()
        ..name = '${_firstNames[_rng.nextInt(_firstNames.length)]} '
            '${_lastNames[_rng.nextInt(_lastNames.length)]}'
        ..teamApiId = userTeamApiId
        ..teamId = 'YOUTH'
        ..age = 16 + _rng.nextInt(3)
        ..position = pos
        ..stats = List.generate(5, (_) => base + _rng.nextInt(12))
        ..marketValue = 150000 + _rng.nextDouble() * 800000
        ..salary = 50000 + _rng.nextDouble() * 80000
        ..personality = Personality.values[_rng.nextInt(Personality.values.length)]
        ..isYouth = true);
    }

    await isar.writeTxn(() => isar.players.putAll(players));

    if (toCreate > 0) {
      await MessageService(isar).add(
        title: 'Cantera',
        body:
            'El ojeador presenta $toCreate nueva(s) promesa(s) del filial. Revísalas en Cuidad deportiva.',
        type: MessageType.general,
      );
    }
    return toCreate;
  }

  Future<String> promoteToFirstTeam(Player youth, int userTeamApiId) async {
    if (!youth.isYouth) return 'Este jugador ya está en plantilla profesional.';
    final pros = await isar.players
        .filter()
        .teamApiIdEqualTo(userTeamApiId)
        .isYouthEqualTo(false)
        .findAll();
    if (pros.length >= 30) {
      return 'Plantilla completa (máx. 30 profesionales).';
    }

    youth.isYouth = false;
    youth.teamId = 'USER';
    await isar.writeTxn(() => isar.players.put(youth));
    return '¡${youth.name} promocionado al primer equipo!';
  }
}
