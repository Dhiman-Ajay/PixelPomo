// lib/providers/timer_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:pixelpomo/models/pixel_art.dart';
// FIXED: This import was missing, causing the 'Undefined class' error.
import 'package:pixelpomo/services/art_service.dart';
import 'package:pixelpomo/services/persistence_service.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _workDuration = 25 * 60;
  int _breakDuration = 5 * 60;
  int _timeRemaining = 25 * 60;
  bool _isRunning = false;
  bool _isWorkSession = true;

  // FIXED: This line now works because of the import above.
  final ArtService _artService = ArtService();
  final PersistenceService _persistenceService = PersistenceService();
  late PixelArt _currentArt;
  int _currentArtIndex = 0;
  int _pomodorosCompletedInGrid = 0;
  int _totalPomodorosCompleted = 0;

  final Set<int> _completedArtIndices = {};

  int get timeRemaining => _timeRemaining;
  bool get isRunning => _isRunning;
  bool get isWorkSession => _isWorkSession;
  int get pomodorosCompletedInGrid => _pomodorosCompletedInGrid;
  int get workDuration => _workDuration;
  int get breakDuration => _breakDuration;
  PixelArt get currentArt => _currentArt;
  double get artProgress => _currentArt.totalPixels > 0 ? _pomodorosCompletedInGrid / _currentArt.totalPixels : 0;
  int get totalWorkSessions => _totalPomodorosCompleted;
  int get dayStreak => 0;
  int get totalTimeMinutes => _totalPomodorosCompleted * (_workDuration ~/ 60);

  Set<int> get completedArtIndices => _completedArtIndices;

  TimerProvider() {
    _loadProgress();
    _currentArt = _artService.getArtPiece(_currentArtIndex);
    _timeRemaining = _workDuration;
  }

  Future<void> _loadProgress() async {
    final data = await _persistenceService.loadData();
    _totalPomodorosCompleted = data['totalPomodoros'];
    _currentArtIndex = data['currentArtIndex'];
    _pomodorosCompletedInGrid = data['pomodorosInGrid'];

    // --- BUG FIX IS HERE ---
    // Instead of re-assigning the final Set, we clear it and add to it.
    final loadedIndices = data['completedArtIndices'] as Set<int>;
    _completedArtIndices.clear();
    _completedArtIndices.addAll(loadedIndices);

    _currentArt = _artService.getArtPiece(_currentArtIndex);
    _timeRemaining = _workDuration;
    notifyListeners();
  }

  Future<void> _saveProgress() async {
    await _persistenceService.saveData(
      totalPomodoros: _totalPomodorosCompleted,
      completedArtIndices: _completedArtIndices,
      currentArtIndex: _currentArtIndex,
      pomodorosInGrid: _pomodorosCompletedInGrid,
    );
  }

  Future<void> resetAllProgress() async {
    pauseTimer();
    await _persistenceService.clearAllData();
    await _loadProgress(); // Reload the (now empty) data to reset state
  }


  void startTimer() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        _timeRemaining--;
      } else {
        _sessionCompleted();
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    pauseTimer();
    _timeRemaining = _isWorkSession ? _workDuration : _breakDuration;
    notifyListeners();
  }

  void toggleSessionType(bool isWork) {
    if (_isRunning) return;
    _isWorkSession = isWork;
    resetTimer();
  }

  // FIXED: This method now correctly takes integers. The double/int error is resolved.
  void updateDurations(int newWorkSeconds, int newBreakSeconds) {
    _workDuration = newWorkSeconds;
    _breakDuration = newBreakSeconds;
    if (!_isRunning) {
      resetTimer();
    }
  }

  void _sessionCompleted() {
    //pauseTimer();
    _playSound();

    if (_isWorkSession) {
      _pomodorosCompletedInGrid++;
      _totalPomodorosCompleted++;
      if (_pomodorosCompletedInGrid >= _currentArt.totalPixels) {
        _completedArtIndices.add(_currentArtIndex);
        _currentArtIndex = (_currentArtIndex + 1) % _artService.totalArtPieces;
        _currentArt = _artService.getArtPiece(_currentArtIndex);
        _pomodorosCompletedInGrid = 0;
      }
    }
    _saveProgress();
    _isWorkSession = !_isWorkSession;
    _timeRemaining = _isWorkSession ? _workDuration : _breakDuration;
    notifyListeners();
  }

  void _playSound() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/completion.mp3'));
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}