import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/database_service.dart';
import '../core/transfer_manager_service.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import '../models/finance_model.dart';

class TransferMarketScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const TransferMarketScreen({
    super.key,
    required this.dbService,
    required this.userTeam,
  });

  @override
  State<TransferMarketScreen> createState() => _TransferMarketScreenState();
}

class _TransferMarketScreenState extends State<TransferMarketScreen> {
  late final TransferManagerService _transferManager;
  List<Player> _availablePlayers = [];
  List<Player> _ourPlayers = [];
  List<Player> _recommendations = [];
  ClubFinance? _finance;
  bool _loading = true;
  String _selectedPosition = 'ALL';
  final double _maxPrice = 100000000;
  final int _minRating = 0;
  String _activeTab = 'search';

  final positions = ['ALL', 'GK', 'DEF', 'MID', 'FWD'];

  @override
  void initState() {
    super.initState();
    _transferManager = TransferManagerService(widget.dbService.isar);
    _loadData();
  }

  Future<void> _loadData() async {
    _finance = await widget.dbService.isar.clubFinances.get(1);
    final allPlayers = await widget.dbService.getAllPlayers();
    final ourPlayersList = allPlayers.where((p) =>
        p.teamApiId == widget.userTeam.apiId && p.isYouth == false).toList();
    _ourPlayers = ourPlayersList;
    _recommendations = await _transferManager.getTransferRecommendations(widget.userTeam.apiId);
    await _filterPlayers();

    if (mounted) setState(() => _loading = false);
  }

