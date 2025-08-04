import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pixelpomo/providers/timer_provider.dart';
import 'package:pixelpomo/widgets/pixel_art_grid.dart';
import 'package:pixelpomo/theme/app_theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProductivityGridView extends StatelessWidget {
  const ProductivityGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Stats Row with Tiles
          Row(
            children: [
              Expanded(child: _StatCard(icon: Icons.check_circle_outline, value: provider.totalWorkSessions.toString(), label: 'Total Sessions')),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(icon: Icons.psychology_outlined, value: provider.totalWorkSessions.toString(), label: 'Work Sessions')),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(icon: Icons.calendar_today_outlined, value: provider.dayStreak.toString(), label: 'Day Streak')),
              const SizedBox(width: 12),
              Expanded(child: _ArtProgressCard(progress: provider.artProgress)),
            ],
          ),
          const SizedBox(height: 30),

          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Productivity Grid', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.white)),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Each pixel represents your Pomodoro sessions', style: TextStyle(color: AppTheme.grey)),
          ),
          const SizedBox(height: 20),

          // Main Pixel Grid
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.surface.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16)
              ),
              child: PixelArtGrid(
                art: provider.currentArt,
                pomodorosCompleted: provider.pomodorosCompletedInGrid,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Stat Card Widget with Tile Styling
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatCard({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryPurple, size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: AppTheme.grey, fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// Reusable Art Progress Card with Tile Styling
class _ArtProgressCard extends StatelessWidget {
  final double progress;
  const _ArtProgressCard({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 14.0,
            lineWidth: 5.0,
            percent: progress.isNaN ? 0 : progress,
            progressColor: AppTheme.primaryPurple,
            backgroundColor: AppTheme.background,
          ),
          const SizedBox(height: 8),
          Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
          const SizedBox(height: 4),
          const Text('Next Art', style: TextStyle(color: AppTheme.grey, fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}