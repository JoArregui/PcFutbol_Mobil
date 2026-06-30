/* import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/database_service.dart';
import 'screens/title_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cargamos variables de entorno antes de lanzar la App
  await dotenv.load(fileName: "assets/.env");
  
  // Instanciamos el servicio fuera del build para que sea único
  final dbService = DatabaseService();
  
  runApp(PCFutbol2026(dbService: dbService));
}

class PCFutbol2026 extends StatelessWidget {
  final DatabaseService dbService;

  // Pasamos el servicio por el constructor
  const PCFutbol2026({super.key, required this.dbService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC Fútbol 2026',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFDEFF9A),
        scaffoldBackgroundColor: const Color(0xFF020617),
        useMaterial3: true,
      ),
      // El FutureBuilder asegura que la UI no se bloquee durante la carga masiva
      home: FutureBuilder(
        future: dbService.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TitleScreen(dbService: dbService);
          } 
          
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("ERROR AL CARGAR DATOS: ${snapshot.error}"),
              ),
            );
          }

          // Pantalla de carga con estilo PC Fútbol
          return _buildLoadingScreen();
        },
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDEFF9A)),
              strokeWidth: 2,
            ),
            SizedBox(height: 30),
            Text(
              "PC FÚTBOL 2026",
              style: TextStyle(
                color: Color(0xFFDEFF9A),
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: 6,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "PREPARANDO TEMPORADA...",
              style: TextStyle(
                color: Colors.white24, 
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
} */







import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargamos variables de entorno antes de lanzar la App
  await dotenv.load(fileName: "assets/.env");

  runApp(const PCFutbol2026());
}

class PCFutbol2026 extends StatelessWidget {
  const PCFutbol2026({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC Fútbol 2026',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFDEFF9A),
        scaffoldBackgroundColor: const Color(0xFF020617),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}