import 'package:flutter/material.dart';

abstract class PoHTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    fontFamily: "SsurroundAir",
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
    ),
  );
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: "SsurroundAir",
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
    ),
  );
}
