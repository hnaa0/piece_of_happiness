import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/home/views/widgets/wavy_app_bar.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/home";
  static const routeName = "home";

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeConfigProvider).darkMode;

    return Scaffold(
      backgroundColor: Color(
        isDark ? ThemeColors.grey_900 : ThemeColors.white,
      ),
      appBar: const WavyAppBar(),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            Spacer(),
          ],
        ),
      ),
    );
  }
}
