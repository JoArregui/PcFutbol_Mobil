import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../core/editor_service.dart';
import '../models/editor_config.dart';
import '../models/player_model.dart';
import '../models/team.dart';

class EditorScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const EditorScreen({super.key, required this.dbService, required this.userTeam});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late final EditorService _editor;
  EditorConfig? _cfg;
  List<Player> _squad = [];
  final _leagueCtrl = TextEditingController();
  final _clubCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _editor = EditorService(widget.dbService.isar);
    _load();
  }

  @override
  void dispose() {
    _leagueCtrl.dispose();
    _clubCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final cfg = await _editor.getConfig();
    final squad = await widget.dbService.getPlayersByTeam(widget.userTeam.apiId, professionalsOnly: true);
    _leagueCtrl.text = cfg.leagueName;
    _clubCtrl.text = cfg.userTeamNameOverride.isNotEmpty ? cfg.userTeamNameOverride : widget.userTeam.name;
    if (mounted) {
      setState(() {
        _cfg = cfg;
        _squad = squad;
      });
    }
  }

  Future<void> _saveLeague() async {
    if (_cfg == null) return;
    _cfg!
      ..leagueName = _leagueCtrl.text.trim()
      ..userTeamNameOverride = _clubCtrl.text.trim();
    await _editor.saveConfig(_cfg!);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Liga y club actualizados.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text('EDITOR', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('LIGA', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          TextField(
            controller: _leagueCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: _dec('Nombre de la competición'),
          ),
          const SizedBox(height: 16),
          const Text('TU CLUB', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12)),
          TextField(
            controller: _clubCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: _dec('Nombre mostrado en el juego'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDEFF9A), foregroundColor: Colors.black),
            onPressed: _saveLeague,
            child: const Text('GUARDAR LIGA / CLUB'),
          ),
          const Divider(color: Colors.white10, height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('PLANTILLA', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () async {
                  await _editor.createCustomPlayer(widget.userTeam.apiId);
                  await _load();
                },
                child: const Text('+ JUGADOR', style: TextStyle(color: Color(0xFFDEFF9A))),
              ),
            ],
          ),
          ..._squad.map((p) => ListTile(
                title: Text(p.name, style: const TextStyle(color: Colors.white)),
                subtitle: Text('${p.position} · ${p.nationality} · Contrato ${p.contractYearsRemaining}a'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFFDEFF9A)),
                  onPressed: () => _editPlayer(p),
                ),
              )),
        ],
      ),
    );
  }

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        filled: true,
        fillColor: const Color(0xFF0F172A),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      );

  Future<void> _editPlayer(Player p) async {
    final nameCtrl = TextEditingController(text: p.name);
    final contractCtrl = TextEditingController(text: '${p.contractYearsRemaining}');
    final statCtrl = TextEditingController(text: p.stats.isNotEmpty ? '${p.stats.first}' : '70');

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('Editar jugador', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, style: const TextStyle(color: Colors.white), decoration: _dec('Nombre')),
            TextField(controller: contractCtrl, style: const TextStyle(color: Colors.white), decoration: _dec('Años de contrato')),
            TextField(controller: statCtrl, style: const TextStyle(color: Colors.white), decoration: _dec('Media base (stats)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('CANCELAR')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('GUARDAR', style: TextStyle(color: Color(0xFFDEFF9A))),
          ),
        ],
      ),
    );

    if (ok == true) {
      p.name = nameCtrl.text.trim();
      p.contractYearsRemaining = int.tryParse(contractCtrl.text) ?? p.contractYearsRemaining;
      final base = int.tryParse(statCtrl.text) ?? 70;
      p.stats = List.generate(5, (_) => base);
      p.marketValue = base * 120000.0;
      await _editor.updatePlayer(p);
      await _load();
    }
    nameCtrl.dispose();
    contractCtrl.dispose();
    statCtrl.dispose();
  }
}
