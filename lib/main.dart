import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:piece_of_happiness/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piece of Happiness',
      theme: ThemeData(fontFamily: "SsurroundAir"),
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "hello",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "안녕",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
