// lib/screens/views/gallery_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pixelpomo/providers/timer_provider.dart';
import 'package:pixelpomo/services/art_service.dart';
import 'package:pixelpomo/theme/app_theme.dart';
import 'package:pixelpomo/widgets/pixel_art_grid.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerProvider>(context);
    final artService = ArtService(); // To get art data
    final completedIndices = provider.completedArtIndices.toList();

    if (completedIndices.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.collections_bookmark_outlined, color: AppTheme.grey, size: 60),
            SizedBox(height: 20),
            Text(
              'Your Gallery is Empty',
              style: TextStyle(color: AppTheme.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Complete a grid to see your art here!',
              style: TextStyle(color: AppTheme.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 art pieces per row
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8, // Adjust ratio for name text
      ),
      itemCount: completedIndices.length,
      itemBuilder: (context, index) {
        final artIndex = completedIndices[index];
        final art = artService.getArtPiece(artIndex);

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                // To show a FULLY completed grid, we pass its total pixel count
                child: PixelArtGrid(
                  art: art,
                  pomodorosCompleted: art.totalPixels,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                art.name,
                style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}