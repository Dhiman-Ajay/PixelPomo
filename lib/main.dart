// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pixelpomo/providers/timer_provider.dart';
import 'package:pixelpomo/screens/main_screen.dart';
import 'package:pixelpomo/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the entire app in a ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (context) => TimerProvider(),
      child: MaterialApp(
        title: 'Pixel Pomodoro',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme, // Apply our custom theme
        home: const MainScreen(),
      ),
    );
  }
}