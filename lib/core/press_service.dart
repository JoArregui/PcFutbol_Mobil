import 'dart:math';
import 'package:isar/isar.dart';
import '../models/team.dart';
import '../models/game_message.dart';
import 'message_service.dart';

class PressService {
  final Isar isar;
  final _rng = Random();

  static const _outlets = ['MARCA', 'AS', 'SPORT', 'Mundo Deportivo', 'Estadio Deportivo'];

  PressService(this.isar);

  Future<void> publishMatchReaction({
    required Team userTeam,
    required int userGoals,
    required int opponentGoals,
    required String competition,
  }) async {
    final outlet = _outlets[_rng.nextInt(_outlets.length)];
    final comp = competition == 'copa' ? 'Copa' : 'Liga';

    String headline;
    if (userGoals > opponentGoals) {
      headline = '$outlet: «${userTeam.name} impone su ley en $comp»';
    } else if (userGoals == opponentGoals) {
      headline = '$outlet: «Tablas en $comp — ${userTeam.name} no pasa»';
    } else {
      headline = '$outlet: «Crisis en ${userTeam.name} tras tropiezo en $comp»';
    }

    await MessageService(isar).add(
      title: headline,
      body: _randomQuote(userGoals, opponentGoals),
      type: MessageType.press,
    );
  }

  Future<void> publishTransferNews(String title, String body) async {
    await MessageService(isar).add(
      title: '${_outlets[_rng.nextInt(_outlets.length)]}: $title',
      body: body,
      type: MessageType.press,
    );
  }

  String _randomQuote(int gf, int ga) {
    final quotes = [
      'El entrenador evitó polemizar en rueda de prensa.',
      'Los aficionados exigen más intensidad la próxima jornada.',
      'El vestuario se muestra unido pese al resultado.',
      'La directiva confía en la continuidad del proyecto.',
    ];
    if (gf < ga) {
      quotes.add('Se habla ya de posibles cambios en el once.');
    }
    return quotes[_rng.nextInt(quotes.length)];
  }
}
