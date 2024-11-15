import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/common/widgets/rounded_stick.dart';
import 'package:piece_of_happiness/common/widgets/rounded_triangle.dart';

class LoadingMove extends StatefulWidget {
  const LoadingMove({super.key});

  @override
  State<LoadingMove> createState() => _LoadingMoveState();
}

class _LoadingMoveState extends State<LoadingMove>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2000,
      ))
    ..repeat();

  late final Animation<double> _rotate = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutCirc,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotate,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotate.value * 2 * math.pi,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
              ),
              Positioned(
                bottom: 20,
                left: 5,
                child: Transform.rotate(
                  angle: math.pi / 5,
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width * 0.07, 0),
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
                child: Transform.rotate(
                  angle: math.pi / 12,
                  child: CustomPaint(
                    size: Size(
                      MediaQuery.of(context).size.width * 0.1,
                      (math.sqrt(3) / 2) *
                          MediaQuery.of(context).size.width *
                          0.1,
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
          ),
        );
      },
    );
  }
}
