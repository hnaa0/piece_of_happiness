import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:piece_of_happiness/common/widgets/rounded_stick.dart';
import 'package:piece_of_happiness/common/widgets/rounded_triangle.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';

class PieceEmpty extends ConsumerWidget {
  const PieceEmpty({
    super.key,
    required this.pieceKey,
  });

  final GlobalKey pieceKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeConfigProvider).darkMode;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
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
                  DateFormat("yyyy년 MM월 dd일 EEEE", "ko_KR").format(
                    DateTime.now(),
                  ),
                  style: TextStyle(
                    color: isDark
                        ? const Color(
                            ThemeColors.white,
                          )
                        : const Color(
                            ThemeColors.black,
                          ),
                  ),
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      key: pieceKey,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                        ),
                        Positioned(
                          bottom: 20,
                          left: 5,
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
                        Positioned(
                          right: 5,
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
                        ),
                      ],
                    ),
                    const Gap(10),
                    Text(
                      "저장된 조각이 없어요!",
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? const Color(
                                ThemeColors.white,
                              )
                            : const Color(
                                ThemeColors.black,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
