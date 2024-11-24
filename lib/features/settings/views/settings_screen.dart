import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/authentication/view_models/auth_view_model.dart';
import 'package:piece_of_happiness/features/authentication/views/sign_in_screen.dart';
import 'package:piece_of_happiness/features/home/view_models/fetch_piece_view_model.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';
import 'package:piece_of_happiness/features/user/views/edit_profile_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/settings";
  static const routeName = "settings";

  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeConfigProvider).darkMode;

    return Scaffold(
      backgroundColor: Color(
        isDark ? ThemeColors.grey_900 : ThemeColors.white,
      ),
      appBar: AppBar(
        backgroundColor: Color(
          isDark ? ThemeColors.grey_900 : ThemeColors.white,
        ),
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            context.pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: SvgPicture.asset(
              "assets/icons/angle-left.svg",
              colorFilter: isDark
                  ? const ColorFilter.mode(
                      Color(ThemeColors.white),
                      BlendMode.srcIn,
                    )
                  : null,
            ),
          ),
        ),
        title: Text(
          "설정",
          style: TextStyle(
            fontSize: 14,
            color: Color(
              isDark ? ThemeColors.white : ThemeColors.black,
            ),
          ),
        ),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: Color(
              isDark ? ThemeColors.grey_500 : ThemeColors.lightBlue,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            ListTile(
              leading: SvgPicture.asset(
                "assets/icons/information.svg",
                width: 16,
                height: 16,
                colorFilter: isDark
                    ? const ColorFilter.mode(
                        Color(ThemeColors.white),
                        BlendMode.srcIn,
                      )
                    : null,
              ),
              title: Text(
                "행복조각",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(
                    isDark ? ThemeColors.white : ThemeColors.black,
                  ),
                ),
              ),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "행복조각",
                );
              },
            ),
            Divider(
              color: isDark
                  ? const Color(
                      ThemeColors.grey_800,
                    )
                  : const Color(
                      ThemeColors.grey_200,
                    ),
            ),
            SwitchListTile(
              secondary: SvgPicture.asset(
                "assets/icons/dark-mode.svg",
                width: 16,
                height: 16,
                colorFilter: isDark
                    ? const ColorFilter.mode(
                        Color(ThemeColors.white),
                        BlendMode.srcIn,
                      )
                    : null,
              ),
              title: Text(
                "다크모드",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(
                    isDark ? ThemeColors.white : ThemeColors.black,
                  ),
                ),
              ),
              inactiveThumbColor: const Color(
                ThemeColors.grey_100,
              ),
              inactiveTrackColor: const Color(
                ThemeColors.grey_300,
              ),
              trackOutlineColor: const WidgetStatePropertyAll(
                Colors.transparent,
              ),
              activeColor: const Color(
                ThemeColors.blue,
              ),
              value: ref.watch(themeConfigProvider).darkMode,
              onChanged: (value) {
                ref.read(themeConfigProvider.notifier).setDarkMode(value);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/icons/user-pen.svg",
                width: 16,
                height: 16,
                colorFilter: isDark
                    ? const ColorFilter.mode(
                        Color(ThemeColors.white),
                        BlendMode.srcIn,
                      )
                    : null,
              ),
              title: Text(
                "프로필 수정",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(
                    isDark ? ThemeColors.white : ThemeColors.black,
                  ),
                ),
              ),
              onTap: () {
                context.pushNamed(EditProfileScreen.routeName);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/icons/trash-xmark.svg",
                width: 16,
                height: 16,
                colorFilter: isDark
                    ? const ColorFilter.mode(
                        Color(ThemeColors.white),
                        BlendMode.srcIn,
                      )
                    : null,
              ),
              title: Text(
                "데이터 전체 삭제",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(
                    isDark ? ThemeColors.white : ThemeColors.black,
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: const Color(
                        ThemeColors.white,
                      ),
                      elevation: 0,
                      title: const Text(
                        "저장된 데이터를 모두 삭제하시겠어요?",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      content: const Text(
                        "삭제한 데이터는 복구할 수 없어요.",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.end,
                      actions: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            ref
                                .read(fetchPieceProvider.notifier)
                                .deleteAllPieces()
                                .then(
                              (_) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Color(
                                        ThemeColors.blue,
                                      ),
                                      content: Text(
                                        "데이터가 모두 삭제되었습니다.",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  );
                                  context.pop();
                                }
                              },
                            );
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
            ),
            Divider(
              color: isDark
                  ? const Color(
                      ThemeColors.grey_800,
                    )
                  : const Color(
                      ThemeColors.grey_200,
                    ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/icons/arrow-left-from-arc.svg",
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  Colors.redAccent,
                  BlendMode.srcIn,
                ),
              ),
              title: const Text(
                "로그아웃",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.redAccent,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: const Color(
                        ThemeColors.white,
                      ),
                      elevation: 0,
                      title: const Text(
                        "로그아웃하시겠어요?",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      content: const Text(
                        "로그아웃해도 저장된 데이터는 삭제되지 않습니다.",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.end,
                      actions: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            ref.read(authProvider.notifier).signOut();
                            context.goNamed(SignInScreen.routeName);
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
            ),
          ],
        ),
      ),
    );
  }
}
