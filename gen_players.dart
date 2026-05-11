import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() {
  final random = Random();
  final List<String> positions = ['POR', 'LD', 'LI', 'DFC', 'MC', 'MCO', 'ED', 'EI', 'DC'];
  final List<String> names = ['Oliver', 'Julian', 'Marcos', 'Adrian', 'Lucas', 'Enzo', 'paco', 'Gavi', 'Lamine', 'Leo', 'Cristiano', 'Kylian'];
  final List<String> surnames = ['Garcia', 'Rodriguez', 'Martinez', 'Hernandez', 'Lopez', 'Gonzalez', 'Perez', 'Sanchez', 'Pastore', 'Arrigui'];
  final List<String> personalities = ['ambitious', 'loyal', 'greedy', 'professional'];

  List<Map<String, dynamic>> players = [];

  print("Generando 15,000 jugadores...");

  for (int i = 0; i < 15000; i++) {
    final name = "${names[random.nextInt(names.length)]} ${surnames[random.nextInt(surnames.length)]}";
    
    players.add({
      "name": name,
      "teamId": "TEAM_${random.nextInt(100)}", // Repartidos en 100 equipos
      "age": 16 + random.nextInt(22),
      "position": positions[random.nextInt(positions.length)],
      "stats": List.generate(5, (_) => 40 + random.nextInt(55)),
      "marketValue": (500000 + random.nextInt(100000000)).toDouble(),
      "salary": (100000 + random.nextInt(5000000)).toDouble(),
      "personality": personalities[random.nextInt(personalities.length)]
    });
  }

  final file = File('assets/data/players.json');
  file.createSync(recursive: true);
  file.writeAsStringSync(jsonEncode(players));

  print("✅ ¡Archivo generado en assets/data/players.json!");
}