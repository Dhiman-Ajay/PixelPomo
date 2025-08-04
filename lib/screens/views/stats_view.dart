import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pixelpomo/providers/timer_provider.dart';
import 'package:pixelpomo/theme/app_theme.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  // --- NEW: Confirmation Dialog for Reset ---
  void _showResetConfirmationDialog(BuildContext context) {
    final provider = Provider.of<TimerProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Reset All Progress?', style: TextStyle(color: AppTheme.white)),
        content: const Text(
          'This will permanently delete all your stats and completed art. This action cannot be undone.',
          style: TextStyle(color: AppTheme.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.grey)),
          ),
          TextButton(
            onPressed: () {
              provider.resetAllProgress();
              Navigator.of(context).pop();
            },
            child: const Text('Reset', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Productivity Stats',
              style: TextStyle(color: AppTheme.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Track your progress and celebrate your achievements',
              style: TextStyle(color: AppTheme.grey, fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _StatTile(value: provider.totalWorkSessions.toString(), label: 'Total Sessions')),
                const SizedBox(width: 12),
                Expanded(child: _StatTile(value: '${provider.totalTimeMinutes}m', label: 'Total Time')),
                const SizedBox(width: 12),
                Expanded(child: _StatTile(value: provider.dayStreak.toString(), label: 'Day Streak')),
                const SizedBox(width: 12),
                Expanded(child: _StatTile(value: '0', label: 'This Week')),
              ],
            ),
            const SizedBox(height: 24),
            _buildSessionBreakdown(provider),
            const SizedBox(height: 24),
            _buildWeeklyDistribution(),
            const SizedBox(height: 24),
            _buildAchievements(),
            const SizedBox(height: 32),

            // --- NEW: Reset Button ---
            Center(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.delete_forever_outlined),
                label: const Text('Reset All Progress'),
                onPressed: () => _showResetConfirmationDialog(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.redAccent),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // (All the helper widgets _StatTile, _buildSessionBreakdown etc. remain the same)
  Widget _StatTile({required String value, required String label}) { return Container(padding: const EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(12)), child: Column(children: [Text(value, style: const TextStyle(color: AppTheme.white, fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: AppTheme.grey))]));}
  Widget _buildSessionBreakdown(TimerProvider provider) { int breakSessions = provider.totalWorkSessions > 0 ? provider.totalWorkSessions - 1 : 0; int breakTime = breakSessions * (provider.breakDuration ~/ 60); return Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Session Breakdown', style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 16), _breakdownRow('Work Sessions', provider.totalWorkSessions.toString()), const Divider(color: AppTheme.background), _breakdownRow('Break Sessions', breakSessions.toString()), const SizedBox(height: 16), Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_timeDisplay('${provider.totalTimeMinutes}m', 'Work Time'), _timeDisplay('${breakTime}m', 'Break Time')])]));}
  Widget _buildWeeklyDistribution() { final weeklyData = {'Sun': 0, 'Mon': 0, 'Tue': 0, 'Wed': 0, 'Thu': 0, 'Fri': 0, 'Sat': 0}; return Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Weekly Distribution', style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 16), ...weeklyData.entries.map((entry) => _breakdownRow(entry.key, entry.value.toString())).toList()]));}
  Widget _buildAchievements() { return Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(16)), child: const Center(child: Column(children: [Text('Achievements', style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 16), Icon(Icons.shield_outlined, color: AppTheme.grey, size: 40), SizedBox(height: 8), Text('Coming Soon!', style: TextStyle(color: AppTheme.grey))]))); }
  Widget _breakdownRow(String label, String value) { return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(color: AppTheme.grey, fontSize: 16)), Text(value, style: const TextStyle(color: AppTheme.white, fontSize: 16, fontWeight: FontWeight.bold))]));}
  Widget _timeDisplay(String time, String label) { return Column(children: [Text(time, style: const TextStyle(color: AppTheme.primaryPurple, fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: AppTheme.grey))]);}
}