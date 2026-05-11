import 'dart:math';
import 'package:flutter/material.dart';

class PlayerRadarChartPainter extends CustomPainter {
  final List<int> stats;

  PlayerRadarChartPainter({required this.stats});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const angleStep = (2 * pi) / 5; // 5 estadísticas principales

    // 1. Dibujar el fondo (telaraña)
    final gridPaint = Paint()
      ..color = Colors.white10
      ..style = PaintingStyle.stroke;

    for (var i = 1; i <= 4; i++) {
      canvas.drawCircle(center, radius * (i / 4), gridPaint);
    }

    // 2. Dibujar el polígono del jugador
    final playerPaint = Paint()
      ..color = const Color(0xFFDEFF9A).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFFDEFF9A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    for (var i = 0; i < 5; i++) {
      final statValue = stats[i] / 100.0;
      final x = center.dx + radius * statValue * cos(angleStep * i - pi / 2);
      final y = center.dy + radius * statValue * sin(angleStep * i - pi / 2);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, playerPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}