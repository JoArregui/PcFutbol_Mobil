import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../core/international_scout_service.dart';
import '../models/team.dart';

class InternationalScoutScreen extends StatefulWidget {
  final DatabaseService dbService;
  final Team userTeam;

  const InternationalScoutScreen({super.key, required this.dbService, required this.userTeam});

  @override
  State<InternationalScoutScreen> createState() => _InternationalScoutScreenState();
}

class _InternationalScoutScreenState extends State<InternationalScoutScreen> {
  String? _lastResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text('OJEADOR INTERNACIONAL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Envía un informe a Brasil, Argentina, Francia… Los jugadores detectados aparecen en el mercado para negociar.',
              style: TextStyle(color: Colors.white54, height: 1.4),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDEFF9A),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 56),
              ),
              onPressed: () async {
                final msg = await InternationalScoutService(widget.dbService.isar)
                    .runScoutMission(widget.userTeam.apiId);
                setState(() => _lastResult = msg);
              },
              child: const Text('INFORME (350.000 €)', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
            if (_lastResult != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(_lastResult!, style: const TextStyle(color: Color(0xFFDEFF9A))),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
