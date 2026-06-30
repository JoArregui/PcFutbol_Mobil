import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/player_model.dart';
import '../models/finance_model.dart';
import '../models/team.dart';
import '../models/game_save.dart';
import '../models/league_fixture.dart';
import '../models/league_standing.dart';
import '../models/user_lineup.dart';
import '../models/game_message.dart';
import '../models/cup_fixture.dart';
import '../models/transfer_offer.dart';
import '../models/editor_config.dart';
import '../models/staff.dart'; // 
import 'finance_service.dart';
import 'api_service.dart';
import 'editor_service.dart';
import 'squad_service.dart';

/// =============================================================================
/// FLUJO DE DATOS OFICIAL (IMPORTANTE):
/// -----------------------------------------------------------------------------
/// 1. PRIMERA VEZ / BD VACÍA:
///    - Consultar API Sports
///    - Guardar TODO en BD local (equipos + jugadores)
///
/// 2. PARTIDAS POSTERIORES (BD CON DATOS):
///    - NUNCA volvemos a consultar la API
///    - TODO se obtiene EXCLUSIVAMENTE de la BD local
///    - Solo se usa la API si el usuario empieza una partida con un equipo que
///      NO está en la BD (extremadamente raro, solo si se añaden equipos nuevos)
/// =============================================================================
class DatabaseService {
  late Isar isar;

  /// Usar cuando Isar ya está abierto (p. ej. desde SquadService).
  DatabaseService.connected(this.isar);

  DatabaseService();

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    
    // Abrimos Isar solo si no está ya abierto
    if (Isar.instanceNames.isEmpty) {
      isar = await Isar.open(
        [
          PlayerSchema,
          ClubFinanceSchema,
          TeamSchema,
          GameSaveSchema,
          LeagueFixtureSchema,
          LeagueStandingSchema,
          UserLineupSchema,
          GameMessageSchema,
          CupFixtureSchema,
          TransferOfferSchema,
          EditorConfigSchema,
          StaffSchema,
        ],
        directory: dir.path,
        inspector: true,
      );
    } else {
      isar = Isar.getInstance()!;
    }

    // --- COMENTADO O ELIMINADO: No borres la base de datos en cada inicio ---
    // await isar.writeTxn(() => isar.clear()); 

    // 2. Sincronización Inteligente (SOLO SI BD VACÍA)
    final teamCount = await isar.teams.count();
    debugPrint("📊 Equipos en base de datos: $teamCount");

    final apiService = ApiService();
    final squadService = SquadService(isar);

    // 🔒 SÓLO SI BD COMPLETAMENTE VACÍA: consultar API
    if (teamCount == 0) {
      debugPrint("🚀 BD VACÍA - Primera sincronización desde API...");
      try {
        await apiService.syncLeagueTeams(140, this);
        debugPrint("✅ Datos iniciales guardados en BD.");
      } catch (e) {
        debugPrint("❌ Error en sincronización inicial: $e");
      }
    } else {
      // 🔒 BD CON DATOS: NO USAR API - TODO viene de la BD local
      debugPrint("✅ BD ya inicializada - USANDO SOLO DATOS LOCALES.");
    }

    final playerCount = await isar.players.count();
    final save = await isar.gameSaves.get(1);

    // Solo completamos plantillas si NO hay partida activa (primera instalación).
    // Esto evita que en cada arranque se sobreescriban los jugadores reales
    // con jugadores generados cuando la API devuelve menos jugadores de los esperados.
    if (playerCount < teamCount * 15 && teamCount > 0 && save == null) {
      debugPrint("👥 Faltan plantillas ($playerCount jugadores). Completando…");
      try {
        await squadService.ensureAllTeams();
      } catch (e) {
        debugPrint("❌ Error completando plantillas: $e");
      }
    }

    if (kDebugMode) {
      if (save != null) {
        final players = await isar.players
            .filter()
            .teamApiIdEqualTo(save.userTeamApiId)
            .findAll();
        for (final p in players) {
          debugPrint(
            '👤 ID:${p.id} | ${p.name} | ${p.position} | teamApiId:${p.teamApiId} | generado:${p.isGenerated} | cantera:${p.isYouth}',
          );
        }
      }
      debugPrint('🔍 Isar Inspector: http://localhost:8080');
    }

    final currentTeams = await getAllTeams();
    final financeService = FinanceService(isar);
    
    // SOLUCIÓN A LOS PARÁMETROS REQUERIDOS:
    // Si la BD contiene equipos, inicializamos las finanzas con el primero.
    // Si está completamente vacía (por ejemplo, en el primer arranque), 
    // creamos un Team ficticio con los argumentos requeridos para que no falle la compilación.
    if (currentTeams.isNotEmpty) {
      await financeService.initFinances(currentTeams.first);
    } else {
      await financeService.initFinances(
        Team(
          apiId: 0,
          name: "Club por Defecto",
          city: "Ciudad",
          stadium: "Estadio Municipal",
          stadiumCapacity: 10000,
          logoUrl: "",
          budget: 5000000,
        ),
      );
    }

    final editor = EditorService(isar);
    await editor.getConfig();
  }

  // Resto de métodos...
  Future<void> saveTeam(Team team) async {
    await isar.writeTxn(() => isar.teams.put(team));
  }

  Future<void> savePlayers(List<Player> players) async {
    await isar.writeTxn(() => isar.players.putAll(players));
  }

  /// Sustituye la plantilla de un equipo (p. ej. tras mezclar API + generados).
  Future<void> replaceTeamSquad(int teamApiId, List<Player> players) async {
    await isar.writeTxn(() async {
      final old = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
      for (final p in old) {
        await isar.players.delete(p.id);
      }
      await isar.players.putAll(players);
    });
  }

  Future<List<Team>> getAllTeams() async {
    return await isar.teams.where().findAll();
  }

  Future<List<Player>> getAllPlayers() async {
    return await isar.players.where().findAll();
  }

  Future<List<LeagueFixture>> getAllFixtures() async {
    return await isar.leagueFixtures.where().findAll();
  }

  Future<List<Player>> getPlayersByTeam(int apiId, {bool professionalsOnly = false}) async {
    var q = isar.players.filter().teamApiIdEqualTo(apiId);
    if (professionalsOnly) {
      return q.isYouthEqualTo(false).findAll();
    }
    return q.findAll();
  }

  Future<bool> expandStadium({int extraSeats = 5000, double cost = 2500000}) async {
    final finance = await isar.clubFinances.get(1);
    if (finance == null || finance.balance < cost) return false;

    finance.balance -= cost;
    finance.stadiumExtraCapacity += extraSeats;

    await isar.writeTxn(() => isar.clubFinances.put(finance));
    return true;
  }

  Future<int> effectiveStadiumCapacity(Team team) async {
    final finance = await isar.clubFinances.get(1);
    return team.stadiumCapacity + (finance?.stadiumExtraCapacity ?? 0);
  }

  Future<void> close() async {
    await isar.close();
  }
}