import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/settings/views/settings_screen.dart';
import 'package:piece_of_happiness/features/user/view_models/user_view_model.dart';

class WavyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const WavyAppBar({
    super.key,
    required this.profileKey,
    required this.settingsKey,
  });

  final GlobalKey profileKey;
  final GlobalKey settingsKey;

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
            mainAxisSize: MainAxisSize.min,
            key: profileKey,
            children: [
              GestureDetector(
                onTap: () {
                  userData != null && userData.hasProfileImage
                      ? showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              clipBehavior: Clip.hardEdge,
                              elevation: 0,
                              backgroundColor: const Color(
                                ThemeColors.white,
                              ),
                              child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/piece-of-happiness.appspot.com/o/profileImage%2F${userData.uid}?alt=media&time=${DateTime.now().toString()}",
                              ),
                            );
                          },
                        )
                      : null;
                },
                child: Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(
                      ThemeColors.white,
                    ),
                    border: Border.all(
                      color: const Color(
                        ThemeColors.white,
                      ),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(
                          ThemeColors.grey_300,
                        ),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: userData != null && userData.hasProfileImage
                      ? CircleAvatar(
                          backgroundColor: const Color(
                            ThemeColors.white,
                          ),
                          backgroundImage: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/piece-of-happiness.appspot.com/o/profileImage%2F${userData.uid}?alt=media&time=${DateTime.now().toString()}"),
                        )
                      : null,
                ),
              ),
              const Gap(14),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.3),
                child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  userData != null ? userData.name : "username",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(
                      ThemeColors.grey_900,
                    ),
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
                height: 70,
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  key: settingsKey,
                  "assets/icons/admin-alt.svg",
                  width: 20,
                  height: 20,
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
