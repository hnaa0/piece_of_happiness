import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';
import 'package:piece_of_happiness/features/user/view_models/user_view_model.dart';
import 'package:piece_of_happiness/features/user/views/widgets/user_avatar.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/edit-profile";
  static const routeName = "edit-profile";

  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _initLoaded = false;
  bool _onSaved = false;
  File _file = File("");

  void _onSaveTap() {
    if (_nameController.text == "") return;

    ref.read(userProvider.notifier).editProfile(
          name: _nameController.text,
          file: _file,
          context: context,
        );

    setState(() {
      _onSaved = true;
    });
  }

  void _profileImageTap() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 500,
      maxWidth: 500,
    );
    if (pickedImage != null) {
      setState(() {
        _file = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeConfigProvider).darkMode;
    final size = MediaQuery.of(context).size;
    final userRef = ref.read(userProvider);

    if (!_initLoaded) {
      _nameController.text = userRef.value!.name;
      setState(() {
        _initLoaded = true;
      });
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
              !_onSaved
                  ? showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: const Color(
                            ThemeColors.white,
                          ),
                          elevation: 0,
                          title: const Text(
                            "프로필 수정을 종료하시겠어요?",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          content: const Text(
                            "종료 시 수정사항이 저장되지 않습니다.",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          actionsAlignment: MainAxisAlignment.end,
                          actions: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.pop(context);
                                context.pop();
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
                    )
                  : context.pop();
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
            "프로필 수정",
            style: TextStyle(
              fontSize: 16,
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
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: userRef.isLoading ? null : _onSaveTap,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: SvgPicture.asset(
                  "assets/icons/floppy-disks.svg",
                  width: 20,
                  height: 20,
                  colorFilter: ref.watch(userProvider).isLoading
                      ? const ColorFilter.mode(
                          Color(
                            ThemeColors.grey_500,
                          ),
                          BlendMode.srcIn,
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(size.width * 0.1),
                GestureDetector(
                  onTap: _profileImageTap,
                  child: Stack(
                    children: [
                      UserAvatar(
                        data: userRef.value!,
                        file: _file,
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(
                              ThemeColors.lightBlue,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(
                                ThemeColors.white,
                              ),
                            ),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/add-image.svg",
                            width: 18,
                            height: 18,
                            colorFilter: const ColorFilter.mode(
                              Color(
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
                const Gap(20),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              ThemeColors.lightBlue,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "이름",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(
                                  ThemeColors.grey_800,
                                )),
                          ),
                        ),
                        const Gap(4),
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(
                                  ThemeColors.grey_500,
                                ),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(
                                  ThemeColors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
