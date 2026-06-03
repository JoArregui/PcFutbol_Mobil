import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/team.dart';
import '../models/player_model.dart';
import 'database_service.dart';
import 'player_generator.dart';

class ApiService {
  final String apiKey = dotenv.env['FOOTBALL_API_KEY'] ?? '';
  final String baseUrl = 'https://v3.football.api-sports.io';
  final _rng = Random();

  Map<String, String> get _headers => {
        'x-apisports-key': apiKey,
        'Content-Type': 'application/json',
      };

  static const _seasonsToTry = ['2024', '2023', '2025'];

  Future<void> syncLeagueTeams(int leagueId, DatabaseService db) async {
    final existingTeams = await db.getAllTeams();
    if (existingTeams.isNotEmpty) {
      debugPrint('📦 ${existingTeams.length} equipos en local.');
      return;
    }

    if (apiKey.isEmpty) {
      throw Exception(
          'API Key no configurada en assets/.env (FOOTBALL_API_KEY)');
    }

    for (final season in _seasonsToTry) {
      if (await _fetchAndSaveTeams(leagueId, season, db)) return;
    }

    throw Exception('No se pudieron descargar equipos de la liga $leagueId');
  }

  Future<bool> _fetchAndSaveTeams(
      int leagueId, String season, DatabaseService db) async {
    debugPrint('📡 GET teams?league=$leagueId&season=$season');

    final response = await http.get(
      Uri.parse('$baseUrl/teams?league=$leagueId&season=$season'),
      headers: _headers,
    );

    if (response.statusCode != 200) {
      debugPrint('❌ teams HTTP ${response.statusCode}');
      return false;
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    if (_hasApiErrors(data)) return false;

    final teamsRaw = data['response'] as List?;
    if (teamsRaw == null || teamsRaw.isEmpty) return false;

    debugPrint('📦 ${teamsRaw.length} equipos (temporada $season).');

    for (var i = 0; i < teamsRaw.length; i++) {
      final newTeam = Team.fromJson(teamsRaw[i] as Map<String, dynamic>);
      await db.saveTeam(newTeam);
      await syncTeamSquad(newTeam.apiId, db);
      if (i < teamsRaw.length - 1) {
        await Future.delayed(const Duration(milliseconds: 450));
      }
    }

    return true;
  }

  Future<void> syncTeamSquad(int teamId, DatabaseService db,
      {bool force = false}) async {
    if (!force) {
      final existing = await db.getPlayersByTeam(teamId);
      if (existing.length >= 20) return;
    }

    if (apiKey.isEmpty) {
      await _fallbackGeneratedSquad(teamId, db);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/players/squads?team=$teamId'),
        headers: _headers,
      );

      if (response.statusCode != 200) {
        debugPrint('⚠️ squads team=$teamId → HTTP ${response.statusCode}');
        await _fallbackGeneratedSquad(teamId, db);
        return;
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      if (_hasApiErrors(data)) {
        await _fallbackGeneratedSquad(teamId, db);
        return;
      }

      final responseList = data['response'] as List?;
      if (responseList == null || responseList.isEmpty) {
        await _fallbackGeneratedSquad(teamId, db);
        return;
      }

      final playersRaw =
          (responseList.first as Map<String, dynamic>)['players'] as List?;
      if (playersRaw == null || playersRaw.isEmpty) {
        await _fallbackGeneratedSquad(teamId, db);
        return;
      }

      final players = <Player>[];
      for (final raw in playersRaw) {
        final p = raw as Map<String, dynamic>;
        final name = (p['name'] as String?)?.trim();
        if (name == null || name.isEmpty) continue;

        final age = _parseAge(p['age']);
        final pos = _translatePosition(p['position'] as String?);
        final stats = _statsForPosition(pos, age);
        final isYoungBet = age <= 19 && _rng.nextDouble() < 0.1;
        final personality = isYoungBet
            ? Personality.ambitious
            : Personality.values[_rng.nextInt(Personality.values.length)];

        final marketValue = _estimateValue(stats, age);
        final salary = PlayerGenerator.salaryFromValue(marketValue, age);
        final contractYears =
            PlayerGenerator.contractDuration(age, personality);
        final buyoutClause = PlayerGenerator.buyoutClause(
            marketValue, personality, contractYears);

        players.add(Player()
          ..name = name
          ..age = age
          ..position = pos
          ..teamApiId = teamId
          ..teamId = 'API'
          ..stats = stats
          ..marketValue = marketValue
          ..salary = salary
          ..buyoutClause = buyoutClause
          ..contractYearsRemaining = contractYears
          ..personality = personality
          ..nationality = 'ESP'
          ..isGenerated = false
          ..isUnicorn = isYoungBet
          ..potential = isYoungBet
              ? 88 + _rng.nextInt(8)
              : _ceilingFromStats(stats, age));
      }
      await db.replaceTeamSquad(teamId, players);
      debugPrint(
          '✅ Equipo $teamId: ${players.length} jugadores reales con contratos generados');
    } catch (e) {
      debugPrint('❌ squads team=$teamId: $e');
      await _fallbackGeneratedSquad(teamId, db);
    }
  }

  Future<void> _fallbackGeneratedSquad(int teamId, DatabaseService db) async {
    final squad = PlayerGenerator.generateFullSquad(teamId, seasonNumber: 1);
    await db.replaceTeamSquad(teamId, squad);
    debugPrint(
        '🎲 Plantilla inventada para $teamId (${squad.length} jugadores)');
  }

  int _parseAge(dynamic age) {
    if (age is int) return age.clamp(16, 42);
    if (age is String) return int.tryParse(age)?.clamp(16, 42) ?? 22;
    return 22;
  }

  List<int> _statsForPosition(String pos, int age) {
    var base = 70;
    if (age <= 20) base = 64 + _rng.nextInt(10);
    if (age >= 32) base = 72 + _rng.nextInt(8);
    int j() => (base + _rng.nextInt(9) - 4).clamp(45, 92);
    switch (pos) {
      case 'GK':
        return [j(), j() - 5, j() - 3, j() + 4, j() + 2];
      case 'DEF':
        return [j() - 2, j() - 8, j(), j() + 6, j() + 3];
      case 'FWD':
        return [j() + 4, j() + 7, j() - 1, j() - 6, j() + 2];
      default:
        return [j(), j() + 1, j() + 3, j(), j()];
    }
  }

  double _estimateValue(List<int> stats, int age) {
    final avg = stats.reduce((a, b) => a + b) / stats.length;
    final ageFactor = age <= 28
        ? 1.0 + (age - 20) * 0.04
        : 1.0 - (age - 28) * 0.07;
    return (avg * avg * 15000 * ageFactor.clamp(0.2, 1.6))
        .clamp(100000, 200000000);
  }

  int _ceilingFromStats(List<int> stats, int age) {
    final avg = stats.reduce((a, b) => a + b) / stats.length;
    return (avg + 10 + (24 - age).clamp(0, 8)).round().clamp(75, 94);
  }

  bool _hasApiErrors(Map<String, dynamic> data) {
    final errors = data['errors'];
    if (errors is Map && errors.isNotEmpty) {
      debugPrint('❌ API errors: $errors');
      return true;
    }
    return false;
  }

  String _translatePosition(String? apiPos) {
    switch (apiPos?.toLowerCase() ?? '') {
      case 'goalkeeper':
        return 'GK';
      case 'defender':
        return 'DEF';
      case 'midfielder':
        return 'MID';
      case 'attacker':
      case 'forward':
        return 'FWD';
      default:
        return 'MID';
    }
  }
}