import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/authentication/models/field_type.dart';

class SignInTextField extends StatelessWidget {
  const SignInTextField({
    super.key,
    required this.type,
    required this.controller,
    required this.formData,
  });

  final FieldType type;
  final TextEditingController controller;
  final Map<String, String> formData;

  @override
  Widget build(BuildContext context) {
    bool emailValid(String value) {
      var pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      return RegExp(pattern).hasMatch(value);
    }

    return TextFormField(
      controller: controller,
      cursorColor: const Color(
        ThemeColors.blue,
      ),
      obscureText: type == FieldType.password ? true : false,
      autocorrect: false,
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: const Color(
          ThemeColors.white,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.5,
          horizontal: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            controller.clear();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
            ),
            child: SvgPicture.asset(
              "assets/icons/circle-xmark.svg",
              colorFilter: const ColorFilter.mode(
                Color(
                  ThemeColors.grey_500,
                ),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          maxWidth: 40,
        ),
      ),
      validator: (value) {
        if (value != null) {
          if (type == FieldType.email && !emailValid(value)) {
            return "올바른 이메일 형식을 입력해주세요.";
          }
        }
        return null;
      },
      onSaved: (newValue) {
        if (newValue != null) {
          formData[type.name.toLowerCase()] = newValue;
        }
      },
    );
  }
}
