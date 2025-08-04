// lib/models/pixel_art.dart

import 'package:flutter/material.dart';

class PixelArt {
  final String name;
  final int width;
  final int height;
  final List<Color> colors; // A flat list of colors for the grid

  PixelArt({
    required this.name,
    required this.width,
    required this.height,
    required this.colors,
  });

  // A helper to know the total number of pixels (Pomodoros) needed
  int get totalPixels => width * height;
}