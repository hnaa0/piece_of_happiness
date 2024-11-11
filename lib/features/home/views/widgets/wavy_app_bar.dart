import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/settings/views/settings_screen.dart';
import 'package:piece_of_happiness/features/user/view_models/user_view_model.dart';

class WavyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const WavyAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userProvider).value;

    return ClipPath(
      clipper: WavyClipper(),
      child: Container(
        color: const Color(
          ThemeColors.lightBlue,
        ),
        child: AppBar(
          toolbarHeight: 80,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  userData != null && userData.hasProfileImage
                      ? showDialog(
                          context: context,
                          builder: (context) {
                            return imageDialog(
                                "https://firebasestorage.googleapis.com/v0/b/piece-of-happiness.appspot.com/o/profileImage%2F${userData.uid}?alt=media&time=${DateTime.now().toString()}",
                                context);
                          },
                        )
                      : null;
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: 62,
                  height: 62,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(
                      ThemeColors.white,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(
                          ThemeColors.grey_300,
                        ),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: userData != null && userData.hasProfileImage
                      ? Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/piece-of-happiness.appspot.com/o/profileImage%2F${userData.uid}?alt=media&time=${DateTime.now().toString()}",
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              const Gap(14),
              Text(
                userData != null ? userData.name : "username",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(
                    ThemeColors.grey_900,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                GoRouter.of(context).pushNamed(SettingsScreen.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
                height: 80,
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  "assets/icons/admin-alt.svg",
                  width: 26,
                  height: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110.0);
}

class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 8, size.height - 10);
    var firstEndPoint = Offset(size.width / 3, size.height - 20);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Widget imageDialog(path, context) {
  return Dialog(
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.6,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.network(
        path,
        fit: BoxFit.cover,
      ),
    ),
  );
}
