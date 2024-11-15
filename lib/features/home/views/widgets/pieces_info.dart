import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:piece_of_happiness/common/widgets/rounded_stick.dart';
import 'package:piece_of_happiness/common/widgets/rounded_triangle.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/home/view_models/fetch_piece_view_model.dart';

class PiecesInfo extends ConsumerWidget {
  const PiecesInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fetchPieceProvider).when(
          data: (data) {
            return data.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
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
                                    MediaQuery.of(context).size.width * 0.04,
                                    0),
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
                      const Text(
                        "저장된 조각이 없어요!",
                      ),
                      Gap(MediaQuery.of(context).size.height * 0.1),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${data.length}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(MediaQuery.of(context).size.height * 0.2),
                      ],
                    ),
                  );
          },
          error: (error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "데이터를 가져오지 못했습니다.",
                  style: TextStyle(
                    color: Color(
                      ThemeColors.grey_700,
                    ),
                  ),
                ),
                const Text(
                  "잠시 후 다시 시도해주세요.",
                  style: TextStyle(
                    color: Color(
                      ThemeColors.grey_700,
                    ),
                  ),
                ),
                Gap(MediaQuery.of(context).size.height * 0.2),
              ],
            );
          },
          loading: () => LoadingAnimationWidget.twistingDots(
            leftDotColor: const Color(ThemeColors.lightBlue),
            rightDotColor: const Color(ThemeColors.blue),
            size: 20,
          ),
        );
  }
}
