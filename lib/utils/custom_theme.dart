import 'package:flutter/material.dart';

final customTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 18),
    filled: true,
    fillColor: Colors.blue[50],
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  useMaterial3: true,
  highlightColor: Colors.blue[50],
  primaryColor: Colors.blue,
  badgeTheme: const BadgeThemeData(
    backgroundColor: Colors.red,
    textStyle: TextStyle(fontSize: 8),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.blue),
);
