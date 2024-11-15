import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';

class DeleteButton extends ConsumerWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeConfigProvider).darkMode;

    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 0.5,
            color: isDark
                ? const Color(
                    ThemeColors.white,
                  )
                : const Color(
                    ThemeColors.grey_700,
                  ),
          ),
          color: const Color(
            ThemeColors.lightBlue,
          ),
        ),
        child: SvgPicture.asset(
          "assets/icons/trash-xmark.svg",
          colorFilter: const ColorFilter.mode(
            Color(
              ThemeColors.grey_800,
            ),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
