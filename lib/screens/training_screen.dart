import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/training_engine.dart';
import '../core/database_service.dart';

class TrainingScreen extends StatefulWidget {
  final DatabaseService dbService;
  const TrainingScreen({super.key, required this.dbService});

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

  void _executeTraining() async {
    if (_selectedFocus == null) return;

    setState(() => _isTraining = true);

    final engine = TrainingEngine(widget.dbService.isar);
    // Asumimos "USER_TEAM" como el ID de tu equipo
    await engine.trainTeam("USER_TEAM", _selectedFocus!);

    // Animación de éxito
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("¡Entrenamiento de ${_focusData[_selectedFocus!]['label']} finalizado!"),
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
            const Text("SELECCIONA EL ENFOQUE SEMANAL", 
              style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _focusData.entries.map((entry) => _buildFocusCard(entry.key)).toList(),
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
    bool isSelected = _selectedFocus == focus;
    var data = _focusData[focus];

    return GestureDetector(
      onTap: () => setState(() => _selectedFocus = focus),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDEFF9A).withOpacity(0.1) : const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFDEFF9A) : Colors.transparent,
            width: 2,
          ),
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