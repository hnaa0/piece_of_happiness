import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piece_of_happiness/common/themes.dart';
import 'package:piece_of_happiness/features/settings/repos/theme_config_repo.dart';
import 'package:piece_of_happiness/features/settings/view_models/theme_config_view_model.dart';
import 'package:piece_of_happiness/firebase_options.dart';
import 'package:piece_of_happiness/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final repository = ThemeConfigRepo(preferences);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 화면세로고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    ProviderScope(
      overrides: [
        themeConfigProvider.overrideWith(
          () => ThemeConfigViewModel(repository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Piece of Happiness',
      debugShowCheckedModeBanner: false,
      theme: PoHTheme.light,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
