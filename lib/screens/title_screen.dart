import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../core/game_session_service.dart';
import '../core/responsive.dart';
import 'team_selection_screen.dart';
import 'main_menu_screen.dart';

class TitleScreen extends StatefulWidget {
  final DatabaseService dbService;

  const TitleScreen({super.key, required this.dbService});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  bool _loading = true;
  bool _canContinue = false;

  @override
  void initState() {
    super.initState();
    _checkSave();
  }

  Future<void> _checkSave() async {
    final session = GameSessionService(widget.dbService.isar);
    final can = await session.hasAnySave();
    if (mounted) {
      setState(() {
        _canContinue = can;
        _loading = false;
      });
    }
  }

  Future<void> _continueGame() async {
    final session = GameSessionService(widget.dbService.isar);
    final team = await session.getUserTeam();
    if (team == null || !mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MainMenuScreen(dbService: widget.dbService, userTeam: team),
      ),
    );
  }

  Future<void> _newGame() async {
  if (!mounted) return;
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => TeamSelectionScreen(dbService: widget.dbService),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFF020617),
        body: Center(child: CircularProgressIndicator(color: Color(0xFFDEFF9A))),
      );
    }

    final titleSize = Responsive.value<double>(context, 38, 56, 72);
    final hPad = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth(context)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    "PC FÚTBOL",
                    style: TextStyle(
                      color: const Color(0xFFDEFF9A),
                      fontSize: titleSize,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                  const Text(
                    "2026 EDITION",
                    style: TextStyle(color: Colors.white38, letterSpacing: 6, fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Homenaje al simulador de gestión más legendario",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white24, fontSize: 12),
                  ),
                  const Spacer(),
                  if (_canContinue) ...[
                    _btn("CONTINUAR", true, _continueGame),
                    const SizedBox(height: 16),
                  ],
                  _btn("NUEVA PARTIDA", !_canContinue, _newGame),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _btn(String label, bool primary, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? const Color(0xFFDEFF9A) : const Color(0xFF0F172A),
          foregroundColor: primary ? Colors.black : Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: primary ? Colors.transparent : Colors.white12),
          ),
        ),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5)),
      ),
    );
  }
}