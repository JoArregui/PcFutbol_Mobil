import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/team.dart';
import '../models/player_model.dart';
import 'database_service.dart';

class ApiService {
  final String apiKey = dotenv.env['FOOTBALL_API_KEY'] ?? ""; 
  final String baseUrl = "https://v3.football.api-sports.io";

  // Headers reutilizables
  Map<String, String> get _headers => {
    'x-apisports-key': apiKey,
    'Content-Type': 'application/json',
  };

  /// Sincroniza equipos y automáticamente dispara la descarga de sus plantillas
  Future<void> syncLeagueTeams(int leagueId, DatabaseService db) async {
    if (apiKey.isEmpty) throw Exception("API Key no configurada");

    final response = await http.get(
      Uri.parse("$baseUrl/teams?league=$leagueId&season=2024"),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List teamsRaw = data['response'];

      for (var teamData in teamsRaw) {
        final newTeam = Team.fromJson(teamData);
        await db.saveTeam(newTeam);
        
        // --- DESCARGA DE JUGADORES REALES ---
        // Llamamos a la sincronización de plantilla para este equipo específico
        await syncTeamSquad(newTeam.apiId, db);
      }
    } else {
      throw Exception("Error al conectar con la API: ${response.statusCode}");
    }
  }

  /// Descarga la plantilla oficial (squad) de un equipo
  Future<void> syncTeamSquad(int teamId, DatabaseService db) async {
    final response = await http.get(
      Uri.parse("$baseUrl/players/squads?team=$teamId"),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['response'] == null || data['response'].isEmpty) return;

      final List playersRaw = data['response'][0]['players'];
      
      List<Player> players = playersRaw.map((p) {
        return Player()
          ..name = p['name']
          ..age = p['age'] ?? 20
          ..position = _translatePosition(p['position'])
          ..teamApiId = teamId // VINCULACIÓN POR ID
          ..teamId = "" // Ya no necesitamos el String teamId
          ..marketValue = 5000000.0 // Valor base (la API de squads no da precio)
          ..salary = 100000.0
          ..stats = [75, 70, 72, 65, 80] // Stats base equilibradas
          ..personality = Personality.professional;
      }).toList();

      await db.savePlayers(players);
      print("✅ Sincronizados ${players.length} jugadores para el equipo $teamId");
    }
  }

  /// Mapea las posiciones de la API a nuestro formato (GK, DEF, MID, FWD)
  String _translatePosition(String apiPos) {
    switch (apiPos.toLowerCase()) {
      case 'goalkeeper': return 'GK';
      case 'defender': return 'DEF';
      case 'midfielder': return 'MID';
      case 'forward': return 'FWD';
      default: return 'MID';
    }
  }
}