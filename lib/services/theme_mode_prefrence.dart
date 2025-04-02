import 'package:shared_preferences/shared_preferences.dart';

class ThemeModePrefrence {
  ThemeModePrefrence._();

  factory ThemeModePrefrence() => ThemeModePrefrence._();

  static SharedPreferences? _preferences;

  static const String _themeMode = 'ThemeMode';

  Future<void> initializeThemeModePreference() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void setThemeMode(String themeMode) async {
    await _preferences?.setString(_themeMode, themeMode);
  }

  String getThemeMode() {
    return _preferences?.getString(_themeMode) ?? 'system';
  }
}
