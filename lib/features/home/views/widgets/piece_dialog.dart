import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/home/models/piece_type.dart';
import 'package:piece_of_happiness/features/home/view_models/fetch_piece_view_model.dart';
import 'package:piece_of_happiness/features/home/views/widgets/delete_button.dart';
import 'package:piece_of_happiness/features/home/views/widgets/piece_figure.dart';
import 'package:piece_of_happiness/features/home/views/widgets/piece_tag.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';

class PieceDialog extends ConsumerStatefulWidget {
  const PieceDialog({super.key});

  @override
  ConsumerState<PieceDialog> createState() => _PieceDialogState();
}

class _PieceDialogState extends ConsumerState<PieceDialog> {
  Future<void> _onDeleteTap(String id, String imagePath) async {
    context.pop();
    Navigator.pop(context);
    ref.read(fetchPieceProvider.notifier).deletePiece(id, imagePath);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pieceValue = ref.watch(fetchPieceProvider);
    final isDark = ref.watch(themeConfigProvider).darkMode;

    return Dialog(
      backgroundColor: isDark
          ? const Color(
              ThemeColors.grey_900,
            )
          : const Color(
              ThemeColors.grey_100,
            ),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        width: size.width,
        height: size.height * 0.65,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(size.width * 0.02),
              const PieceFigure(),
              Gap(size.width * 0.02),
              pieceValue.when(
                data: (pieces) {
                  if (pieces.isEmpty) {
                    return Container();
                  }
                  final randomPiece = pieces[Random().nextInt(pieces.length)];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const PieceTag(
                              type: PieceType.date,
                            ),
                            const Gap(8),
                            Expanded(
                              child: Text(
                                DateFormat("yyyy년 MM월 dd일 hh시 mm분", "ko_KR")
                                    .format(randomPiece.date),
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
                            ),
                          ],
                        ),
                        if (randomPiece.imageUrl.isNotEmpty) ...[
                          const Gap(20),
                          const PieceTag(
                            type: PieceType.image,
                          ),
                          const Gap(8),
                          Container(
                            alignment: Alignment.center,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDark
                                    ? const Color(
                                        ThemeColors.lightBlue,
                                      )
                                    : const Color(
                                        ThemeColors.grey_900,
                                      ),
                              ),
                            ),
                            child: Image.network(
                              randomPiece.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                        const Gap(20),
                        const PieceTag(
                          type: PieceType.text,
                        ),
                        const Gap(8),
                        Text(
                          randomPiece.text,
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
                        Gap(
                          size.width * 0.15,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  elevation: 0,
                                  backgroundColor: const Color(
                                    ThemeColors.white,
                                  ),
                                  title: const Text(
                                    "이 조각을 삭제하시겠어요?",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  content: const Text(
                                    "삭제한 조각은 복구할 수 없어요.",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  actionsAlignment: MainAxisAlignment.end,
                                  actions: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        _onDeleteTap(randomPiece.id,
                                            randomPiece.imageUrl);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 10,
                                        ),
                                        child: const Text(
                                          "네",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        context.pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 10,
                                        ),
                                        child: const Text(
                                          "아니요",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const DeleteButton(),
                        ),
                        const Gap(10),
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) => const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "데이터를 가져오지 못했습니다.",
                      style: TextStyle(
                        color: Color(
                          ThemeColors.grey_700,
                        ),
                      ),
                    ),
                    Text(
                      "잠시 후 다시 시도해주세요.",
                      style: TextStyle(
                        color: Color(
                          ThemeColors.grey_700,
                        ),
                      ),
                    ),
                  ],
                ),
                loading: () => LoadingAnimationWidget.twistingDots(
                  leftDotColor: const Color(ThemeColors.lightBlue),
                  rightDotColor: const Color(ThemeColors.blue),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
