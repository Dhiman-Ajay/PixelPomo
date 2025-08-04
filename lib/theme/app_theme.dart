import 'package:flutter/material.dart';

class AppTheme {
  // Define the core colors from the design
  static const Color primaryPurple = Color(0xFFA960FE);
  static const Color lightPurple = Color(0xFFC9A2FD);
  static const Color background = Color(0xFF1A1A2E); // A very dark blue/purple
  static const Color surface = Color(0xFF2E2E48);
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: primaryPurple,
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: primaryPurple,
      secondary: lightPurple,
      surface: surface,
      background: background,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryPurple,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    // ... add other theme properties as needed
  );
}