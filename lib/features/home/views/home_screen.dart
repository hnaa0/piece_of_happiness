import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/home/view_models/fetch_piece_view_model.dart';
import 'package:piece_of_happiness/features/home/views/add_bottomsheet_screen.dart';
import 'package:piece_of_happiness/features/home/views/widgets/home_button.dart';
import 'package:piece_of_happiness/features/home/views/widgets/loading_move.dart';
import 'package:piece_of_happiness/features/home/views/widgets/piece_dialog.dart';
import 'package:piece_of_happiness/features/home/views/widgets/piece_empty.dart';
import 'package:piece_of_happiness/features/home/views/widgets/piece_not_empty.dart';
import 'package:piece_of_happiness/features/home/views/widgets/tutorial_targets.dart';
import 'package:piece_of_happiness/features/home/views/widgets/wavy_app_bar.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/home";
  static const routeName = "home";

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey _profileKey = GlobalKey();
  final GlobalKey _settingsKey = GlobalKey();
  final GlobalKey _pieceKey = GlobalKey();
  final GlobalKey _addKey = GlobalKey();
  final GlobalKey _pickKey = GlobalKey();
  final GlobalKey _lightbulbKey = GlobalKey();

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

  TutorialCoachMark _onLightbulbTap(bool isDark) {
    return TutorialCoachMark(
      colorShadow: isDark
          ? const Color(
              ThemeColors.black,
            )
          : const Color(
              ThemeColors.grey_900,
            ),
      opacityShadow: isDark ? 0.6 : 0.8,
      targets: tutorialTargets(
        context: context,
        profileKey: _profileKey,
        settingsKey: _settingsKey,
        pieceKey: _pieceKey,
        addKey: _addKey,
        pickKey: _pickKey,
        lightbulbKey: _lightbulbKey,
      ),
    )..show(context: context);
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko_KR', null);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeConfigProvider).darkMode;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(
        isDark ? ThemeColors.grey_900 : ThemeColors.white,
      ),
      appBar: WavyAppBar(
        profileKey: _profileKey,
        settingsKey: _settingsKey,
      ),
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
                      ? PieceEmpty(pieceKey: _pieceKey)
                      : PieceNotEmpty(
                          dataLength: dataLength, pieceKey: _pieceKey);
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
            right: size.width * 0.05,
            bottom: size.width * 0.08,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  key: _addKey,
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
                  key: _pickKey,
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
          Positioned(
            left: size.width * 0.05,
            bottom: size.width * 0.08,
            child: GestureDetector(
              key: _lightbulbKey,
              onTap: () => _onLightbulbTap(isDark),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: size.width * 0.1,
                height: size.width * 0.1,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(
                          ThemeColors.grey_900,
                        )
                      : const Color(
                          ThemeColors.white,
                        ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? const Color(
                            ThemeColors.lightBlue,
                          )
                        : const Color(
                            ThemeColors.grey_300,
                          ),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/lightbulb-question.svg",
                  colorFilter: ColorFilter.mode(
                    isDark
                        ? const Color(
                            ThemeColors.lightBlue,
                          )
                        : const Color(
                            ThemeColors.black,
                          ),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
