import 'package:flutter/material.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/home/views/widgets/wavy_app_bar.dart';

class HomeScreen extends StatelessWidget {
  static const routeUrl = "/home";
  static const routeName = "home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(
        ThemeColors.white,
      ),
      appBar: WavyAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
