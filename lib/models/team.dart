import 'package:isar/isar.dart';

part 'team.g.dart';

@collection
class Team {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  final int apiId; 
  
  final String name;
  final String city;
  final String stadium; // Este es el nombre del estadio
  final int stadiumCapacity; // NUEVO: Para gestionar ingresos y ampliaciones
  final String logoUrl;
  final int budget;

  Team({
    required this.apiId,
    required this.name,
    required this.city,
    required this.stadium,
    required this.stadiumCapacity,
    required this.logoUrl,
    required this.budget,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    final venue = json['venue']; // A veces viene en la raíz o dentro de 'team'
    
    return Team(
      apiId: json['team']['id'],
      name: json['team']['name'] ?? "Equipo Desconocido",
      city: venue != null ? (venue['city'] ?? "Ciudad Desconocida") : "Ciudad Desconocida",
      stadium: venue != null ? (venue['name'] ?? "Estadio Genérico") : "Estadio Genérico",
      // Capturamos la capacidad de la API, si no existe ponemos 15.000 por defecto
      stadiumCapacity: venue != null ? (venue['capacity'] ?? 15000) : 15000,
      logoUrl: json['team']['logo'] ?? "",
      budget: 50000000,
    );
  }
}