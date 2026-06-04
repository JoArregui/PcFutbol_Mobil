import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/tactics_service.dart';
import '../models/player_model.dart';

class MatchSubstitutionResult {
  final List<Player> onField;
  final List<Player> bench;
  final String formation;
  final int substitutionsUsed;

  const MatchSubstitutionResult({
    required this.onField,
    required this.bench,
    required this.formation,
    required this.substitutionsUsed,
  });
}

class MatchSubstitutionSheet extends StatefulWidget {
  final List<Player> onField;
  final List<Player> bench;
  final String formation;
  final int substitutionsUsed;
  final int maxSubstitutions;
  final bool isHalftime;
  final String resumeLabel;

  const MatchSubstitutionSheet({
    super.key,
    required this.onField,
    required this.bench,
    required this.formation,
    required this.substitutionsUsed,
    this.maxSubstitutions = 5,
    this.isHalftime = false,
    this.resumeLabel = 'REANUDAR PARTIDO',
  });

  @override
  State<MatchSubstitutionSheet> createState() => _MatchSubstitutionSheetState();
}

class _MatchSubstitutionSheetState extends State<MatchSubstitutionSheet> {
  late List<Player> _onField;
  late List<Player> _bench;
  late String _formation;
  late int _subsUsed;
  int? _outPlayerId;

  @override
  void initState() {
    super.initState();
    _onField = List<Player>.from(widget.onField);
    _bench = List<Player>.from(widget.bench);
    _formation = widget.formation;
    _subsUsed = widget.substitutionsUsed;
  }

  bool get _canSubstitute => _subsUsed < widget.maxSubstitutions;

  void _applySwap(Player benchPlayer) {
    final outId = _outPlayerId;
    if (outId == null || !_canSubstitute) return;

    final outIndex = _onField.indexWhere((p) => p.id == outId);
    final benchIndex = _bench.indexWhere((p) => p.id == benchPlayer.id);
    if (outIndex < 0 || benchIndex < 0) return;

    final outPlayer = _onField[outIndex];
    setState(() {
      _onField[outIndex] = benchPlayer;
      _bench[benchIndex] = outPlayer;
      _subsUsed++;
      _outPlayerId = null;
    });
  }

  void _confirm() {
    Navigator.pop(
      context,
      MatchSubstitutionResult(
        onField: _onField,
        bench: _bench,
        formation: _formation,
        substitutionsUsed: _subsUsed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      height: MediaQuery.of(context).size.height * 0.78,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                widget.isHalftime ? FontAwesomeIcons.mugHot : FontAwesomeIcons.userGear,
                color: const Color(0xFFDEFF9A),
                size: 18,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.isHalftime ? 'DESCANSO — CAMBIOS Y TÁCTICA' : 'ÁREA TÉCNICA / CAMBIOS',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                'Cambios $_subsUsed/${widget.maxSubstitutions}',
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),
          const Divider(color: Colors.white10, height: 20),
          const Text(
            'FORMACIÓN',
            style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: TacticsService.formations.map((f) {
              final sel = _formation == f;
              return ChoiceChip(
                label: Text(
                  f,
                  style: TextStyle(
                    color: sel ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                selected: sel,
                selectedColor: const Color(0xFFDEFF9A),
                backgroundColor: const Color(0xFF1E293B),
                onSelected: (_) => setState(() => _formation = f),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            _outPlayerId == null
                ? 'EN CAMPO (${_onField.length}) — toca quién sale'
                : 'SUPLENTES — elige quién entra',
            style: const TextStyle(color: Color(0xFFDEFF9A), fontSize: 11, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _outPlayerId == null ? _buildOnFieldList() : _buildBenchList(),
          ),
          if (!_canSubstitute)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Has agotado los cambios permitidos.',
                style: TextStyle(color: Colors.amber, fontSize: 11),
              ),
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDEFF9A),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _confirm,
            child: Text(
              widget.resumeLabel,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnFieldList() {
    return ListView.builder(
      itemCount: _onField.length,
      itemBuilder: (_, i) {
        final p = _onField[i];
        final selected = _outPlayerId == p.id;
        return ListTile(
          dense: true,
          enabled: _canSubstitute,
          onTap: _canSubstitute ? () => setState(() => _outPlayerId = p.id) : null,
          leading: CircleAvatar(
            radius: 16,
            backgroundColor: selected ? const Color(0xFFDEFF9A) : const Color(0xFF1E293B),
            child: Text(
              p.position,
              style: TextStyle(
                fontSize: 9,
                color: selected ? Colors.black : Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            p.name,
            style: TextStyle(
              color: selected ? const Color(0xFFDEFF9A) : Colors.white,
              fontSize: 13,
            ),
          ),
          trailing: const Icon(Icons.swap_horiz, color: Colors.white24, size: 18),
        );
      },
    );
  }

  Widget _buildBenchList() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => setState(() => _outPlayerId = null),
            child: const Text('← Volver al once', style: TextStyle(color: Colors.white38)),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _bench.length,
            itemBuilder: (_, i) {
              final p = _bench[i];
              return ListTile(
                dense: true,
                onTap: () => _applySwap(p),
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFF1E293B),
                  child: Text(
                    p.position,
                    style: const TextStyle(fontSize: 9, color: Colors.white54, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(p.name, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                trailing: const Icon(Icons.add_circle_outline, color: Color(0xFFDEFF9A), size: 18),
              );
            },
          ),
        ),
      ],
    );
  }
}
