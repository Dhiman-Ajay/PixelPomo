import 'package:flutter/material.dart';
import 'package:pixelpomo/screens/views/gallery_view.dart';
import 'package:pixelpomo/screens/views/grid_view.dart';
import 'package:pixelpomo/screens/views/stats_view.dart';
import 'package:pixelpomo/screens/views/timer_view.dart';
import 'package:pixelpomo/theme/app_theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _views = <Widget>[
    const TimerView(),
    const ProductivityGridView(),
    const StatsView(),
    const GalleryView(), // Added the new view
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: _buildTopNavBar(),
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: _views,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavBar() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _navBarItem(Icons.timer_outlined, 'Timer', 0),
          _navBarItem(Icons.grid_on_outlined, 'Grid', 1),
          _navBarItem(Icons.bar_chart_outlined, 'Stats', 2),
          _navBarItem(Icons.collections_bookmark_outlined, 'Gallery', 3), // Added the new button
        ],
      ),
    );
  }

  Widget _navBarItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryPurple : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: AppTheme.white),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}