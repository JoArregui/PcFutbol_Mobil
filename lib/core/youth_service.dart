import 'dart:math';
import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/team.dart';

class YouthService {
  final Isar isar;

  YouthService(this.isar);

  /// Recupera los futbolistas de la cantera pertenecientes a un equipo específico
  Future<List<Player>> getYouthSquad(int teamApiId) async {
    return await isar.players
        .filter()
        .teamApiIdEqualTo(teamApiId)
        .isYouthEqualTo(true)
        .findAll();
  }

  /// Genera y busca futbolistas para la cantera del club o del mercado general
  Future<void> scoutYouth({required int teamApiId, required int count}) async {
    final Random random = Random();
    final List<Player> newYouthPlayers = [];

    final List<String> firstNames = ['Carlos', 'Javier', 'Luis', 'Miguel', 'Alejandro', 'David', 'Jorge', 'Sergio', 'Lucas', 'Mateo'];
    final List<String> lastNames = ['García', 'Rodríguez', 'González', 'Fernández', 'López', 'Martínez', 'Sánchez', 'Pérez', 'Gómez', 'Martín'];
    final List<String> positions = ['POR', 'DEF', 'MED', 'DEL'];

    for (int i = 0; i < count; i++) {
      final String generatedName = '${firstNames[random.nextInt(firstNames.length)]} ${lastNames[random.nextInt(lastNames.length)]}';
      final String position = positions[random.nextInt(positions.length)];
      
      // Atributos base de un juvenil de cantera
      final int baseStat = 45 + random.nextInt(20); // Entre 45 y 65
      final List<int> generatedStats = List.generate(5, (_) => baseStat + random.nextInt(10));
      
      final double marketValue = (baseStat * 15000).toDouble();
      final double salary = (baseStat * 800).toDouble();

      final Player youth = Player()
        ..name = generatedName
        ..teamId = teamApiId.toString()
        ..teamApiId = teamApiId
        ..age = 16 + random.nextInt(4) // Entre 16 y 19 años
        ..position = position
        ..stats = generatedStats
        ..marketValue = marketValue
        ..salary = salary
        ..personality = Personality.values[random.nextInt(Personality.values.length)]
        ..injuredDays = 0
        ..suspendedMatches = 0
        ..isYouth = true
        ..contractYearsRemaining = 3
        ..nationality = 'ESP'
        ..onLoanFromTeamApiId = 0
        ..onLoanUntilMatchday = 0
        ..loanedOutToTeamApiId = 0
        ..loanedOutUntilMatchday = 0
        ..isGenerated = true
        ..isUnicorn = random.nextDouble() < 0.05 // 5% de probabilidad de ser una joya oculta
        ..potential = 75 + random.nextInt(20); // Techo de atributos entre 75 y 95

      // CRUCIAL: Fijar la cláusula de rescisión para evitar el LateInitializationError
      // Normalmente se calcula multiplicando el valor de mercado por un factor de protección (ej: 2.5x o 3x)
      youth.buyoutClause = marketValue * 3.0;

      newYouthPlayers.add(youth);
    }

    // Escritura en bloque dentro de la transacción de Isar
    await isar.writeTxn(() async {
      await isar.players.putAll(newYouthPlayers);
    });
  }

  /// Promociona un jugador de la cantera al primer equipo profesional
  Future<String> promoteToFirstTeam(Player player) async {
    if (!player.isYouth) return 'Este jugador ya forma parte del primer equipo.';

    player.isYouth = false;
    // Al promocionar, actualizamos su cláusula al estatus profesional de manera blindada
    player.buyoutClause = player.marketValue * 4.0;

    await isar.writeTxn(() async {
      await isar.players.put(player);
    });

    return '¡${player.name} ha sido promocionado exitosamente al primer equipo profesional!';
  }
}