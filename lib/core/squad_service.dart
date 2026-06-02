import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import '../models/game_save.dart';
import 'api_service.dart';
import 'database_service.dart';
import 'player_generator.dart';

/// Garantiza plantilla por equipo: API + relleno inventado progresivo.
class SquadService {
  final Isar isar;
  final ApiService _api = ApiService();

  SquadService(this.isar);

  SquadService.fromDatabase(DatabaseService db) : isar = db.isar;

  static const minSquadSize = 20;
  static const preferredSquadSize = 24;

  Future<List<Player>> ensureSquad(int teamApiId, {bool tryApiFirst = true}) async {
    var players = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    final season = await _currentSeason();

    if (players.length < minSquadSize && tryApiFirst) {
      debugPrint('📥 Descargando plantilla API para equipo $teamApiId…');
      await _api.syncTeamSquad(teamApiId, DatabaseService.connected(isar), force: players.isEmpty);
      players = await isar.players.filter().teamApiIdEqualTo(teamApiId).findAll();
    }

    final realCount = players.where((p) => !p.isGenerated).length;
    final generatedCount = players.length - realCount;
    final maxGeneratedBySeason = (preferredSquadSize * _generatedRatioForSeason(season)).floor();

    final desiredGenerated = _desiredGeneratedCount(
      realCount: realCount,
      currentGenerated: generatedCount,
      maxGeneratedBySeason: maxGeneratedBySeason,
    );

    final desiredTotal = (realCount + desiredGenerated).clamp(minSquadSize, preferredSquadSize);
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

    final finalReal = players.where((p) => !p.isGenerated).length;
    final finalPct = players.isEmpty ? 0 : (finalReal * 100 / players.length);
    debugPrint('📊 Equipo $teamApiId real/local: $finalReal/${players.length} (${finalPct.toStringAsFixed(1)}%)');

    return players;
  }

  int _desiredGeneratedCount({
    required int realCount,
    required int currentGenerated,
    required int maxGeneratedBySeason,
  }) {
    // Si hay pocos reales, priorizamos jugabilidad (mínimo 20), aunque baje del 85%.
    if (realCount < minSquadSize) {
      final neededForPlayable = minSquadSize - realCount;
      return neededForPlayable.clamp(currentGenerated, preferredSquadSize);
    }

    // Objetivo de realismo: no superar el porcentaje inventado por temporada.
    return currentGenerated > maxGeneratedBySeason ? currentGenerated : maxGeneratedBySeason;
  }

  double _generatedRatioForSeason(int season) {
    if (season <= 1) return 0.15; // 85% real mínimo objetivo
    if (season == 2) return 0.22;
    if (season == 3) return 0.30;
    if (season == 4) return 0.38;
    return 0.45; // transición hacia futuro inventado
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
    debugPrint('✅ Plantillas revisadas para ${teams.length} equipos.');
  }
}
