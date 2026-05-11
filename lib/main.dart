import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Añadida la importación
import 'core/database_service.dart';
import 'screens/team_selection_screen.dart';

// Agregamos 'async' para poder usar 'await'
void main() async {
  // Asegura que los bindings de Flutter estén listos
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cargamos el archivo de variables de entorno
  await dotenv.load(fileName: "assets/.env");
  
  runApp(const PCFutbol2026());
}

class PCFutbol2026 extends StatelessWidget {
  const PCFutbol2026({super.key});

  @override
  Widget build(BuildContext context) {
    // Instanciamos el servicio de base de datos
    final dbService = DatabaseService();

    return MaterialApp(
      title: 'PC Fútbol 2026',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFDEFF9A),
        scaffoldBackgroundColor: const Color(0xFF020617),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: dbService.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TeamSelectionScreen(dbService: dbService);
          } else {
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDEFF9A)),
                    ),
                    SizedBox(height: 25),
                    Text(
                      "PC FÚTBOL 2026",
                      style: TextStyle(
                        color: Color(0xFFDEFF9A),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "OPTIMIZANDO BASE DE DATOS...",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}