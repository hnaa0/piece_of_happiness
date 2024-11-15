import 'package:flutter/material.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/home/models/piece_type.dart';

class PieceTag extends StatelessWidget {
  const PieceTag({
    super.key,
    required this.type,
  });

  final PieceType type;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Text(
        type.tagname,
        style: const TextStyle(
          fontSize: 10,
          color: Color(
            ThemeColors.white,
          ),
        ),
      ),
    );
  }
}
