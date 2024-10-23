import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeUrl = "/home";
  static const routeName = "home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
      ),
      body: const Column(),
    );
  }
}
