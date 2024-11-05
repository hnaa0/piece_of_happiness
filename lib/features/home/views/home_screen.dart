import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/home/views/add_bottomsheet_screen.dart';
import 'package:piece_of_happiness/features/home/views/widgets/home_button.dart';
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
                    onTap: () {},
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
