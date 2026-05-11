import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/player_model.dart';
import '../models/finance_model.dart';
import '../models/team.dart';
import 'finance_service.dart';
import 'api_service.dart';

class DatabaseService {
  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    
    isar = await Isar.open(
      [PlayerSchema, ClubFinanceSchema, TeamSchema],
      directory: dir.path,
    );

    // 1. LIMPIEZA TOTAL (Ejecutar una vez para purgar los 15.000 antiguos)
    // Tras la primera ejecución con éxito, puedes comentar esta línea.
    await isar.writeTxn(() => isar.clear()); 

    // 2. Sincronización Total (Equipos + Plantillas Reales)
    if (await isar.teams.count() == 0) {
      final apiService = ApiService();
    await apiService.syncLeagueTeams(140, this);
    }
    
    final financeService = FinanceService(isar);
    await financeService.initFinances();
  }

  Future<void> _syncEverythingFromAPI() async {
    try {
      final apiService = ApiService();
      // Liga 140 = LaLiga EA Sports
      await apiService.syncLeagueTeams(140, this); 
    } catch (e) {
      print("❌ Error en sincronización: $e");
    }
  }

  Future<void> saveTeam(Team team) async {
    await isar.writeTxn(() => isar.teams.put(team));
  }

  Future<void> savePlayers(List<Player> players) async {
    await isar.writeTxn(() => isar.players.putAll(players));
  }

  Future<List<Team>> getAllTeams() async {
    return await isar.teams.where().findAll();
  }

  Future<List<Player>> getPlayersByTeam(int apiId) async {
    return await isar.players.filter().teamApiIdEqualTo(apiId).findAll();
  }

  Future<void> close() async {
    await isar.close();
  }
}