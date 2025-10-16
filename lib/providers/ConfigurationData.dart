import 'package:flutter/material.dart';
import '/../services/SharedPreferencesService.dart';

class ConfigurationData extends ChangeNotifier {
  final SharedPreferencesService _prefs = SharedPreferencesService();

  int _size = 10;
  int get size => _size;

  bool _showNumbers = true;
  bool get showNumbers => _showNumbers;

  ConfigurationData() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final storedSize = await _prefs.getGridSize(fallback: 10);
    final storedShowNumbers = await _prefs.getShowNumbers(fallback: true);
    _size = storedSize;
    _showNumbers = storedShowNumbers;
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
}