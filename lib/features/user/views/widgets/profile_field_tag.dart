import 'package:flutter/material.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/user/models/profile_field_type.dart';

class ProfileFieldTag extends StatelessWidget {
  const ProfileFieldTag({
    super.key,
    required this.type,
  });

  final ProfileFieldType type;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Text(
        type.fieldName,
        style: const TextStyle(
          fontSize: 10,
          color: Color(
            ThemeColors.grey_800,
          ),
        ),
      ),
    );
  }
}
