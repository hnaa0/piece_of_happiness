import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/authentication/models/field_type.dart';

class SignUpTextField extends StatelessWidget {
  const SignUpTextField({
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

    bool nameValid(String value) {
      return value.length > 1 && value.length < 11 ? true : false;
    }

    bool passwordValid(String value) {
      return value.length >= 8 ? true : false;
    }

    return TextFormField(
      controller: controller,
      obscureText: type == FieldType.password ? true : false,
      autocorrect: false,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: const Color(
          ThemeColors.white,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
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
            padding: const EdgeInsets.all(12),
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
      ),
      validator: (value) {
        if (value != null) {
          switch (type) {
            case FieldType.name:
              if (!nameValid(value)) {
                return "이름은 2글자 이상, 11글자 미만이어야 합니다.";
              }
            case FieldType.email:
              if (!emailValid(value)) {
                return "유효한 이메일을 입력해주세요.";
              }
            case FieldType.password:
              if (!passwordValid(value)) {
                return "비밀번호는 8글자 이상이어야 합니다.";
              }
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
