import 'package:isar/isar.dart';

part 'team.g.dart';

@collection
class Team {
  Id id = Isar.autoIncrement; // Isar necesita un entero
  
  @Index(unique: true)
  final int apiId; // El ID que viene de la API (ej: 541 para el Real Madrid)
  
  final String name;
  final String city;
  final String stadium;
  final String logoUrl; // Usaremos la URL directa de la API
  final int budget;

  Team({
    required this.apiId,
    required this.name,
    required this.city,
    required this.stadium,
    required this.logoUrl,
    required this.budget,
  });

  // Convertir JSON de la API a nuestro modelo
  factory Team.fromJson(Map<String, dynamic> json) {
    final venue = json['team']['venue'];
    return Team(
      apiId: json['team']['id'],
      name: json['team']['name'] ?? "Equipo Desconocido",
     city: (venue != null) ? (venue['city'] ?? "Ciudad Desconocida") : "Ciudad Desconocida",
      stadium: (venue != null) ? (venue['name'] ?? "Estadio Genérico") : "Estadio Genérico",
      logoUrl: json['team']['logo'] ?? "",
      budget: 50000000, // Presupuesto base inicial
    );
  }
}