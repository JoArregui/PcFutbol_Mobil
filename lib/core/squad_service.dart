import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import '../models/game_save.dart';
import 'api_service.dart';
import 'database_service.dart';
import 'player_generator.dart';
import 'dart:math' as math;

/// Garantiza plantilla por equipo: API + relleno inventado progresivo.
/// Setea las condiciones de inicio respetando un mínimo del 70% de jugadores reales.
class SquadService {
  final Isar isar;
  final ApiService _api = ApiService();

  SquadService(this.isar);

  SquadService.fromDatabase(DatabaseService db) : isar = db.isar;

  static const minSquadSize = 20;
  static const preferredSquadSize = 24;
  
  /// Regla de Oro para la generación inicial: Máximo 30% de jugadores inventados.
  static const maxGeneratedRatio = 0.30; 

  Future<List<Player>> ensureSquad(int teamApiId, {bool tryApiFirst = true}) async {
    var players = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    final season = await _currentSeason();

    if (players.length < minSquadSize && tryApiFirst) {
      debugPrint('📥 Descargando plantilla API para equipo $teamApiId…');
      await _api.syncTeamSquad(teamApiId, DatabaseService.connected(isar), force: players.isEmpty);
      players = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    }

    // Contamos los reales profesionales activos, ya que los canteranos no forman 
    // parte del primer equipo visible en el SquadScreen de inicio.
    final realCount = players.where((p) => !p.isGenerated && !p.isYouth).length;
    final generatedCount = players.length - players.where((p) => !p.isGenerated).length;
    
    // El ratio se ajusta por temporada del juego para la CPU, limitado por el tope de inicio.
    final double seasonRatio = math.min(_generatedRatioForSeason(season), maxGeneratedRatio);
    final maxGeneratedBySeason = (preferredSquadSize * seasonRatio).floor();

    final desiredGenerated = _desiredGeneratedCount(
      realCount: realCount,
      currentGenerated: generatedCount,
      maxGeneratedBySeason: maxGeneratedBySeason,
    );

    final int lowerLimit = math.min(minSquadSize, preferredSquadSize);
    final int upperLimit = math.max(minSquadSize, preferredSquadSize);
    final desiredTotal = (realCount + desiredGenerated).clamp(lowerLimit, upperLimit);
    
    final needed = desiredTotal - players.length;

    if (needed > 0) {
      final generated = PlayerGenerator.generateSupplementalPlayers(
        teamApiId,
        needed,
        seasonNumber: season,
      );
      players = [...players, ...generated];
      await _replaceSquad(teamApiId, players);
    }

    final finalReal = players.where((p) => !p.isGenerated && !p.isYouth).length;
    final finalTotal = players.where((p) => !p.isYouth).length;
    final finalPct = finalTotal == 0 ? 0 : (finalReal * 100 / finalTotal);
    debugPrint('📊 Equipo $teamApiId real profesional local: $finalReal/$finalTotal (${finalPct.toStringAsFixed(1)}%)');

    return players;
  }

  int _desiredGeneratedCount({
    required int realCount,
    required int currentGenerated,
    required int maxGeneratedBySeason,
  }) {
    // Si la API no responde o hay escasez crítica de reales en la base de datos de origen:
    if (realCount < minSquadSize) {
      final maxAllowedGenerated = (preferredSquadSize * maxGeneratedRatio).floor();
      final neededForPlayable = math.min(minSquadSize - realCount, maxAllowedGenerated);
      
      final int minLimit = math.min(currentGenerated, maxAllowedGenerated);
      final int maxLimit = math.max(currentGenerated, maxAllowedGenerated);
      
      return neededForPlayable.clamp(minLimit, maxLimit);
    }

    return currentGenerated > maxGeneratedBySeason ? currentGenerated : maxGeneratedBySeason;
  }

  double _generatedRatioForSeason(int season) {
    if (season <= 1) return 0.15; // 85% real objetivo
    if (season == 2) return 0.22; // 78% real objetivo
    if (season == 3) return 0.28; // 72% real objetivo
    return maxGeneratedRatio;     // 0.30 -> Límite absoluto del 30% de inventados
  }

  Future<int> _currentSeason() async {
    final save = await isar.gameSaves.get(1);
    return save?.seasonNumber ?? 1;
  }

  Future<void> _replaceSquad(int teamApiId, List<Player> players) async {
    await isar.writeTxn(() async {
      final old = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
      for (final p in old) {
        await isar.players.delete(p.id);
      }
      await isar.players.putAll(players);
    });
  }

  Future<void> ensureAllTeams() async {
    final teams = await isar.teams.where().findAll();
    for (var i = 0; i < teams.length; i++) {
      await ensureSquad(teams[i].apiId, tryApiFirst: true);
      if (i < teams.length - 1) {
        await Future.delayed(const Duration(milliseconds: 400));
      }
    }
    debugPrint('✅ Plantillas iniciales revisadas para ${teams.length} equipos.');
  }
}