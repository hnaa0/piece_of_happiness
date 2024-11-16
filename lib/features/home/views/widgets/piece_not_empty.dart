import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:piece_of_happiness/common/widgets/rounded_stick.dart';
import 'package:piece_of_happiness/common/widgets/rounded_triangle.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';

class PieceNotEmpty extends ConsumerStatefulWidget {
  const PieceNotEmpty({
    super.key,
    required this.dataLength,
    required this.pieceKey,
  });

  final int dataLength;
  final GlobalKey pieceKey;

  @override
  ConsumerState<PieceNotEmpty> createState() => _PieceNotEmptyState();
}

class _PieceNotEmptyState extends ConsumerState<PieceNotEmpty>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 1800,
    ),
    reverseDuration: const Duration(
      milliseconds: 1800,
    ),
  )..repeat(
      reverse: true,
    );

  late final Animation<double> _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutCubic,
    reverseCurve: Curves.easeInOutCubic,
  );

  late final Animation<double> _rotate = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_curve);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeConfigProvider).darkMode;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(
                    ThemeColors.blue,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "TODAY",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(
                      ThemeColors.white,
                    ),
                  ),
                ),
              ),
              const Gap(8),
              Text(
                DateFormat("yyyy년 MM월 dd일").format(
                  DateTime.now(),
                ),
              ),
            ],
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                key: widget.pieceKey,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                  AnimatedBuilder(
                    animation: _rotate,
                    builder: (context, child) {
                      return Positioned(
                        bottom: 20,
                        left: 5,
                        child: Transform.rotate(
                          angle: _rotate.value * 0.5 * math.pi,
                          child: Transform.rotate(
                            angle: math.pi / 5,
                            child: CustomPaint(
                              size: Size(
                                  MediaQuery.of(context).size.width * 0.04, 0),
                              painter: RoundedStick(
                                color: const Color(
                                  ThemeColors.coral,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 5,
                    child: AnimatedBuilder(
                      animation: _rotate,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotate.value * -0.5 * math.pi,
                          child: Transform.rotate(
                            angle: math.pi / 12,
                            child: CustomPaint(
                              size: Size(
                                MediaQuery.of(context).size.width * 0.08,
                                (math.sqrt(3) / 2) *
                                    MediaQuery.of(context).size.width *
                                    0.08,
                              ),
                              painter: RoundedTriangle(
                                color: const Color(
                                  ThemeColors.blue,
                                ),
                                radius: 10.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${widget.dataLength}",
                        style: TextStyle(
                          fontSize: 40,
                          color: isDark
                              ? const Color(
                                  ThemeColors.white,
                                )
                              : const Color(
                                  ThemeColors.grey_900,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(size.width * 0.2),
        ],
      ),
    );
  }
}
