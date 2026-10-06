import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/database_service.dart';
import 'title_screen.dart';

/// =============================================================================
/// SPLASH SCREEN
/// -----------------------------------------------------------------------------
/// Se muestra mientras DatabaseService.init() inicializa Isar y sincroniza
/// los datos iniciales desde la API (si la BD está vacía).
/// =============================================================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _bgController;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;

  String _status = "Iniciando…";

  @override
  void initState() {
    super.initState();

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _logoController.forward();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final stopwatch = Stopwatch()..start();
    final dbService = DatabaseService();
    bool initOk = true;

    try {
      if (mounted) setState(() => _status = "Cargando base de datos…");
      await dbService.init();
    } catch (e) {
      initOk = false;
      if (mounted) setState(() => _status = "Error al iniciar. Reintentando…");
      debugPrint("❌ Error inicializando BD: $e");
    }

    // Aseguramos un mínimo de tiempo en pantalla para que la animación
    // se aprecie, aunque la BD cargue muy rápido.
    const minSplashTime = Duration(milliseconds: 2200);
    final elapsed = stopwatch.elapsed;
    if (elapsed < minSplashTime) {
      await Future.delayed(minSplashTime - elapsed);
    }

    if (!mounted) return;
    if (!initOk) {
      if (mounted) {
        setState(() => _status = "No se pudo iniciar la BD. Revisa almacenamiento.");
      }
      return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          child: TitleScreen(dbService: dbService),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo con gradiente sutil animado
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, _) {
              final t = _bgController.value;
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.0, -0.3 + 0.1 * t),
                    radius: 1.4,
                    colors: const [
                      Color(0xFF0F2818),
                      Color(0xFF020617),
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              );
            },
          ),

          // Patrón decorativo: líneas de campo de fútbol muy sutiles
          Positioned.fill(
            child: CustomPaint(
              painter: _PitchLinesPainter(),
            ),
          ),

          // Contenido central
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),

                // Logo / balón estilizado
                FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: _buildLogo(),
                  ),
                ),

                const SizedBox(height: 28),

                // Título
                SlideTransition(
                  position: _textSlide,
                  child: FadeTransition(
                    opacity: _textFade,
                    child: Column(
                      children: [
                        Text(
                          "PC FÚTBOL",
                          style: GoogleFonts.urbanist(
                            color: const Color(0xFFDEFF9A),
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "2 0 2 6   E D I T I O N",
                          style: GoogleFonts.urbanist(
                            color: Colors.white38,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(flex: 3),

                // Indicador de carga + estado
                FadeTransition(
                  opacity: _textFade,
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Color(0xFFDEFF9A),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _status,
                          key: ValueKey(_status),
                          style: GoogleFonts.urbanist(
                            color: Colors.white38,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFDEFF9A).withOpacity(0.08),
        border: Border.all(
          color: const Color(0xFFDEFF9A).withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDEFF9A).withOpacity(0.25),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: const Icon(
        Icons.sports_soccer_rounded,
        color: Color(0xFFDEFF9A),
        size: 56,
      ),
    );
  }
}

/// Dibuja unas líneas de campo de fútbol muy tenues como decoración de fondo.
class _PitchLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Línea de medio campo
    final midY = size.height * 0.5;
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), paint);

    // Círculo central
    canvas.drawCircle(
      Offset(size.width / 2, midY),
      size.width * 0.18,
      paint,
    );

    // Arcos superior e inferior (áreas)
    final areaWidth = size.width * 0.5;
    final areaHeight = size.height * 0.12;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, 0),
        width: areaWidth,
        height: areaHeight * 2,
      ),
      paint,
    );

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height),
        width: areaWidth,
        height: areaHeight * 2,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}