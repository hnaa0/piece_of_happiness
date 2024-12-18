import 'package:flutter/material.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/authentication/models/screen_type.dart';
import 'package:piece_of_happiness/features/authentication/views/sign_up_screen.dart';

class AuthBottomAppBar extends StatelessWidget {
  const AuthBottomAppBar({
    super.key,
    required this.text,
    required this.type,
  });

  final String text;
  final ScreenType type;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      height: 52,
      child: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (type == ScreenType.signIn) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(
                    milliseconds: 350,
                  ),
                  reverseTransitionDuration: const Duration(
                    milliseconds: 350,
                  ),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    final position = Tween(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation);

                    return SlideTransition(
                      position: position,
                      child: const SignUpScreen(),
                    );
                  },
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(
                  ThemeColors.grey_800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
