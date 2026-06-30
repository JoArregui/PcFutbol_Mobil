import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/database_service.dart';
import '../core/scout_service.dart';
import '../core/tactics_service.dart';
import '../models/game_save.dart';
import '../models/team.dart';
import '../models/league_fixture.dart';

class AdvancedTacticsScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;
  final LeagueFixture? nextFixture;

  const AdvancedTacticsScreen({
    super.key,
    required this.dbService,
    required this.userTeam,
    this.nextFixture,
  });

  @override
  State<AdvancedTacticsScreen> createState() => _AdvancedTacticsScreenState();
}

class _AdvancedTacticsScreenState extends State<AdvancedTacticsScreen> {
  GameSave? _save;
  ScoutReport? _scoutReport;
  bool _loading = true;
  String _selectedTab = 'tactics';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _save = await widget.dbService.isar.gameSaves.get(1);

    LeagueFixture? fixture = widget.nextFixture;
    
    // Si no hay fixture proporcionado, buscar el próximo partido
    if (fixture == null && _save != null) {
      // Traer todos los fixtures y filtrar en Dart
      final allFixtures = await widget.dbService.getAllFixtures();
      
      final fixtures = allFixtures.where((f) =>
          (f.homeTeamApiId == _save!.userTeamApiId ||
           f.awayTeamApiId == _save!.userTeamApiId) &&
          f.matchday >= _save!.currentMatchday).toList()
        ..sort((a, b) => a.matchday.compareTo(b.matchday));
      
      if (fixtures.isNotEmpty) {
        fixture = fixtures.first;
      }
    }

