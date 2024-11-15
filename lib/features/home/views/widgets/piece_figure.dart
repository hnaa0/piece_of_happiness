import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:piece_of_happiness/common/widgets/rounded_stick.dart';
import 'package:piece_of_happiness/common/widgets/rounded_triangle.dart';
import 'package:piece_of_happiness/constants/colors.dart';

class PieceFigure extends StatelessWidget {
  const PieceFigure({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          width: size.width * 0.12,
          height: size.width * 0.12,
        ),
        Positioned(
          left: 5,
          child: Transform.rotate(
            angle: math.pi / 4,
            child: CustomPaint(
              size: Size(size.width * 0.03, 0),
              painter: RoundedStick(
                color: const Color(
                  ThemeColors.coral,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 5,
          bottom: 20,
          child: Transform.rotate(
            angle: math.pi / 12,
            child: CustomPaint(
              size: Size(
                size.width * 0.07,
                (math.sqrt(3) / 2) * size.width * 0.07,
              ),
              painter: RoundedTriangle(
                color: const Color(
                  ThemeColors.blue,
                ),
                radius: 10.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
