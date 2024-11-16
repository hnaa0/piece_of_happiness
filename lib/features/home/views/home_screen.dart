import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/home/view_models/fetch_piece_view_model.dart';
import 'package:piece_of_happiness/features/home/views/add_bottomsheet_screen.dart';
import 'package:piece_of_happiness/features/home/views/widgets/home_button.dart';
import 'package:piece_of_happiness/features/home/views/widgets/loading_move.dart';
import 'package:piece_of_happiness/features/home/views/widgets/piece_dialog.dart';
import 'package:piece_of_happiness/features/home/views/widgets/piece_empty.dart';
import 'package:piece_of_happiness/features/home/views/widgets/piece_not_empty.dart';
import 'package:piece_of_happiness/features/home/views/widgets/wavy_app_bar.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/home";
  static const routeName = "home";

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _onAddTap(bool isDark) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      elevation: 0,
      context: context,
      builder: (context) {
        return const AddBottomsheetScreen();
      },
      backgroundColor: isDark
          ? const Color(
              ThemeColors.grey_900,
            )
          : const Color(
              ThemeColors.grey_100,
            ),
    );
  }

  void _onPickTap() {
    if (ref.watch(fetchPieceProvider).value!.isEmpty) return;

    final size = MediaQuery.of(context).size;
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  color: const Color(ThemeColors.black).withOpacity(0.15),
                  width: size.width,
                  height: size.height,
                ),
                Positioned(
                  top: size.height / 2 -
                      (MediaQuery.of(context).size.width * 0.2) / 2,
                  left: size.width / 2 -
                      (MediaQuery.of(context).size.width * 0.2) / 2,
                  child: const LoadingMove(),
                ),
              ],
            ),
          ],
        );
      },
    );
    overlay.insert(overlayEntry);
    Future.delayed(
      const Duration(
        milliseconds: 3800,
      ),
      () {
        overlayEntry.remove();
        if (mounted) {
          showDialog(
            barrierColor: const Color(ThemeColors.black).withOpacity(0.1),
            context: context,
            builder: (context) {
              return const PieceDialog();
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeConfigProvider).darkMode;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(
        isDark ? ThemeColors.grey_900 : ThemeColors.white,
      ),
      appBar: const WavyAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: SizedBox(
              height: size.height,
              width: size.width,
            ),
          ),
          ref.watch(fetchPieceProvider).when(
                data: (data) {
                  final dataLength = data.length;

                  return data.isEmpty
                      ? const PieceEmpty()
                      : PieceNotEmpty(dataLength: dataLength);
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
              ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(
                right: size.width * 0.05,
                bottom: size.width * 0.08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => _onAddTap(isDark),
                    child: HomeButton(
                      icon: SvgPicture.asset(
                        "assets/icons/add.svg",
                        colorFilter: ColorFilter.mode(
                          isDark
                              ? const Color(
                                  ThemeColors.lightBlue,
                                )
                              : const Color(
                                  ThemeColors.grey_800,
                                ),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Gap(size.width * 0.05),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _onPickTap,
                    child: HomeButton(
                      icon: SvgPicture.asset(
                        "assets/icons/picking.svg",
                        colorFilter: ColorFilter.mode(
                          isDark
                              ? const Color(
                                  ThemeColors.lightBlue,
                                )
                              : const Color(
                                  ThemeColors.grey_800,
                                ),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
