import 'package:flutter/material.dart';
import 'dart:math' as math;

class RoundedTriangle extends CustomPainter {
  final Color color;
  final double radius;

  RoundedTriangle({
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // 꼭지점
    final pointA = Offset(size.width / 2, 0); // 맨위
    final pointB = Offset(0, size.height); // 왼쪽
    final pointC = Offset(size.width, size.height); // 왼쪽

    // 변 길이
    final sideAB = (pointA - pointB).distance; // a-b 길이
    final sideAC = (pointC - pointA).distance; // a-c 길이
    final sideBC = (pointC - pointB).distance; // b-c 길이

    final calcRadius =
        math.min(radius, math.min(sideAB, math.min(sideBC, sideAC)) / 2);

    // 각 변에 대한 단위 벡터 계산
    final vectorAB = (pointB - pointA) / sideAB;
    final vectorBA = (pointA - pointB) / sideAB;

    final vectorBC = (pointC - pointB) / sideBC;
    final vectorCB = (pointB - pointC) / sideBC;

    final vectorCA = (pointA - pointC) / sideAC;
    final vectorAC = (pointC - pointA) / sideAC;

    // 꼭지점에서 반지름만큼 떨어진 지점 계산
    final offsetA1 = pointA + vectorAB.scale(calcRadius, calcRadius);
    final offsetA2 = pointA + vectorAC.scale(calcRadius, calcRadius);

    final offsetB1 = pointB + vectorBA.scale(calcRadius, calcRadius);
    final offsetB2 = pointB + vectorBC.scale(calcRadius, calcRadius);

    final offsetC1 = pointC + vectorCB.scale(calcRadius, calcRadius);
    final offsetC2 = pointC + vectorCA.scale(calcRadius, calcRadius);

    path.moveTo(offsetA1.dx, offsetA1.dy);

    path.lineTo(offsetB1.dx, offsetB1.dy);
    path.quadraticBezierTo(pointB.dx, pointB.dy, offsetB2.dx, offsetB2.dy);

    path.lineTo(offsetC1.dx, offsetC1.dy);
    path.quadraticBezierTo(pointC.dx, pointC.dy, offsetC2.dx, offsetC2.dy);

    path.lineTo(offsetA2.dx, offsetA2.dy);
    path.quadraticBezierTo(pointA.dx, pointA.dy, offsetA1.dx, offsetA1.dy);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(RoundedTriangle oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
