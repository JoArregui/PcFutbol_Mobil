import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:isar/isar.dart';
import '../core/training_engine.dart';
import '../core/database_service.dart';
import '../core/game_session_service.dart';
import '../core/message_service.dart';
import '../models/game_message.dart';
import '../models/team.dart';
import '../models/player_model.dart';

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
  bool _isLoadingData = true;

  double _staffMultiplier = 1.0;
  int _maxSelectablePlayers = 3;
  List<Player> _teamPlayers = [];
  final List<int> _selectedPlayerIds = [];

  final Map<TrainingFocus, dynamic> _focusData = {
    TrainingFocus.fitness: {"icon": FontAwesomeIcons.bolt, "label": "Físico", "desc": "Mejora resistencia y velocidad."},
    TrainingFocus.shooting: {"icon": FontAwesomeIcons.bullseye, "label": "Tiro", "desc": "Precisión y potencia de remate."},
    TrainingFocus.passing: {"icon": FontAwesomeIcons.arrowsSpin, "label": "Pase", "desc": "Control y visión de juego."},
    TrainingFocus.defense: {"icon": FontAwesomeIcons.shieldHalved, "label": "Defensa", "desc": "Robo y posicionamiento."},
    TrainingFocus.tactical: {"icon": FontAwesomeIcons.clipboardList, "label": "Táctico", "desc": "Estrategia mixta de equipo."},
  };

  @override
  void initState() {
    super.initState();
    _loadStaffAndPlayers();
  }

  Future<void> _loadStaffAndPlayers() async {
    final session = GameSessionService(widget.dbService.isar);
    final multiplier = await session.trainingMultiplier();
    final engine = TrainingEngine(widget.dbService.isar);
    
    final limit = engine.getSelectionLimit(multiplier);
    final players = await widget.dbService.isar.players
        .filter()
        .teamApiIdEqualTo(widget.userTeam.apiId)
        .findAll();

    setState(() {
      _staffMultiplier = multiplier;
      _maxSelectablePlayers = limit;
      _teamPlayers = players;
      _isLoadingData = false;
    });
  }

  /// Ejecuta un entrenamiento automatizado delegando en el motor la configuración inteligente
  Future<void> _executeAutoTraining() async {
    if (_teamPlayers.isEmpty || _isTraining) return;

    setState(() => _isTraining = true);

    final engine = TrainingEngine(widget.dbService.isar);
    
    // El motor elige dinámicamente el foco e identifica a los jugadores ideales según su potencial
    final autoConfig = engine.autoSelectConfiguration(
      teamPlayers: _teamPlayers,
      maxCupos: _maxSelectablePlayers,
    );

    final TrainingFocus chosenFocus = autoConfig["focus"];
    final List<int> chosenPlayerIds = autoConfig["playerIds"];

    final report = await engine.trainSelectedPlayers(
      chosenPlayerIds,
      chosenFocus,
      staffMultiplier: _staffMultiplier,
    );

    int totalImproved = report.values.where((r) => r.improved).length;

    await MessageService(widget.dbService.isar).add(
      title: "Informe Auto-Entrenamiento",
      body: "El cuerpo técnico completó una sesión automatizada de ${_focusData[chosenFocus]['label']}. Progresaron $totalImproved futbolistas.",
      type: MessageType.training,
    );

    if (mounted) {
      setState(() {
        _isTraining = false;
      });
      _showEvolutionDialog(report);
    }
  }

  Future<void> _executeTraining() async {
    if (_selectedFocus == null || _selectedPlayerIds.isEmpty || _isTraining) return;

    setState(() => _isTraining = true);

    final engine = TrainingEngine(widget.dbService.isar);
    final report = await engine.trainSelectedPlayers(
      _selectedPlayerIds,
      _selectedFocus!,
      staffMultiplier: _staffMultiplier,
    );

    int totalImproved = report.values.where((r) => r.improved).length;

    await MessageService(widget.dbService.isar).add(
      title: "Informe de entrenamiento",
      body: "$totalImproved jugadores han progresado en la sesión de ${_focusData[_selectedFocus!]['label']}.",
      type: MessageType.training,
    );

    if (mounted) {
      setState(() {
        _isTraining = false;
      });
      _showEvolutionDialog(report);
    }
  }

  void _showEvolutionDialog(Map<int, TrainingResult> report) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0F172A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Colors.white10)),
          title: const Text(
            "INFORME DE RENDIMIENTO",
            style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.5),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: report.values.map((result) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.playerName,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Text(
                              result.statName,
                              style: const TextStyle(color: Colors.white38, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${result.oldStat}",
                            style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: Icon(Icons.arrow_forward, color: Colors.white24, size: 12),
                          ),
                          Text(
                            "${result.newStat}",
                            style: TextStyle(
                              color: result.improved ? const Color(0xFFDEFF9A) : Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: result.improved ? 15 : 13,
                            ),
                          ),
                          if (result.improved)
                            const Padding(
                              padding: EdgeInsets.only(left: 6.0),
                              child: Icon(Icons.trending_up, color: Color(0xFFDEFF9A), size: 14),
                            ),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _selectedFocus = null;
                  _selectedPlayerIds.clear();
                });
                _loadStaffAndPlayers(); 
              },
              child: const Text("ENTENDIDO", style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)),
            )
          ],
        );
      },
    );
  }

  void _togglePlayerSelection(int playerId) {
    setState(() {
      if (_selectedPlayerIds.contains(playerId)) {
        _selectedPlayerIds.remove(playerId);
      } else {
        if (_selectedPlayerIds.length < _maxSelectablePlayers) {
          _selectedPlayerIds.add(playerId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Tu preparador físico solo permite entrenar $_maxSelectablePlayers jugadores a la vez."),
              backgroundColor: Colors.amber[700],
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingData) {
      return const Scaffold(
        backgroundColor: Color(0xFF020617),
        body: Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A))),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text("CENTRO DE ENTRENAMIENTO", style: TextStyle(letterSpacing: 2, fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PLANTILLA: ${widget.userTeam.name.toUpperCase()}",
              style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1),
            ),
            const SizedBox(height: 4),
            Text(
              "NIVEL DEL STAFF: ${(_staffMultiplier * 100).toStringAsFixed(0)}% · CUPOS DISPONIBLES: $_maxSelectablePlayers JUGADORES",
              style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "1. SELECCIONA EL ENFOQUE SEMANAL",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _focusData.entries.map((e) => _buildHorizontalFocusCard(e.key)).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "2. ASIGNA JUGADORES (${_selectedPlayerIds.length} / $_maxSelectablePlayers)",
              style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: _teamPlayers.length,
                  separatorBuilder: (context, index) => const Divider(color: Colors.white10, height: 1),
                  itemBuilder: (context, index) {
                    final player = _teamPlayers[index];
                    final isChecked = _selectedPlayerIds.contains(player.id);
                    return ListTile(
                      dense: true,
                      title: Text(
                        player.name,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${player.position} · Media: ${player.average.toStringAsFixed(0)} · Edad: ${player.age} ${player.isUnicorn ? '🌟' : ''}",
                        style: const TextStyle(color: Colors.white38, fontSize: 11),
                      ),
                      trailing: Switch(
                        value: isChecked,
                        activeColor: const Color(0xFFDEFF9A),
                        activeTrackColor: const Color(0xFFDEFF9A).withOpacity(0.3),
                        inactiveThumbColor: Colors.white24,
                        inactiveTrackColor: Colors.white10,
                        onChanged: (val) => _togglePlayerSelection(player.id),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildActionControlPanel(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalFocusCard(TrainingFocus focus) {
    final isSelected = _selectedFocus == focus;
    final data = _focusData[focus];

    return GestureDetector(
      onTap: () => setState(() => _selectedFocus = focus),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 130,
        margin: const EdgeInsets.only(right: 12, bottom: 4, top: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDEFF9A).withOpacity(0.15) : const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isSelected ? const Color(0xFFDEFF9A) : Colors.white10, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data['icon'], color: isSelected ? const Color(0xFFDEFF9A) : Colors.white54, size: 24),
            const SizedBox(height: 8),
            Text(
              data['label'],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              data['desc'],
              style: const TextStyle(fontSize: 9, color: Colors.white38),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionControlPanel() {
    final canTrainManual = _selectedFocus != null && _selectedPlayerIds.isNotEmpty && !_isTraining;

    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E293B),
            foregroundColor: const Color(0xFFDEFF9A),
            minimumSize: const Size(64, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.white10, width: 1),
            ),
            elevation: 0,
          ),
          onPressed: _isTraining ? null : _executeAutoTraining,
          child: const Icon(FontAwesomeIcons.boltLightning, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: canTrainManual ? const Color(0xFFDEFF9A) : Colors.white10,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              disabledBackgroundColor: Colors.white10,
            ),
            onPressed: canTrainManual ? _executeTraining : null,
            child: _isTraining
                ? const CircularProgressIndicator(color: Colors.black)
                : Text(
                    _selectedFocus == null 
                        ? "SELECCIONA UN FOCO" 
                        : _selectedPlayerIds.isEmpty 
                            ? "SELECCIONA JUGADORES" 
                            : "INICIAR SESIÓN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 14,
                      color: canTrainManual ? Colors.black : Colors.white24,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}