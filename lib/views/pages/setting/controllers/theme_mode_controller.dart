import 'package:flutter/material.dart';
import 'package:reminder/services/services.dart';

class ThemeModeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  final ThemeModePrefrence _themeModePrefrence = ThemeModePrefrence();

  ThemeModeController() {
    _setTheme();
  }

  void _setTheme() {
    String currentThemeMode = _themeModePrefrence.getThemeMode();
    _themeMode = ThemeMode.values.firstWhere(
      (e) => e.name == currentThemeMode,
      orElse: () => ThemeMode.system,
    );
    notifyListeners();
  }

  void onThemeChanged(ThemeMode? themeMode) {
    if (themeMode == null) return;
    _themeMode = themeMode;
    notifyListeners();
    _themeModePrefrence.setThemeMode(themeMode.name);
  }

  ThemeMode get themeMode => _themeMode;
}
