import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../models/team.dart';
import '../screens/lineup_screen.dart';
import 'database_service.dart';
import 'lineup_service.dart';

/// Comprueba el 11 titular antes de un partido; si falta, avisa y abre Alineación.
class LineupGuard {
  LineupGuard._();

  static Future<bool> ensureBeforeMatch({
    required BuildContext context,
    required Isar isar,
    required Team userTeam,
  }) async {
    final lineup = LineupService(isar);
    if (await lineup.hasValidLineup(userTeam.apiId)) return true;
    if (!context.mounted) return false;

    final goLineup = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'RECORDATORIO',
          style: TextStyle(
            color: Color(0xFFDEFF9A),
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
        ),
        content: const Text(
          'Debes convocar 11 titulares (con portero) y 7 suplentes antes de jugar.\n\n'
          'Guarda la alineación completa en el menú Alineación.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'IR A ALINEACIÓN',
              style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    if (goLineup != true || !context.mounted) return false;

    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => LineupScreen(
          dbService: DatabaseService.connected(isar),
          userTeam: userTeam,
          fromMatchDay: true,
        ),
      ),
    );

    if (saved == true) return true;
    return lineup.hasValidLineup(userTeam.apiId);
  }
}
