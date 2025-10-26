import 'package:flutter/material.dart';
import '/../services/SharedPreferencesService.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationData extends ChangeNotifier {
  final SharedPreferencesService _prefs = SharedPreferencesService();

  int _size = 10;
  int get size => _size;

  bool _showNumbers = true;
  bool get showNumbers => _showNumbers;

  double _backgroundOpacity = 0.5;
  double get backgroundOpacity => _backgroundOpacity;

  final List<String> creations = [];
  ConfigurationData() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final storedSize = await _prefs.getGridSize(fallback: 10);
    final storedShowNumbers = await _prefs.getShowNumbers(fallback: true);
    final storedOpacity = await _prefs.getBackgroundOpacity(fallback: 0.5);

    _size = storedSize;
    _showNumbers = storedShowNumbers;
     _backgroundOpacity = (storedOpacity).clamp(0.1, 1.0);
    notifyListeners();
  }

  Future<void> setSize(int newSize) async {
    _size = newSize;
    notifyListeners();
    await _prefs.setGridSize(newSize);
  }

  Future<void> setShowNumbers(bool value) async {
    _showNumbers = value;
    notifyListeners();
    await _prefs.setShowNumbers(value);
  }

  Future<void> setBackgroundOpacity(double value) async {
    _backgroundOpacity = value;
    notifyListeners();
    await _prefs.setBackgroundOpacity(value);
  }

  void addCreation(String path) {
    creations.add(path);
    notifyListeners();
  }
}
