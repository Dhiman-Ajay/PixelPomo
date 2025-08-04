// lib/widgets/pixel_art_grid.dart

import 'package:flutter/material.dart';
import 'package:pixelpomo/models/pixel_art.dart';
import 'package:pixelpomo/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class PixelArtGrid extends StatelessWidget {
  final PixelArt art;
  final int pomodorosCompleted;

  const PixelArtGrid({
    super.key,
    required this.art,
    required this.pomodorosCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: art.width,
        ),
        itemCount: art.totalPixels,
        itemBuilder: (context, index) {
          Widget tile;

          if (index < pomodorosCompleted) {
            // --- THIS PIXEL IS REVEALED ---
            final artColor = art.colors[index];

            if (artColor == Colors.transparent) {
              // A: Revealed but EMPTY. Show a distinct, non-shimmering grey tile.
              tile = Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface.withAlpha(200), // A distinct medium grey
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: AppTheme.background, width: 2),
                ),
              );
            } else {
              // B: Revealed and COLORED. Create the base tile for the shimmer effect.
              final coloredTile = Container(
                decoration: BoxDecoration(
                  color: artColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              );
              // Wrap the colored tile in the Shimmer effect for the sparkle!
              tile = Shimmer.fromColors(
                baseColor: artColor,
                highlightColor: Colors.white.withOpacity(0.6),
                period: const Duration(seconds: 3),
                child: coloredTile,
              );
            }
          } else {
            // C: NOT YET REVEALED. Show a dark, bordered tile.
            tile = Container(
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: AppTheme.surface.withAlpha(100)),
              ),
            );
          }

          // Apply padding to all tiles for separation
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: tile,
          );
        },
      ),
    );
  }
}