// lib/services/art_service.dart

import 'package:flutter/material.dart';
import '../models/pixel_art.dart';

class ArtService {
  // CRITICAL: We re-introduce a special color to specifically mean "transparent" or "background".
  // This is NOT a visible color, it's a piece of data.
  static final Color _ = Colors.transparent;

  // Pre-defined colors for the art pieces
  static final Color Y = Colors.yellow.shade600;
  static final Color B = Colors.black87;
  static final Color R = Colors.red.shade600;
  static final Color G = Colors.grey.shade700;
  static final Color D = Colors.lightBlue.shade300;
  static final Color W = Colors.white;
  static final Color O = Colors.orange.shade800;
  static final Color L = Colors.lightGreen;
  static final Color P = Colors.purple.shade300;
  static final Color C = Colors.brown.shade400;
  static final Color T = Colors.teal.shade200;

  final List<PixelArt> _artPieces = [
    // --- ART PIECE 1: 8x8 Smiley Face --- (Now with transparency)
    PixelArt(
      name: 'Smiley',
      width: 8,
      height: 8,
      colors: [
        _, Y, Y, Y, Y, Y, Y, _,
        Y, Y, Y, Y, Y, Y, Y, Y,
        Y, B, Y, Y, Y, Y, B, Y,
        Y, Y, Y, Y, Y, Y, Y, Y,
        Y, B, Y, Y, Y, Y, B, Y,
        Y, Y, B, B, B, B, Y, Y,
        Y, Y, Y, Y, Y, Y, Y, Y,
        _, Y, Y, Y, Y, Y, Y, _,
      ],
    ),
    // --- ART PIECE 2: 10x10 Heart --- (Now with transparency)
    PixelArt(
      name: 'Heart',
      width: 10,
      height: 10,
      colors: [
        _, _, R, R, _, _, R, R, _, _,
        _, R, R, R, R, R, R, R, R, _,
        R, R, R, R, R, R, R, R, R, R,
        R, R, R, R, R, R, R, R, R, R,
        R, R, R, R, R, R, R, R, R, R,
        _, R, R, R, R, R, R, R, R, _,
        _, _, R, R, R, R, R, R, _, _,
        _, _, _, R, R, R, R, _, _, _,
        _, _, _, _, R, R, _, _, _, _,
        _, _, _, _, _, _, _, _, _, _,
      ],
    ),
    // --- ART PIECE 3: 11x7 Game Controller --- (Now with transparency)
    PixelArt(
      name: 'Controller',
      width: 11,
      height: 7,
      colors: [
        _, _, _, G, G, G, G, G, _, _, _,
        _, G, G, G, G, G, G, G, G, G, _,
        G, W, G, B, G, G, G, R, G, W, G,
        G, G, B, B, B, G, R, R, R, G, G,
        G, W, G, B, G, G, G, R, G, W, G,
        _, G, G, G, G, G, G, G, G, G, _,
        _, _, _, G, G, G, G, G, _, _, _,
      ],
    ),
    // --- ART PIECE 4: 9x9 Diamond --- (Now with transparency)
    PixelArt(
      name: 'Diamond',
      width: 9,
      height: 9,
      colors: [
        _, _, _, _, W, _, _, _, _,
        _, _, _, W, D, W, _, _, _,
        _, _, W, D, D, D, W, _, _,
        _, W, D, D, D, D, D, W, _,
        W, D, D, D, D, D, D, D, W,
        _, W, D, D, D, D, D, W, _,
        _, _, W, D, D, D, W, _, _,
        _, _, _, W, D, W, _, _, _,
        _, _, _, _, W, _, _, _, _,
      ],
    ),
    // --- ART PIECE 5: 8x8 Pokeball --- (Now with transparency)
    PixelArt(
      name: 'Pokeball',
      width: 8,
      height: 8,
      colors: [
        _, R, R, R, R, R, R, _,
        R, R, R, R, R, R, R, R,
        R, R, B, B, B, B, R, R,
        R, B, B, O, O, B, B, R,
        R, B, B, O, O, B, B, R,
        R, R, B, B, B, B, R, R,
        W, W, W, W, W, W, W, W,
        _, W, W, W, W, W, W, _,
      ],
    ),
    // --- ART PIECE 6: 8x8 Leaf --- (Now with transparency)
    PixelArt(
      name: 'Leaf',
      width: 8,
      height: 8,
      colors: [
        _, _, _, L, L, _, _, _,
        _, _, L, L, L, L, _, _,
        _, L, L, L, L, L, L, _,
        L, L, L, L, L, L, L, L,
        L, L, L, L, L, L, L, _,
        _, L, L, L, L, L, _, _,
        _, _, _, B, B, L, _, _,
        _, _, _, B, B, _, _, _,
      ],
    ),
    // --- ART PIECE 7: 8x8 Potion --- (Now with transparency)
    PixelArt(
      name: 'Potion',
      width: 8,
      height: 8,
      colors: [
        _, _, B, B, B, B, _, _,
        _, B, W, B, W, B, B, _,
        B, P, P, P, P, P, P, B,
        B, P, P, W, P, P, P, B,
        B, P, P, P, P, P, P, B,
        B, P, P, P, P, P, P, B,
        _, B, P, P, P, P, B, _,
        _, _, B, B, B, B, _, _,
      ],
    ),
    // --- ART PIECE 8: 8x8 Coffee Mug --- (Now with transparency)
    PixelArt(
      name: 'Coffee Mug',
      width: 8,
      height: 8,
      colors: [
        W, W, W, W, W, W, _, _,
        W, C, C, C, C, W, C, _,
        W, C, C, C, C, W, C, C,
        W, C, C, C, C, W, C, _,
        W, C, C, C, C, W, _, _,
        W, W, W, W, W, W, _, _,
        _, _, _, _, _, _, _, _,
        _, _, _, _, _, _, _, _,
      ],
    ),
    // --- ART PIECE 9: 9x9 Gem --- (Now with transparency)
    PixelArt(
      name: 'Gem',
      width: 9,
      height: 9,
      colors: [
        _, _, _, _, W, _, _, _, _,
        _, _, _, W, T, W, _, _, _,
        _, _, W, T, T, T, W, _, _,
        _, W, T, T, T, T, T, W, _,
        W, T, T, T, T, T, T, T, W,
        _, W, T, T, T, T, T, W, _,
        _, _, W, T, T, T, W, _, _,
        _, _, _, W, T, W, _, _, _,
        _, _, _, _, W, _, _, _, _,
      ],
    ),
    // --- ART PIECE 10: 8x8 Sword --- (Now with transparency)
    PixelArt(
      name: 'Sword',
      width: 8,
      height: 8,
      colors: [
        _, _, _, _, W, _, _, _,
        _, _, _, _, W, _, _, _,
        _, _, _, _, W, _, _, _,
        _, _, W, W, W, W, W, _,
        _, B, B, W, W, B, B, _,
        _, _, _, B, B, _, _, _,
        _, _, _, B, B, _, _, _,
        _, _, _, B, B, _, _, _,
      ],
    ),
  ];

  PixelArt getArtPiece(int index) {
    if (index >= 0 && index < _artPieces.length) {
      return _artPieces[index];
    }
    return _artPieces[0];
  }

  int get totalArtPieces => _artPieces.length;
}