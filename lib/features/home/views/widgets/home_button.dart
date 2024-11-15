import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';

class HomeButton extends ConsumerWidget {
  const HomeButton({
    super.key,
    required this.icon,
  });

  final SvgPicture icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeConfigProvider).darkMode;
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.2,
      height: size.width * 0.2,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(
                ThemeColors.grey_900,
              )
            : const Color(
                ThemeColors.lightBlue,
              ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? const Color(
                    ThemeColors.lightBlue,
                  )
                : const Color(
                    ThemeColors.grey_300,
                  ),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(
          size.width * 0.07,
        ),
        child: icon,
      ),
    );
  }
}
