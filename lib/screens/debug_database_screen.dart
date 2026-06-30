import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import '../core/database_service.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import '../models/game_save.dart';

class DebugDatabaseScreen extends StatefulWidget {
  final DatabaseService dbService;

  const DebugDatabaseScreen({super.key, required this.dbService});

  @override
  State<DebugDatabaseScreen> createState() => _DebugDatabaseScreenState();
}

class _DebugDatabaseScreenState extends State<DebugDatabaseScreen> {
  // ── Estado general ────────────────────────────────────────────────────────
  bool _loading = true;
  String _activeTab = 'jugadores';

  // ── Datos cargados ────────────────────────────────────────────────────────
  List<Player> _players = [];
  List<Team> _teams = [];
  GameSave? _save;

  // ── Filtros jugadores ─────────────────────────────────────────────────────
  int? _filterTeamApiId;
  String _filterPosition = 'TODOS';
  String _filterType = 'TODOS'; // TODOS | REAL | GENERADO | CANTERA
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    final players = await widget.dbService.isar.players.where().findAll();
    final teams = await widget.dbService.isar.teams.where().findAll();
    final save = await widget.dbService.isar.gameSaves.get(1);
    setState(() {
      _players = players;
      _teams = teams;
      _save = save;
      _loading = false;
    });
  }

  List<Player> get _filteredPlayers {
    return _players.where((p) {
      if (_filterTeamApiId != null && p.teamApiId != _filterTeamApiId) return false;
      if (_filterPosition != 'TODOS' && p.position != _filterPosition) return false;
      if (_filterType == 'REAL' && p.isGenerated) return false;
      if (_filterType == 'GENERADO' && (!p.isGenerated || p.isYouth)) return false;
      if (_filterType == 'CANTERA' && !p.isYouth) return false;
      final q = _searchController.text.trim().toLowerCase();
      if (q.isNotEmpty && !p.name.toLowerCase().contains(q)) return false;
      return true;
    }).toList();
  }

  String _teamName(int? apiId) {
    if (apiId == null) return '—';
    try {
      return _teams.firstWhere((t) => t.apiId == apiId).name;
    } catch (_) {
      return 'ID $apiId';
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copiado al portapapeles'),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF1E293B),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '🛠 DEBUG — BASE DE DATOS',
          style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.5),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white54),
            onPressed: _loadData,
            tooltip: 'Recargar',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)))
          : Column(
              children: [
                _buildTabBar(),
                Expanded(
                  child: _activeTab == 'jugadores'
                      ? _buildPlayersTab()
                      : _activeTab == 'equipos'
                          ? _buildTeamsTab()
                          : _buildSaveTab(),
                ),
              ],
            ),
    );
  }

  // ── Tab bar ───────────────────────────────────────────────────────────────

  Widget _buildTabBar() {
    return Container(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _tab('jugadores', 'JUGADORES (${_players.length})'),
          const SizedBox(width: 8),
          _tab('equipos', 'EQUIPOS (${_teams.length})'),
          const SizedBox(width: 8),
          _tab('save', 'PARTIDA'),
        ],
      ),
    );
  }

  Widget _tab(String id, String label) {
    final active = _activeTab == id;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFDEFF9A).withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: active ? const Color(0xFFDEFF9A) : Colors.white12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? const Color(0xFFDEFF9A) : Colors.white38,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ── Tab jugadores ─────────────────────────────────────────────────────────

  Widget _buildPlayersTab() {
    final filtered = _filteredPlayers;
    return Column(
      children: [
        _buildPlayerFilters(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Text(
                '${filtered.length} jugadores',
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  final lines = filtered.map((p) =>
                    'ID:${p.id} | ${p.name} | ${p.position} | ${_teamName(p.teamApiId)} | gen:${p.isGenerated} | youth:${p.isYouth} | media:${p.average.toStringAsFixed(0)}'
                  ).join('\n');
                  _copyToClipboard(lines);
                },
                child: const Text(
                  'COPIAR TODO',
                  style: TextStyle(color: Color(0xFFDEFF9A), fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 1),
            itemBuilder: (context, i) => _buildPlayerRow(filtered[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerFilters() {
    return Container(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Buscador
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Buscar por nombre...',
              hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
              prefixIcon: const Icon(Icons.search, color: Colors.white24, size: 18),
              filled: true,
              fillColor: const Color(0xFF020617),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
          const SizedBox(height: 8),
          // Filtros en fila
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Filtro por equipo
                _filterChip(
                  label: _filterTeamApiId == null ? 'TODOS LOS EQUIPOS' : _teamName(_filterTeamApiId),
                  active: _filterTeamApiId != null,
                  onTap: () => _showTeamPicker(),
                ),
                const SizedBox(width: 8),
                // Filtro por posición
                ...[
                  'TODOS', 'GK', 'DEF', 'MID', 'FWD'
                ].map((pos) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: _filterChip(
                    label: pos,
                    active: _filterPosition == pos,
                    onTap: () => setState(() => _filterPosition = pos),
                  ),
                )),
                const SizedBox(width: 8),
                // Filtro por tipo
                ...[
                  'TODOS', 'REAL', 'GENERADO', 'CANTERA'
                ].map((type) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: _filterChip(
                    label: type,
                    active: _filterType == type,
                    onTap: () => setState(() => _filterType = type),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip({required String label, required bool active, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFDEFF9A).withOpacity(0.15) : const Color(0xFF020617),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: active ? const Color(0xFFDEFF9A) : Colors.white12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? const Color(0xFFDEFF9A) : Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showTeamPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      builder: (_) => ListView(
        children: [
          ListTile(
            title: const Text('TODOS LOS EQUIPOS', style: TextStyle(color: Colors.white70, fontSize: 13)),
            onTap: () {
              setState(() => _filterTeamApiId = null);
              Navigator.pop(context);
            },
          ),
          ..._teams.map((t) => ListTile(
            title: Text(t.name, style: const TextStyle(color: Colors.white, fontSize: 13)),
            subtitle: Text('ID: ${t.apiId}', style: const TextStyle(color: Colors.white38, fontSize: 11)),
            onTap: () {
              setState(() => _filterTeamApiId = t.apiId);
              Navigator.pop(context);
            },
          )),
        ],
      ),
    );
  }

  Widget _buildPlayerRow(Player p) {
    final isGenerated = p.isGenerated;
    final isYouth = p.isYouth;
    Color typeColor = Colors.white54;
    String typeLabel = 'REAL';
    if (isYouth) {
      typeColor = Colors.purple[300]!;
      typeLabel = 'CANTERA';
    } else if (isGenerated) {
      typeColor = Colors.orange[300]!;
      typeLabel = 'GEN';
    }

    return GestureDetector(
      onLongPress: () => _copyToClipboard(
        'ID:${p.id} | ${p.name} | ${p.position} | ${_teamName(p.teamApiId)} | gen:${p.isGenerated} | youth:${p.isYouth} | media:${p.average.toStringAsFixed(0)} | pot:${p.potential} | edad:${p.age}',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            // Tipo badge
            Container(
              width: 52,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: typeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: typeColor.withOpacity(0.4)),
              ),
              child: Text(
                typeLabel,
                style: TextStyle(color: typeColor, fontSize: 9, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 8),
            // Posición
            SizedBox(
              width: 32,
              child: Text(
                p.position,
                style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
            // Nombre
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        p.name,
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      if (p.isUnicorn)
                        const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Text('🌟', style: TextStyle(fontSize: 10)),
                        ),
                    ],
                  ),
                  Text(
                    _teamName(p.teamApiId),
                    style: const TextStyle(color: Colors.white38, fontSize: 10),
                  ),
                ],
              ),
            ),
            // Stats
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Media: ${p.average.toStringAsFixed(0)}',
                  style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 11, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Pot: ${p.potential} · Edad: ${p.age}',
                  style: const TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Tab equipos ───────────────────────────────────────────────────────────

  Widget _buildTeamsTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _teams.length,
      separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 1),
      itemBuilder: (context, i) {
        final t = _teams[i];
        final count = _players.where((p) => p.teamApiId == t.apiId).length;
        final countReal = _players.where((p) => p.teamApiId == t.apiId && !p.isGenerated && !p.isYouth).length;
        final countGen = _players.where((p) => p.teamApiId == t.apiId && p.isGenerated && !p.isYouth).length;
        final countYouth = _players.where((p) => p.teamApiId == t.apiId && p.isYouth).length;
        final isUserTeam = _save?.userTeamApiId == t.apiId;

        return GestureDetector(
          onLongPress: () => _copyToClipboard('ID:${t.apiId} | ${t.name} | ${t.city} | ${t.stadium}'),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (isUserTeam)
                            const Padding(
                              padding: EdgeInsets.only(right: 6),
                              child: Text('⭐', style: TextStyle(fontSize: 12)),
                            ),
                          Text(
                            t.name,
                            style: TextStyle(
                              color: isUserTeam ? const Color(0xFFDEFF9A) : Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'API ID: ${t.apiId} · ${t.city} · ${t.stadium}',
                        style: const TextStyle(color: Colors.white38, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total: $count',
                      style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'R:$countReal G:$countGen C:$countYouth',
                      style: const TextStyle(color: Colors.white38, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Tab partida ───────────────────────────────────────────────────────────

  Widget _buildSaveTab() {
    if (_save == null) {
      return const Center(
        child: Text('No hay partida guardada.', style: TextStyle(color: Colors.white38)),
      );
    }
    final s = _save!;
    final rows = [
      ('userTeamApiId', '${s.userTeamApiId} — ${_teamName(s.userTeamApiId)}'),
      ('currentMatchday', '${s.currentMatchday} / ${s.totalMatchdays}'),
      ('currentDay', '${s.currentDay}'),
      ('seasonNumber', '${s.seasonNumber}'),
      ('seasonFinished', '${s.seasonFinished}'),
      ('financiallyDismissed', '${s.financiallyDismissed}'),
      ('inCup', '${s.inCup}'),
      ('cupRound', '${s.cupRound}'),
      ('boardAcceptance', '${s.boardAcceptance}'),
      ('boardObjectiveMaxPosition', '${s.boardObjectiveMaxPosition}'),
      ('boardObjectiveLabel', s.boardObjectiveLabel),
      ('consecutiveRedWeeks', '${s.consecutiveRedWeeks}'),
      ('lineupGeneratedPlayers', '${s.lineupGeneratedPlayers}'),
      ('lineupTotalPlayers', '${s.lineupTotalPlayers}'),
      ('trainingFocusesUsedToday', s.trainingFocusesUsedToday.isEmpty ? '(ninguno)' : s.trainingFocusesUsedToday.join(', ')),
      ('trophies', s.trophies.isEmpty ? '(ninguno)' : s.trophies.join(', ')),
      ('staffSecretaryName', '${s.staffSecretaryName} (nv.${s.staffSecretaryLevel})'),
      ('staffPreparatorName', '${s.staffPreparatorName} (nv.${s.staffPreparatorLevel})'),
      ('staffMedicoName', '${s.staffMedicoName} (nv.${s.staffMedicoLevel})'),
      ('matchMode', s.matchMode),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GestureDetector(
          onLongPress: () => _copyToClipboard(rows.map((r) => '${r.$1}: ${r.$2}').join('\n')),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white10),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: rows.map((r) => _saveRow(r.$1, r.$2)).toList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Mantén pulsado para copiar todos los datos al portapapeles.',
          style: TextStyle(color: Colors.white24, fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _saveRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              key,
              style: const TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}