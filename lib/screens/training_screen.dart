import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/training_engine.dart';
import '../core/database_service.dart';
import '../core/game_session_service.dart';
import '../core/message_service.dart';
import '../models/game_message.dart';
import '../models/team.dart';

class TrainingScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const TrainingScreen({super.key, required this.dbService, required this.userTeam});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  TrainingFocus? _selectedFocus;
  bool _isTraining = false;

  final Map<TrainingFocus, dynamic> _focusData = {
    TrainingFocus.fitness: {"icon": FontAwesomeIcons.bolt, "label": "Físico", "desc": "Mejora resistencia y velocidad."},
    TrainingFocus.shooting: {"icon": FontAwesomeIcons.bullseye, "label": "Tiro", "desc": "Precisión y potencia de remate."},
    TrainingFocus.passing: {"icon": FontAwesomeIcons.arrowsSpin, "label": "Pase", "desc": "Control y visión de juego."},
    TrainingFocus.defense: {"icon": FontAwesomeIcons.shieldHalved, "label": "Defensa", "desc": "Robo y posicionamiento."},
    TrainingFocus.tactical: {"icon": FontAwesomeIcons.clipboardList, "label": "Táctico", "desc": "Estrategia mixta de equipo."},
  };

  Future<void> _executeTraining() async {
    if (_selectedFocus == null) return;

    setState(() => _isTraining = true);

    final session = GameSessionService(widget.dbService.isar);
    final multiplier = await session.trainingMultiplier();
    final engine = TrainingEngine(widget.dbService.isar);
    final improved = await engine.trainTeam(
      widget.userTeam.apiId,
      _selectedFocus!,
      staffMultiplier: multiplier,
    );

    await MessageService(widget.dbService.isar).add(
      title: "Sesión de entrenamiento",
      body: improved > 0
          ? "$improved jugadores han mejorado sus atributos."
          : "Sesión táctica sin progreso visible esta semana.",
      type: MessageType.training,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            improved > 0
                ? "¡Sesión de ${_focusData[_selectedFocus!]['label']}! $improved jugadores mejoraron."
                : "Sesión completada. El equipo no progresó esta vez.",
          ),
          backgroundColor: const Color(0xFFDEFF9A),
        ),
      );
      setState(() {
        _isTraining = false;
        _selectedFocus = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text("CENTRO DE ENTRENAMIENTO", style: TextStyle(letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PLANTILLA: ${widget.userTeam.name.toUpperCase()}",
              style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1),
            ),
            const SizedBox(height: 6),
            const Text(
              "SELECCIONA EL ENFOQUE SEMANAL",
              style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _focusData.entries.map((e) => _buildFocusCard(e.key)).toList(),
              ),
            ),
            const SizedBox(height: 20),
            _buildTrainButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusCard(TrainingFocus focus) {
    final isSelected = _selectedFocus == focus;
    final data = _focusData[focus];

    return GestureDetector(
      onTap: () => setState(() => _selectedFocus = focus),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDEFF9A).withOpacity(0.1) : const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? const Color(0xFFDEFF9A) : Colors.transparent, width: 2),
        ),
        child: Row(
          children: [
            Icon(data['icon'], color: isSelected ? const Color(0xFFDEFF9A) : Colors.white24, size: 30),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['label'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(data['desc'], style: const TextStyle(fontSize: 12, color: Colors.white54)),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle, color: Color(0xFFDEFF9A)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedFocus == null ? Colors.white10 : const Color(0xFFDEFF9A),
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        disabledBackgroundColor: Colors.white10,
      ),
      onPressed: (_selectedFocus == null || _isTraining) ? null : _executeTraining,
      child: _isTraining
          ? const CircularProgressIndicator(color: Colors.black)
          : const Text("INICIAR SESIÓN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }
}
