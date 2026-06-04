import 'package:flutter/material.dart';
import '../core/database_service.dart';
import '../core/message_service.dart';
import '../models/game_message.dart';

class SecretaryScreen extends StatefulWidget {
  final DatabaseService dbService;

  const SecretaryScreen({super.key, required this.dbService});

  @override
  State<SecretaryScreen> createState() => _SecretaryScreenState();
}

class _SecretaryScreenState extends State<SecretaryScreen> {
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    MessageService(widget.dbService.isar).markAllRead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: const Text("SECRETARÍA", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                _chip('Todos', 'all'),
                _chip('Prensa', 'press'),
                _chip('Presidente', 'board'),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<GameMessage>>(
        stream: widget.dbService.isar.gameMessages.where().watch(fireImmediately: true),
        builder: (context, snap) {
          var msgs = List<GameMessage>.from(snap.data ?? [])
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          if (_filter == 'press') {
            msgs = msgs.where((m) => m.type == MessageType.press).toList();
          } else if (_filter == 'board') {
            msgs = msgs.where((m) => m.type == MessageType.board).toList();
          }
          if (msgs.isEmpty) {
            return const Center(
              child: Text("No hay mensajes.", style: TextStyle(color: Colors.white38)),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: msgs.length,
            itemBuilder: (_, i) {
              final m = msgs[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: m.read ? Colors.white10 : const Color(0xFFDEFF9A).withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(_icon(m.type), color: const Color(0xFFDEFF9A), size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(m.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          "${m.createdAt.day}/${m.createdAt.month}",
                          style: const TextStyle(color: Colors.white24, fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(m.body, style: const TextStyle(color: Colors.white70, height: 1.4)),
                  ],
                ),
              );
            },
          );
        },
      ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, String id) {
    final sel = _filter == id;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(color: sel ? Colors.black : Colors.white70, fontSize: 11)),
        selected: sel,
        selectedColor: const Color(0xFFDEFF9A),
        onSelected: (_) => setState(() => _filter = id),
      ),
    );
  }

  IconData _icon(MessageType t) {
    switch (t) {
      case MessageType.match:
        return Icons.sports_soccer;
      case MessageType.transfer:
        return Icons.handshake;
      case MessageType.training:
        return Icons.fitness_center;
      case MessageType.board:
        return Icons.account_balance;
      case MessageType.general:
        return Icons.mail;
      case MessageType.press:
        return Icons.newspaper;
    }
  }
}
