import 'package:flutter/material.dart';

class TransferNegotiationScreen extends StatefulWidget {
  const TransferNegotiationScreen({super.key});

  @override
  _TransferNegotiationScreenState createState() => _TransferNegotiationScreenState();
}

class _TransferNegotiationScreenState extends State<TransferNegotiationScreen> {
  double currentOffer = 1000000;
  double agentPatience = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: SafeArea(
        child: Column(
          children: [
            _buildAgentHeader(),
            Expanded(child: _buildNegotiationArea()),
            _buildOfferControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("NEGOCIACIÓN EN CURSO", style: TextStyle(color: Color(0xFFDEFF9A), letterSpacing: 2)),
          LinearProgressIndicator(
            value: agentPatience,
            backgroundColor: Colors.white10,
            color: agentPatience > 0.3 ? const Color(0xFFDEFF9A) : Colors.red,
          ),
          const Text("Paciencia del Agente", style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildNegotiationArea() {
    return Center(
      child: Image.network("https://example.com/agent_avatar.png", height: 300), // Sustituir por asset
    );
  }

  Widget _buildOfferControls() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(color: Color(0xFF0F172A), borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        children: [
          Text("${currentOffer.toInt()} € / año", style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
          Slider(
            value: currentOffer,
            min: 500000,
            max: 5000000,
            onChanged: (val) => setState(() => currentOffer = val),
            activeColor: const Color(0xFFDEFF9A),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDEFF9A), foregroundColor: Colors.black),
            onPressed: () { /* Lógica de motor de fichajes */ },
            child: const Text("ENVIAR OFERTA"),
          )
        ],
      ),
    );
  }
}