  Future<void> _filterPlayers() async {
    final pos = _selectedPosition == 'ALL' ? null : _selectedPosition;
    _availablePlayers = await _transferManager.getAvailablePlayers(
      widget.userTeam.apiId,
      position: pos,
      maxPrice: _maxPrice,
      minRating: _minRating,
    );

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text(
          'MERCADO DE FICHAJES',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _loadData,
            icon: const Icon(Icons.refresh, color: Color(0xFFDEFF9A)),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A)))
          : Column(
              children: [
                _budgetBar(),
                _tabs(),
                Expanded(
                  child: _activeTab == 'search'
                      ? _searchPanel()
                      : _activeTab == 'recommendations'
                          ? _recommendationsPanel()
                          : _ourPlayersPanel(),
                ),
              ],
            ),
    );
  }

  Widget _budgetBar() {
    if (_finance == null) return const SizedBox.shrink();

    final totalBudget = _finance!.balance + _finance!.transferBudget;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
      ),
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.wallet, color: Color(0xFFDEFF9A), size: 16),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('PRESUPUESTO', style: TextStyle(color: Colors.white54, fontSize: 10)),
              Text(
                '${(totalBudget / 1e6).toStringAsFixed(2)} M€',
                style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('MASA SALARIAL', style: TextStyle(color: Colors.white54, fontSize: 10)),
              Text(
                '${(_finance!.wageBill / 1e6).toStringAsFixed(2)} M€',
                style: TextStyle(
                  color: _finance!.wageBill > _finance!.maxWageBill * 0.9 ? Colors.redAccent : Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
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
          _tabChip('BUSCAR', 'search'),
          const SizedBox(width: 6),
          _tabChip('RECOMENDADOS', 'recommendations'),
          const SizedBox(width: 6),
          _tabChip('MIS JUGADORES', 'ours'),
        ],
      ),
    );
  }

  Widget _tabChip(String label, String id) {
    final selected = _activeTab == id;
    return Expanded(
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.black : Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
        selected: selected,
        selectedColor: const Color(0xFFDEFF9A),
        onSelected: (_) => setState(() => _activeTab = id),
      ),
    );
  }

  // === PANEL DE BÚSQUEDA ===

  Widget _searchPanel() {
    return Column(
      children: [
        _filters(),
        Expanded(
          child: _availablePlayers.isEmpty
              ? const Center(child: Text('No se encontraron jugadores con esos filtros.', style: TextStyle(color: Colors.white38)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _availablePlayers.length,
                  itemBuilder: (_, i) => _playerCard(_availablePlayers[i], isOurPlayer: false),
                ),
        ),
      ],
    );
  }

  Widget _filters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF0F172A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('POSICIÓN', style: TextStyle(color: Colors.white54, fontSize: 10)),
                    const SizedBox(height: 4),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: positions.map((p) {
                          final selected = _selectedPosition == p;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: FilterChip(
                              label: Text(p, style: TextStyle(color: selected ? Colors.black : Colors.white, fontSize: 11)),
                              selected: selected,
                              selectedColor: const Color(0xFFDEFF9A),
                              onSelected: (_) {
                                _selectedPosition = p;
                                _filterPlayers();
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // === PANEL DE RECOMENDACIONES ===

  Widget _recommendationsPanel() {
    if (_recommendations.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No hay recomendaciones disponibles en este momento.', style: TextStyle(color: Colors.white38)),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _recommendations.length,
      itemBuilder: (_, i) => _playerCard(_recommendations[i], isOurPlayer: false, isRecommendation: true),
    );
  }

  // === PANEL DE NUESTROS JUGADORES ===

  Widget _ourPlayersPanel() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _ourPlayers.length,
      itemBuilder: (_, i) => _playerCard(_ourPlayers[i], isOurPlayer: true),
    );
  }

  // === TARJETA DE JUGADOR ===

  Widget _playerCard(Player player, {required bool isOurPlayer, bool isRecommendation = false}) {
    final budget = (_finance?.balance ?? 0) + (_finance?.transferBudget ?? 0);
    final canAfford = player.marketValue <= budget;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isRecommendation ? Colors.purpleAccent.withValues(alpha: 0.4) : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (player.isUnicorn) ...[
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 6),
              ],
              Expanded(
                child: Text(player.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(player.position, style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('${player.age} años', style: const TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getRatingColor(player.average).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(player.average.toStringAsFixed(0), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              const Spacer(),
              Text(
                '${(player.marketValue / 1e6).toStringAsFixed(2)} M€',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _statRow(player),
          const SizedBox(height: 16),
          if (isOurPlayer)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white38)),
                    onPressed: () => _showSellOptions(player),
                    icon: const Icon(FontAwesomeIcons.handshake, size: 14),
                    label: const Text('VENDER / PRESTAR', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white38)),
                    onPressed: () => _showLoanOption(player),
                    icon: const Icon(FontAwesomeIcons.handshake, size: 14),
                    label: const Text('PRESTAMO', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: canAfford ? const Color(0xFFDEFF9A) : Colors.grey[700],
                      foregroundColor: Colors.black,
                    ),
                    onPressed: canAfford ? () => _showBuyOptions(player) : null,
                    icon: const Icon(Icons.add, size: 14),
                    label: const Text('FICHAR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _statRow(Player player) {
    final stats = [
      ('VEL', player.stats[0]),
      ('TIR', player.stats[1]),
      ('PAS', player.stats[2]),
      ('DEF', player.stats[3]),
      ('FIS', player.stats[4]),
    ];

    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Column(
            children: [
              Text(stat.$1, style: const TextStyle(color: Colors.white38, fontSize: 10)),
              const SizedBox(height: 2),
              Container(
                width: 36,
                height: 20,
                decoration: BoxDecoration(
                  color: _getStatColor(stat.$2).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(child: Text(stat.$2.toStringAsFixed(0), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 85) return Colors.greenAccent;
    if (rating >= 75) return Colors.lightGreenAccent;
    if (rating >= 65) return Colors.amber;
    return Colors.redAccent;
  }

  Color _getStatColor(int stat) {
    if (stat >= 85) return Colors.greenAccent;
    if (stat >= 70) return Colors.lightGreenAccent;
    if (stat >= 55) return Colors.amber;
    return Colors.redAccent;
  }

  // === ACCIONES ===

  Future<void> _showBuyOptions(Player player) async {
    final allTeams = await widget.dbService.getAllTeams();
    final teams = allTeams.where((t) => t.apiId == player.teamApiId).toList();
    if (teams.isEmpty || !mounted) return;
    final team = teams.first;

    // Obtener presupuesto
    final finances = await widget.dbService.isar.clubFinances.get(1);
    final budget = (finances?.balance ?? 0) + (finances?.transferBudget ?? 0);

    await showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => _BuyOptionSheet(
        player: player,
        team: team,
        budget: budget,
        onConfirm: (amount, {includeBuyback = false, sellOn = 0}) async {
          final result = await _transferManager.makeOfferForPlayer(
            player,
            team,
            amount,
            includeBuyback: includeBuyback,
            buybackAmount: amount * 1.3,
            sellOnPercentage: sellOn,
          );
          if (mounted) {
            Navigator.pop(ctx);
            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(result)));
          }
        },
      ),
    );
  }

  Future<void> _showSellOptions(Player player) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => _SellOptionSheet(
        player: player,
      ),
    );
  }

  Future<void> _showLoanOption(Player player) async {
    final allTeams = await widget.dbService.getAllTeams();
    final teams = allTeams.where((t) => t.apiId == player.teamApiId).toList();
    if (teams.isEmpty || !mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de préstamos disponible próximamente!')),
    );
  }
}

// === HOJAS DE OPCIONES ===

class _BuyOptionSheet extends StatefulWidget {
  final Player player;
  final Team team;
  final double budget;
  final Function(double, {bool includeBuyback, double sellOn}) onConfirm;

  const _BuyOptionSheet({
    required this.player,
    required this.team,
    required this.budget,
    required this.onConfirm,
  });

  @override
  State<_BuyOptionSheet> createState() => _BuyOptionSheetState();
}

class _BuyOptionSheetState extends State<_BuyOptionSheet> {
  double _offerAmount = 0;
  bool _includeBuyback = false;
  double _sellOnPercentage = 0;

  @override
  void initState() {
    super.initState();
    _offerAmount = widget.player.marketValue;
  }

  @override
  Widget build(BuildContext context) {
    final maxOffer = widget.player.marketValue * 1.5;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OFERTAR POR ${widget.player.name.toUpperCase()}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            widget.team.name,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 24),
          const Text('CANTIDAD OFERTADA', style: TextStyle(color: Colors.white54, fontSize: 11)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _offerAmount,
                  min: widget.player.marketValue * 0.7,
                  max: maxOffer,
                  divisions: 16,
                  activeColor: const Color(0xFFDEFF9A),
                  onChanged: (v) => setState(() => _offerAmount = v),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(_offerAmount / 1e6).toStringAsFixed(2)} M€',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Cláusula de recompra', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Podrás recomprarlo en el futuro', style: TextStyle(color: Colors.white54, fontSize: 11)),
            value: _includeBuyback,
            activeColor: const Color(0xFFDEFF9A),
            onChanged: (v) => setState(() => _includeBuyback = v),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Porcentaje de venta futura: ', style: TextStyle(color: Colors.white)),
              Slider(
                value: _sellOnPercentage,
                min: 0,
                max: 50,
                divisions: 10,
                activeColor: const Color(0xFFDEFF9A),
                onChanged: (v) => setState(() => _sellOnPercentage = v),
              ),
              Text('${_sellOnPercentage.toStringAsFixed(0)}%', style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDEFF9A),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: () => widget.onConfirm(
              _offerAmount,
              includeBuyback: _includeBuyback,
              sellOn: _sellOnPercentage,
            ),
            icon: const Icon(Icons.send),
            label: const Text('ENVIAR OFERTA', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _SellOptionSheet extends StatelessWidget {
  final Player player;

  const _SellOptionSheet({required this.player});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GESTIONAR A ${player.name.toUpperCase()}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(FontAwesomeIcons.handshake, color: Color(0xFFDEFF9A)),
            title: const Text('Poner en lista de transferencias', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Los clubes podrán hacerte ofertas', style: TextStyle(color: Colors.white54)),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Jugador añadido a la lista!')));
            },
          ),
          const Divider(color: Colors.white10),
          ListTile(
            leading: const Icon(FontAwesomeIcons.plane, color: Colors.lightBlue),
            title: const Text('Ofrecer préstamo', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Cederlo temporalmente a otro club', style: TextStyle(color: Colors.white54)),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Función disponible próximamente!')));
            },
          ),
        ],
      ),
    );
  }
}
