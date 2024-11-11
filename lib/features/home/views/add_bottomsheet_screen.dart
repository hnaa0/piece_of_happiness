import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:piece_of_happiness/features/home/view_models/upload_piece_view_model.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';

class AddBottomsheetScreen extends ConsumerStatefulWidget {
  const AddBottomsheetScreen({super.key});

  @override
  ConsumerState<AddBottomsheetScreen> createState() => _AddBottomsheetState();
}

class _AddBottomsheetState extends ConsumerState<AddBottomsheetScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  File _file = File("");
  String _text = "";

  void _onImageTap() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 500,
      maxWidth: 500,
    );
    if (pickedImage != null) {
      setState(() {
        _file = File(pickedImage.path);
      });
    }
  }

  void _onXmarkTap() {
    setState(() {
      _file = File("");
    });
  }

  void _onSaveTap() {
    ref
        .read(uploadPieceProvider.notifier)
        .uploadPiece(
          image: _file,
          text: _text,
          context: context,
        )
        .then(
      (_) {
        setState(() {
          _textController.clear();
          _file = File("");
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko_KR', null);
    _textController.addListener(
      () {
        setState(() {
          _text = _textController.text;
        });
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeConfigProvider).darkMode;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        height: size.height * 0.8,
        child: Scaffold(
          backgroundColor: isDark
              ? const Color(
                  ThemeColors.grey_900,
                )
              : const Color(
                  ThemeColors.grey_100,
                ),
          appBar: AppBar(
            backgroundColor: isDark
                ? const Color(
                    ThemeColors.grey_900,
                  )
                : const Color(
                    ThemeColors.grey_100,
                  ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "조각 더하기",
              style: TextStyle(
                fontSize: 16,
                color: isDark
                    ? const Color(
                        ThemeColors.white,
                      )
                    : const Color(
                        ThemeColors.black,
                      ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        ThemeColors.coral,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "날짜",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(
                          ThemeColors.white,
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  Text(
                    DateFormat("yyyy년 MM월 dd일 EEEE", "ko_KR")
                        .format(DateTime.now()),
                    style: TextStyle(
                      color: isDark
                          ? const Color(
                              ThemeColors.white,
                            )
                          : const Color(
                              ThemeColors.black,
                            ),
                    ),
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        ThemeColors.coral,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "사진",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(
                          ThemeColors.white,
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  GestureDetector(
                    onTap: _onImageTap,
                    child: Container(
                      alignment: _file.path.isNotEmpty
                          ? Alignment.topRight
                          : Alignment.center,
                      height: 200,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(
                                ThemeColors.grey_600,
                              )
                            : const Color(
                                ThemeColors.white,
                              ),
                        border: Border.all(
                          color: isDark
                              ? const Color(
                                  ThemeColors.grey_400,
                                )
                              : const Color(
                                  ThemeColors.grey_200,
                                ),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(_file),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: _file.path.isNotEmpty
                          ? GestureDetector(
                              onTap: _onXmarkTap,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  "assets/icons/circle-xmark.svg",
                                  width: 28,
                                  height: 28,
                                  colorFilter: const ColorFilter.mode(
                                    Color(
                                      ThemeColors.white,
                                    ),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(size.width * 0.215),
                              child: SvgPicture.asset(
                                "assets/icons/add-image.svg",
                                colorFilter: ColorFilter.mode(
                                  isDark
                                      ? const Color(
                                          ThemeColors.white,
                                        )
                                      : const Color(
                                          ThemeColors.grey_500,
                                        ),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        ThemeColors.coral,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "내용",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(
                          ThemeColors.white,
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  TextField(
                    focusNode: _focusNode,
                    controller: _textController,
                    cursorColor: const Color(
                      ThemeColors.blue,
                    ),
                    maxLines: 5,
                    maxLength: 200,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? const Color(
                              ThemeColors.white,
                            )
                          : const Color(
                              ThemeColors.black,
                            ),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: isDark
                          ? const Color(
                              ThemeColors.grey_600,
                            )
                          : const Color(
                              ThemeColors.white,
                            ),
                      helperStyle: TextStyle(
                        fontSize: 10,
                        color: isDark
                            ? const Color(
                                ThemeColors.grey_400,
                              )
                            : const Color(
                                ThemeColors.grey_800,
                              ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isDark
                              ? const Color(
                                  ThemeColors.grey_400,
                                )
                              : const Color(
                                  ThemeColors.grey_200,
                                ),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(
                            ThemeColors.lightBlue,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 14,
                      ),
                    ),
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              bottom: _focusNode.hasFocus
                  ? MediaQuery.of(context).viewInsets.bottom
                  : 0,
            ),
            child: GestureDetector(
              onTap:
                  ref.read(uploadPieceProvider).isLoading ? null : _onSaveTap,
              child: BottomAppBar(
                color: isDark
                    ? const Color(
                        ThemeColors.grey_900,
                      )
                    : const Color(
                        ThemeColors.grey_100,
                      ),
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 150,
                  ),
                  alignment: Alignment.center,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: _text.isNotEmpty
                        ? const Color(ThemeColors.blue)
                        : isDark
                            ? const Color(
                                ThemeColors.grey_600,
                              )
                            : const Color(
                                ThemeColors.grey_300,
                              ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isDark
                          ? const Color(
                              ThemeColors.lightBlue,
                            )
                          : const Color(
                              ThemeColors.white,
                            ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? const Color(
                                ThemeColors.lightBlue,
                              )
                            : const Color(
                                ThemeColors.grey_300,
                              ),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ref.watch(uploadPieceProvider).isLoading
                      ? LoadingAnimationWidget.twistingDots(
                          leftDotColor: const Color(ThemeColors.lightBlue),
                          rightDotColor: const Color(ThemeColors.white),
                          size: 20,
                        )
                      : const Text(
                          "저장",
                          style: TextStyle(
                            color: Color(
                              ThemeColors.white,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
