import 'package:shared_preferences/shared_preferences.dart';

class _PrefsKeys {
  static const gridSize = 'gridSize'; // int (obligatoria por enunciado)
  static const showNumbers = 'showNumbers'; // bool (segunda preferencia mínima)
  static const isResetEnabled =
      'isResetEnabled'; // bool (ejemplo del enunciado)
}

class SharedPreferencesService {
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  Future<int> getGridSize({int fallback = 16}) async {
    final p = await _prefs;
    return p.getInt(_PrefsKeys.gridSize) ?? fallback;
  }

  Future<void> setGridSize(int value) async {
    final p = await _prefs;
    await p.setInt(_PrefsKeys.gridSize, value);
  }

  Future<bool> getShowNumbers({bool fallback = true}) async {
    final p = await _prefs;
    return p.getBool(_PrefsKeys.showNumbers) ?? fallback;
  }

  Future<void> setShowNumbers(bool value) async {
    final p = await _prefs;
    await p.setBool(_PrefsKeys.showNumbers, value);
  }

  Future<bool> getIsResetEnabled({bool fallback = false}) async {
    final p = await _prefs;
    return p.getBool(_PrefsKeys.isResetEnabled) ?? fallback;
  }

  Future<void> setIsResetEnabled(bool value) async {
    final p = await _prefs;
    await p.setBool(_PrefsKeys.isResetEnabled, value);
  }

  // Guardar opacidad
  Future<void> setBackgroundOpacity(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('backgroundOpacity', value);
  }

  // Obtener opacidad
  Future<double> getBackgroundOpacity({double fallback = 0.5}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('backgroundOpacity') ?? fallback;
  }

  Future<PreferencesSnapshot> loadAll({
    int defaultGridSize = 16,
    bool defaultShowNumbers = true,
    bool defaultIsResetEnabled = false,
  }) async {
    final p = await _prefs;
    return PreferencesSnapshot(
      gridSize: p.getInt(_PrefsKeys.gridSize) ?? defaultGridSize,
      showNumbers: p.getBool(_PrefsKeys.showNumbers) ?? defaultShowNumbers,
      isResetEnabled:
          p.getBool(_PrefsKeys.isResetEnabled) ?? defaultIsResetEnabled,
    );
  }
}

class PreferencesSnapshot {
  final int gridSize;
  final bool showNumbers;
  final bool isResetEnabled;

  const PreferencesSnapshot({
    required this.gridSize,
    required this.showNumbers,
    required this.isResetEnabled,
  });
}
