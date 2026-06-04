import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/database_service.dart';
import '../core/league_service.dart';
import '../core/staff_service.dart';
import '../models/game_save.dart';
import '../models/team.dart';
import 'secretary_screen.dart';
import 'staff_screen.dart';
import 'youth_academy_screen.dart';
import 'trophy_room_screen.dart';

class ClubManagementScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team team;

  const ClubManagementScreen({super.key, required this.dbService, required this.team});

  @override
  State<ClubManagementScreen> createState() => _ClubManagementScreenState();
}

class _ClubManagementScreenState extends State<ClubManagementScreen> with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleCard() {
    setState(() {
      _isFlipped = !_isFlipped;
      if (_isFlipped) {
        _flipController.forward();
      } else {
        _flipController.reverse();
      }
    });
  }

  /// Devuelve los datos financieros y expectativas adaptadas al prestigio/calidad del club
  Map<String, String> _getClubExpectations() {
    final name = widget.team.name.toLowerCase();
    
    if (name.contains('madrid') || name.contains('barcelona') || name.contains('atlético')) {
      return {
        "presupuesto": "150.000.000 €",
        "objetivo": "Ganar el campeonato y disputar la final de Copa.",
        "exigencia": "Crítica. Sin margen de error.",
      };
    } else if (name.contains('valencia') || name.contains('sevilla') || name.contains('betis') || name.contains('real sociedad')) {
      return {
        "presupuesto": "45.000.000 €",
        "objetivo": "Clasificación para competiciones europeas.",
        "exigencia": "Alta. La afición demanda regularidad.",
      };
    } else {
      return {
        "presupuesto": "12.500.000 €",
        "objetivo": "Evitar el descenso y asentar el bloque en la categoría.",
        "exigencia": "Media. Desarrollo y estabilidad financiera.",
      };
    }
  }

  /// Intenta obtener la puntuación de forma segura sin romper el hilo de ejecución si falla Isar o la API
  Future<int> _getSafeStandingPoints() async {
    try {
      final service = LeagueService(widget.dbService.isar);
      final standing = await service.getStanding(widget.team.apiId).timeout(
        const Duration(seconds: 2),
        onTimeout: () => throw Exception("Timeout"),
      );
      return standing?.points ?? 0;
    } catch (e) {
      // Si la base de datos está vacía o da error, devolvemos 0 de inmediato de forma silenciosa
      debugPrint("Aviso: No se pudo cargar puntos debido a base de datos vacía o error de API.");
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text("GESTIÓN DEL CLUB", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Bloque de la tarjeta aislado
          _buildFlippableClubCard(),
          _buildAcceptOfferSection(),
          const SizedBox(height: 24),
          
          // Bloque del StreamBuilder para el cuerpo técnico con lógica de verificación
          FutureBuilder<void>(
            future: StaffService(widget.dbService.isar).syncGameSave(),
            builder: (context, _) {
              return StreamBuilder<GameSave?>(
                stream: widget.dbService.isar.gameSaves.watchObject(1, fireImmediately: true),
                builder: (context, snapshot) {
                  final save = snapshot.data;
                  return FutureBuilder<Map<String, bool>>(
                    future: _hiredRoles(),
                    builder: (context, hiredSnap) {
                      final hired = hiredSnap.data ?? {};
                      final hasCoach = hired['coach'] == true;
                      final hasAssistant = hired['assistant'] == true;
                      final hasPhysio = hired['physio'] == true;

                      if (!hasCoach && !hasAssistant && !hasPhysio) {
                        return _buildEmptyStaffCTA();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMenuSection("CUERPO TÉCNICO"),
                          if (hasCoach)
                            _buildStaffTile(
                              "SECRETARIO TÉCNICO",
                              save?.staffSecretaryName ?? "—",
                              save != null && save.staffSecretaryLevel > 0
                                  ? "⭐" * save.staffSecretaryLevel
                                  : "—",
                            ),
                          if (hasAssistant)
                            _buildStaffTile(
                              "PREPARADOR FÍSICO",
                              save?.staffPreparatorName ?? "—",
                              save != null && save.staffPreparatorLevel > 0
                                  ? "⭐" * save.staffPreparatorLevel
                                  : "—",
                            ),
                          if (hasPhysio)
                            _buildStaffTile(
                              "JEFE DE MÉDICOS",
                              save?.staffMedicoName ?? "—",
                              save != null && save.staffMedicoLevel > 0
                                  ? "⭐" * save.staffMedicoLevel
                                  : "—",
                            ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
          
          const SizedBox(height: 30),
          _buildMenuSection("DESARROLLO"),
          _buildActionTile(
            "CUIDAD DEPORTIVA / CANTERA",
            "Gestiona las futuras promesas del club.",
            FontAwesomeIcons.graduationCap,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => YouthAcademyScreen(dbService: widget.dbService, team: widget.team),
                ),
              );
            },
          ),
          _buildActionTile(
            "SECRETARÍA",
            "Mensajes del presidente y renovaciones.",
            FontAwesomeIcons.envelopeOpenText,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SecretaryScreen(dbService: widget.dbService)),
              );
            },
          ),
          const SizedBox(height: 30),
          _buildMenuSection("HISTORIAL"),
          _buildActionTile(
            "SALA DE TROFEOS",
            "Palmarés y logros del club.",
            FontAwesomeIcons.trophy,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TrophyRoomScreen(dbService: widget.dbService, team: widget.team),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStaffCTA() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDEFF9A).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Icon(FontAwesomeIcons.userTie, color: Color(0xFFDEFF9A), size: 40),
          const SizedBox(height: 16),
          const Text(
            "CUERPO TÉCNICO VACANTE",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            "No hay personal contratado. Ve a Staff para fichar secretario, preparador y médico.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StaffScreen(dbService: widget.dbService, team: widget.team),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDEFF9A),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("IR A STAFF", style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }

  Future<Map<String, bool>> _hiredRoles() async {
    final staff = StaffService(widget.dbService.isar);
    return {
      'coach': (await staff.getByRole('coach')) != null,
      'assistant': (await staff.getByRole('assistant')) != null,
      'physio': (await staff.getByRole('physio')) != null,
    };
  }

  Widget _buildFlippableClubCard() {
    return GestureDetector(
      onTap: _toggleCard,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _flipController,
        builder: (context, child) {
          final transformValue = _flipController.value * pi;
          final isBack = transformValue >= pi / 2;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateY(transformValue),
            alignment: Alignment.center,
            child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: _buildCardBack(),
                  )
                : _buildCardFront(),
          );
        },
      ),
    );
  }

  Widget _buildCardFront() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFDEFF9A).withOpacity(0.15), const Color(0xFF0F172A)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDEFF9A).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          if (widget.team.logoUrl.isNotEmpty)
            Image.network(
              widget.team.logoUrl, 
              height: 56, 
              errorBuilder: (_, __, ___) => const Icon(Icons.shield, size: 48, color: Color(0xFFDEFF9A))
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(widget.team.name.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
                    ),
                    const Icon(Icons.autorenew, color: Color(0xFFDEFF9A), size: 16),
                  ],
                ),
                Text(widget.team.city, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                FutureBuilder<int>(
                  future: _getSafeStandingPoints(),
                  builder: (context, stSnap) {
                    final pts = stSnap.data ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Temporada en curso · $pts puntos",
                        style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    final info = _getClubExpectations();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDEFF9A), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDEFF9A).withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "CONTRATO: ${widget.team.name.toUpperCase()}",
                  style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1),
                ),
              ),
              const Icon(Icons.info_outline, color: Colors.white38, size: 16),
            ],
          ),
          const Divider(color: Colors.white10, height: 20),
          _buildBackDataRow("PRESUPUESTO FICHAJES", info["presupuesto"]!, FontAwesomeIcons.wallet),
          const SizedBox(height: 12),
          _buildBackDataRow("OBJETIVO DIRECTIVA", info["objetivo"]!, FontAwesomeIcons.bullseye),
          const SizedBox(height: 12),
          _buildBackDataRow("NIVEL DE EXIGENCIA", info["exigencia"]!, FontAwesomeIcons.gaugeHigh),
        ],
      ),
    );
  }

  Widget _buildAcceptOfferSection() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: _isFlipped
          ? Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  children: [
                    const Text(
                      "¿ACEPTAS LA OFERTA DE EMPLEO?",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDEFF9A),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Oferta aceptada. ¡Bienvenido al despacho del ${widget.team.name}!"),
                            backgroundColor: const Color(0xFF1E293B),
                          ),
                        );
                      },
                      icon: const Icon(FontAwesomeIcons.fileSignature, size: 14),
                      label: const Text("FIRMAR CONTRATO", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.5)),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildBackDataRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, color: Colors.white38, size: 12),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600, height: 1.2)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Text(title, style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12)),
    );
  }

  Widget _buildStaffTile(String role, String name, String level) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role, style: const TextStyle(color: Colors.white38, fontSize: 10)),
              Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(level, style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildActionTile(String title, String sub, IconData icon, VoidCallback onTap) {
    return Card(
      color: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFFDEFF9A), size: 20),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 11)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white24, size: 18),
      ),
    );
  }
}