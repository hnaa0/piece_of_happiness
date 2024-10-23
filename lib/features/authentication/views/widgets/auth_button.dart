import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/authentication/view_models/auth_view_model.dart';

class AuthButton extends ConsumerWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.authFunc,
  });

  final String text;
  final Function authFunc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => authFunc(),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        constraints: const BoxConstraints(
          maxHeight: 52,
          minHeight: 52,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(
            ThemeColors.white,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(
                ThemeColors.grey_300,
              ),
              blurRadius: 5,
            ),
          ],
        ),
        child: ref.watch(authProvider).isLoading
            ? LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(ThemeColors.lightBlue),
                rightDotColor: const Color(ThemeColors.blue),
                size: 20,
              )
            : Text(
                text,
              ),
      ),
    );
  }
}
