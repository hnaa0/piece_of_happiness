import 'package:flutter/material.dart';

class RoundedStick extends CustomPainter {
  final Color color;

  RoundedStick({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    Offset path1 = const Offset(0, 0);
    Offset path2 = Offset(size.width, 0);

    canvas.drawLine(path1, path2, paint);
  }

  @override
  bool shouldRepaint(RoundedStick oldDelegate) {
    return oldDelegate.color != color;
  }
}