    if (fixture != null) {
      final opponentId = _save!.userTeamApiId == fixture.homeTeamApiId
          ? fixture.awayTeamApiId
          : fixture.homeTeamApiId;

      final allTeams = await widget.dbService.getAllTeams();
      final opponents = allTeams.where((t) => t.apiId == opponentId).toList();
      if (opponents.isNotEmpty) {
        _scoutReport = await ScoutService(widget.dbService.isar)
            .generateScoutReport(opponents.first, widget.userTeam.apiId);
      }
    }

    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text(
          'TÁCTICAS AVANZADAS',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)))
          : Column(
              children: [
                _tabs(),
                Expanded(
                  child: _selectedTab == 'tactics'
                      ? _tacticsPanel()
                      : _selectedTab == 'scout'
                          ? _scoutPanel()
                          : _gamePlanPanel(),
                ),
              ],
            ),
    );
  }

  Widget _tabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          _tabChip('TÁCTICA', 'tactics'),
          const SizedBox(width: 6),
          _tabChip('SCOUTING', 'scout'),
          const SizedBox(width: 6),
          _tabChip('PLAN DE PARTIDO', 'plan'),
        ],
      ),
    );
  }

  Widget _tabChip(String label, String id) {
    final selected = _selectedTab == id;
    return Expanded(
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.black : Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        selected: selected,
        selectedColor: const Color(0xFFDEFF9A),
        onSelected: (_) => setState(() => _selectedTab = id),
      ),
    );
  }

  // === PANEL DE TÁCTICA ===

  Widget _tacticsPanel() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _formationSelector(),
        const SizedBox(height: 16),
        _mentalitySelector(),
        const SizedBox(height: 16),
        _intensitySelector(),
        const SizedBox(height: 16),
        _styleSelector(),
      ],
    );
  }

  Widget _formationSelector() {
    const formations = TacticsService.formations;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('FORMACIÓN', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: formations.map((f) {
            final selected = _save?.defaultFormation == f;
            return FilterChip(
              label: Text(f, style: TextStyle(color: selected ? Colors.black : Colors.white)),
              selected: selected,
              selectedColor: const Color(0xFFDEFF9A),
              onSelected: (v) async {
                if (v && _save != null) {
                  _save!.defaultFormation = f;
                  await widget.dbService.isar.writeTxn(() => widget.dbService.isar.gameSaves.put(_save!));
                  setState(() {});
                }
              },
            );
          }).toList(),
        ),
        if (_save != null) ...[
          const SizedBox(height: 8),
          Text(
            TacticsService.formationLabel(_save!.defaultFormation),
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ],
      ],
    );
  }

  Widget _mentalitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('MENTALIDAD', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        _enumSelector<TeamMentality>(
          TeamMentality.values,
          _save?.teamMentality ?? TeamMentality.balanced,
          TacticsService.mentalityLabel,
          (val) async {
            _save?.teamMentality = val;
            await widget.dbService.isar.writeTxn(() => widget.dbService.isar.gameSaves.put(_save!));
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _intensitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('INTENSIDAD', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        _enumSelector<TeamIntensity>(
          TeamIntensity.values,
          _save?.teamIntensity ?? TeamIntensity.normal,
          TacticsService.intensityLabel,
          (val) async {
            _save?.teamIntensity = val;
            await widget.dbService.isar.writeTxn(() => widget.dbService.isar.gameSaves.put(_save!));
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _styleSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ESTILO DE JUEGO', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        _enumSelector<TeamStyle>(
          TeamStyle.values,
          _save?.teamStyle ?? TeamStyle.possession,
          TacticsService.styleLabel,
          (val) async {
            _save?.teamStyle = val;
            await widget.dbService.isar.writeTxn(() => widget.dbService.isar.gameSaves.put(_save!));
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _enumSelector<T extends Enum>(
    List<T> values,
    T selected,
    String Function(T) labelFn,
    Function(T) onSelect,
  ) {
    return Column(
      children: values.map((val) {
        final isSelected = selected == val;
        return ListTile(
          onTap: () => onSelect(val),
          tileColor: isSelected ? const Color(0xFF0F172A) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isSelected ? const Color(0xFFDEFF9A).withValues(alpha: 0.5) : Colors.transparent,
            ),
          ),
          title: Text(labelFn(val), style: TextStyle(color: isSelected ? const Color(0xFFDEFF9A) : Colors.white, fontSize: 13)),
          trailing: isSelected ? const Icon(Icons.check, color: Color(0xFFDEFF9A)) : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        );
      }).toList(),
    );
  }

  // === PANEL DE SCOUTING ===

  Widget _scoutPanel() {
    if (_scoutReport == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No hay próximo partido programado para generar un informe de scouting.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white38),
          ),
        ),
      );
    }

    final report = _scoutReport!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _scoutHeader(report),
        const SizedBox(height: 16),
        _strengthsWeaknesses(report),
        const SizedBox(height: 16),
        _dangerPlayers(report),
        const SizedBox(height: 16),
        _recommendations(report),
        const SizedBox(height: 16),
        _prediction(report),
      ],
    );
  }

  Widget _scoutHeader(ScoutReport report) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFDEFF9A).withValues(alpha: 0.15), const Color(0xFF0F172A)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDEFF9A).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(FontAwesomeIcons.search, color: Color(0xFFDEFF9A), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'INFORME: ${report.opponent.name.toUpperCase()}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('FUERZA DEL EQUIPO: ', style: TextStyle(color: Colors.white54, fontSize: 11)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: report.teamStrength >= 80
                      ? Colors.redAccent.withValues(alpha: 0.3)
                      : report.teamStrength >= 65
                          ? Colors.orangeAccent.withValues(alpha: 0.3)
                          : Colors.greenAccent.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${report.teamStrength.toStringAsFixed(0)} / 100',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _strengthsWeaknesses(ScoutReport report) {
    return Row(
      children: [
        Expanded(
          child: _infoCard(
            'FORTALEZA',
            report.keyStrength,
            FontAwesomeIcons.arrowTrendUp,
            Colors.greenAccent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _infoCard(
            'DEBILIDAD',
            report.keyWeakness,
            FontAwesomeIcons.arrowTrendDown,
            Colors.redAccent,
          ),
        ),
      ],
    );
  }

  Widget _dangerPlayers(ScoutReport report) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(FontAwesomeIcons.skull, color: Colors.redAccent, size: 16),
              SizedBox(width: 8),
              Text('JUGADORES PELIGROSOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          ...report.dangerPlayers.map((name) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.amber, size: 14),
                    const SizedBox(width: 8),
                    Text(name, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _recommendations(ScoutReport report) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(FontAwesomeIcons.lightbulb, color: Color(0xFFDEFF9A), size: 16),
              SizedBox(width: 8),
              Text('RECOMENDACIONES', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          _recommendationRow('Formación', report.recommendedTactic),
          const SizedBox(height: 8),
          _recommendationRow('Mentalidad', TacticsService.mentalityLabel(report.recommendedMentality)),
          const SizedBox(height: 8),
          _recommendationRow('Estilo', TacticsService.styleLabel(report.recommendedStyle)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDEFF9A),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: () async {
              _save?.defaultFormation = report.recommendedTactic;
              _save?.teamMentality = report.recommendedMentality;
              _save?.teamStyle = report.recommendedStyle;
              await widget.dbService.isar.writeTxn(() => widget.dbService.isar.gameSaves.put(_save!));
              setState(() {});
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tácticas aplicadas automáticamente!')),
                );
              }
            },
            icon: const Icon(Icons.auto_awesome),
            label: const Text('APLICAR RECOMENDACIONES', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _recommendationRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ', style: const TextStyle(color: Colors.white54, fontSize: 12)),
        Expanded(child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 12))),
      ],
    );
  }

  Widget _prediction(ScoutReport report) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(FontAwesomeIcons.star, color: Colors.purpleAccent, size: 16),
              SizedBox(width: 8),
              Text('PREDICCIÓN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(report.prediction, style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 8),
          Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  // === PANEL DE PLAN DE PARTIDO ===

  Widget _gamePlanPanel() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _automaticAdjustments(),
        const SizedBox(height: 16),
        _phasePlans(),
        const SizedBox(height: 16),
        _specialInstructions(),
      ],
    );
  }

  Widget _automaticAdjustments() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('AJUSTES AUTOMÁTICOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              Switch(
                value: _save?.useAutomaticPhaseAdjustments ?? false,
                onChanged: (v) async {
                  _save?.useAutomaticPhaseAdjustments = v;
                  await widget.dbService.isar.writeTxn(() => widget.dbService.isar.gameSaves.put(_save!));
                  setState(() {});
                },
                activeColor: const Color(0xFFDEFF9A),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Activa ajustes tácticos automáticos según el transcurso del partido y el marcador.',
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _phasePlans() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PLANES POR FASE DEL PARTIDO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          SizedBox(height: 16),
          Text(
            'Esta sección estará disponible próximamente. Podrás configurar ajustes específicos para:',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          SizedBox(height: 12),
          Text('• Inicio del partido (0-30 min)', style: TextStyle(color: Colors.white70)),
          Text('• Mitad del partido (30-60 min)', style: TextStyle(color: Colors.white70)),
          Text('• Final del partido (60-90 min)', style: TextStyle(color: Colors.white70)),
          Text('• Si vamos ganando', style: TextStyle(color: Colors.white70)),
          Text('• Si vamos perdiendo', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _specialInstructions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('INSTRUCCIONES ESPECÍFICAS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          SizedBox(height: 16),
          Text(
            'Próximamente podrás dar instrucciones individuales por jugador, como:',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          SizedBox(height: 12),
          Text('• Marcaje al hombre', style: TextStyle(color: Colors.white70)),
          Text('• Subir por la banda', style: TextStyle(color: Colors.white70)),
          Text('• Posesión segura', style: TextStyle(color: Colors.white70)),
          Text('• Tiro desde lejos', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
