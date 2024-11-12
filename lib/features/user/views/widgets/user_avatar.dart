import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/user/models/user_model.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.data,
    required this.file,
  });

  final UserModel data;
  final File file;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(1),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(
          ThemeColors.grey_200,
        ),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: size.width * 0.3,
        height: size.width * 0.3,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: file.path.isNotEmpty
            ? Image.file(
                file,
                fit: BoxFit.cover,
              )
            : data.hasProfileImage
                ? Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/piece-of-happiness.appspot.com/o/profileImage%2F${data.uid}?alt=media&time=${DateTime.now().toString()}",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: LoadingAnimationWidget.twistingDots(
                          leftDotColor: const Color(ThemeColors.lightBlue),
                          rightDotColor: const Color(ThemeColors.blue),
                          size: 20,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container();
                    },
                  )
                : null,
      ),
    );
  }
}
