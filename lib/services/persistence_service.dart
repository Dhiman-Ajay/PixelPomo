// lib/services/persistence_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  // Define keys to prevent typos
  static const String _totalPomodorosKey = 'totalPomodoros';
  static const String _completedArtKey = 'completedArt';
  static const String _currentArtIndexKey = 'currentArtIndex';
  static const String _pomodorosInGridKey = 'pomodorosInGrid';

  Future<void> saveData({
    required int totalPomodoros,
    required Set<int> completedArtIndices,
    required int currentArtIndex,
    required int pomodorosInGrid,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_totalPomodorosKey, totalPomodoros);
    // SharedPreferences can't save a Set<int>, so we convert to List<String>
    await prefs.setStringList(_completedArtKey, completedArtIndices.map((i) => i.toString()).toList());
    await prefs.setInt(_currentArtIndexKey, currentArtIndex);
    await prefs.setInt(_pomodorosInGridKey, pomodorosInGrid);
  }

  Future<Map<String, dynamic>> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final totalPomodoros = prefs.getInt(_totalPomodorosKey) ?? 0;
    final currentArtIndex = prefs.getInt(_currentArtIndexKey) ?? 0;
    final pomodorosInGrid = prefs.getInt(_pomodorosInGridKey) ?? 0;

    // Load the list of strings and convert back to Set<int>
    final completedArtStringList = prefs.getStringList(_completedArtKey) ?? [];
    final completedArtIndices = completedArtStringList.map((s) => int.parse(s)).toSet();

    return {
      'totalPomodoros': totalPomodoros,
      'completedArtIndices': completedArtIndices,
      'currentArtIndex': currentArtIndex,
      'pomodorosInGrid': pomodorosInGrid,
    };
  }

  // The Reset Function
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}