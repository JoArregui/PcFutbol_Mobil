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
import 'player_generator.dart';

/// Pagination defaults
const int _kDefaultPageSize = 50;
const int _kMaxPageSize = 200;

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
    
    // 0. Precargar NOMBRES REALES del pool de players.json ANTES de cualquier generación
    debugPrint('📦 Precargando nombres reales del pool assets/data/players.json…');
    try {
      await PlayerGenerator.preloadRealNames();
      debugPrint('✅ Pool de nombres reales cargado.');
    } catch (e) {
      debugPrint('⚠️  No se pudo cargar pool de nombres reales: $e');
    }

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
      } finally {
        apiService.dispose();
      }
    } else {
      // 🔒 BD CON DATOS: NO USAR API - TODO viene de la BD local
      debugPrint("✅ BD ya inicializada - USANDO SOLO DATOS LOCALES.");
      apiService.dispose();
    }

    final playerCount = await isar.players.count();
    final save = await isar.gameSaves.get(1);

    // Siempre validamos plantillas si NO hay partida activa (setup inicial).
    // La regla 75/25 y mínimos posicionales DEBEN cumplirse estrictamente,
    // independientemente de cuántos jugadores devuelva la API.
    if (teamCount > 0 && save == null) {
      debugPrint("👥 Validando plantillas iniciales ($playerCount jugadores en BD)…");
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
      await isar.players.filter().teamApiIdEqualTo(teamApiId).deleteAll();
      if (players.isNotEmpty) {
        await isar.players.putAll(players);
      }
    });
  }

  Future<List<Team>> getAllTeams({int offset = 0, int limit = _kDefaultPageSize}) async {
    final l = limit.clamp(1, _kMaxPageSize);
    final o = offset < 0 ? 0 : offset;
    return await isar.teams.where().offset(o).limit(l).findAll();
  }

  Future<List<Player>> getAllPlayers({int offset = 0, int limit = _kDefaultPageSize}) async {
    final l = limit.clamp(1, _kMaxPageSize);
    final o = offset < 0 ? 0 : offset;
    return await isar.players.where().offset(o).limit(l).findAll();
  }

  Future<List<LeagueFixture>> getAllFixtures({int offset = 0, int limit = _kDefaultPageSize}) async {
    final l = limit.clamp(1, _kMaxPageSize);
    final o = offset < 0 ? 0 : offset;
    return await isar.leagueFixtures.where().offset(o).limit(l).findAll();
  }

  /// Count total teams (for pagination UI)
  Future<int> countTeams() async => await isar.teams.count();

  /// Count total players (for pagination UI)
  Future<int> countPlayers() async => await isar.players.count();

  Future<List<Player>> getPlayersByTeam(int apiId, {bool professionalsOnly = false, int offset = 0, int limit = _kDefaultPageSize}) async {
    final l = limit.clamp(1, _kMaxPageSize);
    final o = offset < 0 ? 0 : offset;
    var q = isar.players.filter().teamApiIdEqualTo(apiId);
    if (professionalsOnly) {
      return q.isYouthEqualTo(false).offset(o).limit(l).findAll();
    }
    return q.offset(o).limit(l).findAll();
  }

  /// Count players by team (for pagination UI)
  Future<int> countPlayersByTeam(int apiId, {bool professionalsOnly = false}) async {
    var q = isar.players.filter().teamApiIdEqualTo(apiId);
    if (professionalsOnly) {
      return q.isYouthEqualTo(false).count();
    }
    return q.count();
  }

  Future<bool> expandStadium({int extraSeats = 5000, double cost = 2500000}) async {
    return await isar.writeTxn(() async {
      final finance = await isar.clubFinances.get(1);
      if (finance == null || finance.balance < cost) return false;

      finance.balance -= cost;
      finance.stadiumExtraCapacity += extraSeats;

      await isar.clubFinances.put(finance);
      return true;
    });
  }

  Future<int> effectiveStadiumCapacity(Team team) async {
    final finance = await isar.clubFinances.get(1);
    return team.stadiumCapacity + (finance?.stadiumExtraCapacity ?? 0);
  }

  Future<void> close() async {
    await isar.close();
  }
}