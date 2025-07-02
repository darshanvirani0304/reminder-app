import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reminder/services/theme_mode_prefrence.dart';

class ThemeModeController extends ChangeNotifier with WidgetsBindingObserver {
  static ThemeModeController of(BuildContext context) {
    return context.read<ThemeModeController>();
  }

  ThemeMode _themeMode = ThemeMode.system;

  final ThemeModePrefrence _themeModePrefrence = ThemeModePrefrence();

  ThemeMode get themeMode => _themeMode;

  ThemeModeController() {
    WidgetsBinding.instance.addObserver(this);
    _setTheme();
  }

  void _setTheme() {
    String currentThemeMode = _themeModePrefrence.getThemeMode();
    _themeMode = ThemeMode.values.firstWhere(
      (e) => e.name == currentThemeMode,
      orElse: () => ThemeMode.system,
    );
    _updateSystemUiOverlay();
    notifyListeners();
  }

  void onThemeChanged(BuildContext context, ThemeMode? mode) {
    if (mode == null) return;

    _themeMode = mode;
    _themeModePrefrence.setThemeMode(_themeMode.name);
    log('Theme changed to: ${mode.name}');

    _updateSystemUiOverlay();
    notifyListeners();
  }

  void _updateSystemUiOverlay() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    bool isDark = false;

    switch (_themeMode) {
      case ThemeMode.dark:
        isDark = true;
        break;
      case ThemeMode.light:
        isDark = false;
        break;
      case ThemeMode.system:
        isDark = brightness == Brightness.dark;
        break;
    }

    updateSystemUiOverlayStyle(isDark);
  }

  void updateSystemUiOverlayStyle(bool isDark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: isDark ? const Color(0xFF161A1D) : Colors.white,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  void didChangePlatformBrightness() {
    log("System brightness changed");
    if (_themeMode == ThemeMode.system) {
      _updateSystemUiOverlay();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
