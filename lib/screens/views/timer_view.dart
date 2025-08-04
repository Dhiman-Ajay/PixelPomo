// lib/screens/views/timer_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pixelpomo/providers/timer_provider.dart';
import 'package:pixelpomo/theme/app_theme.dart';
import 'package:pixelpomo/widgets/time_picker_dialog.dart';
import 'dart:io';

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  // This method correctly calls the renamed CustomTimePickerDialog
  void _showSettingsDialog(BuildContext context, TimerProvider provider) {
    showDialog(
      context: context,
      builder: (_) => CustomTimePickerDialog(
        initialWorkSeconds: provider.workDuration,
        initialBreakSeconds: provider.breakDuration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, provider, child) {
        const workColor = Colors.redAccent;
        const breakColor = Colors.tealAccent;
        final primaryColor = provider.isWorkSession ? workColor : breakColor;

        final double progress = provider.workDuration > 0 && provider.breakDuration > 0
            ? 1 - (provider.timeRemaining / (provider.isWorkSession ? provider.workDuration : provider.breakDuration))
            : 0;

        String formatDuration(int totalSeconds) {
          if (totalSeconds < 1) return "0s";
          final hours = totalSeconds ~/ 3600;
          final minutes = (totalSeconds % 3600) ~/ 60;
          final seconds = totalSeconds % 60;
          List<String> parts = [];
          if (hours > 0) parts.add('${hours}h');
          if (minutes > 0) parts.add('${minutes}m');
          if (hours == 0 && seconds > 0) parts.add('${seconds}s');
          if (parts.isEmpty && minutes == 0) parts.add('0m');
          return parts.join(' ');
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(provider.isWorkSession ? Icons.psychology : Icons.local_cafe, color: primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      provider.isWorkSession ? 'Focus Time' : 'Break Time',
                      style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  Text(
                    provider.formatTime(provider.timeRemaining),
                    style: const TextStyle(fontSize: 96, fontWeight: FontWeight.bold, color: AppTheme.white),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress.isNaN || progress.isInfinite ? 0 : progress,
                        minHeight: 6,
                        backgroundColor: AppTheme.surface,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                  ),
                ],
              ),

              const Text(
                'Stay focused and productive!',
                style: TextStyle(color: AppTheme.grey, fontSize: 16),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (provider.isRunning) {
                        provider.pauseTimer();
                      } else {
                        provider.startTimer();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: AppTheme.background,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Row(
                      children: [
                        Icon(provider.isRunning ? Icons.pause : Icons.play_arrow, size: 24),
                        const SizedBox(width: 8),
                        Text(provider.isRunning ? 'Pause' : 'Start', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     for (;;) {
                  //       provider.startTimer();
                  //       sleep(Duration(seconds: 2));
                  //     }
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Icon(provider.isRunning ? Icons.pause : Icons.play_arrow, size: 24),
                  //       const SizedBox(width: 8),
                  //       Text(provider.isRunning ? 'AutoPause' : 'AutoStart', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: provider.isRunning ? null : provider.resetTimer,
                    icon: const Icon(Icons.refresh, size: 28),
                    style: IconButton.styleFrom(backgroundColor: AppTheme.surface, disabledBackgroundColor: AppTheme.surface.withAlpha(150)),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: provider.isRunning ? null : () => _showSettingsDialog(context, provider),
                    icon: const Icon(Icons.settings_outlined, size: 28),
                    style: IconButton.styleFrom(backgroundColor: AppTheme.surface, disabledBackgroundColor: AppTheme.surface.withAlpha(150)),
                  ),
                ],
              ),

              _buildSessionToggle(context, provider),

              Text(
                'Work: ${formatDuration(provider.workDuration)} • Break: ${formatDuration(provider.breakDuration)}',
                style: const TextStyle(color: AppTheme.grey),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSessionToggle(BuildContext context, TimerProvider provider) {
    const workColor = Colors.redAccent;
    const breakColor = Colors.tealAccent;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _toggleButton(context, 'Work', provider.isWorkSession, workColor, () => provider.toggleSessionType(true)),
          _toggleButton(context, 'Break', !provider.isWorkSession, breakColor, () => provider.toggleSessionType(false)),
        ],
      ),
    );
  }

  Widget _toggleButton(BuildContext context, String text, bool isSelected, Color activeColor, VoidCallback onPressed) {
    final provider = Provider.of<TimerProvider>(context, listen: false);
    return GestureDetector(
      onTap: provider.isRunning ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
            text,
            style: TextStyle(
                color: isSelected ? AppTheme.background : (provider.isRunning ? AppTheme.grey : AppTheme.white),
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }
}