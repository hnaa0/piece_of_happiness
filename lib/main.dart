import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piece_of_happiness/common/themes.dart';
import 'package:piece_of_happiness/firebase_options.dart';
import 'package:piece_of_happiness/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
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
