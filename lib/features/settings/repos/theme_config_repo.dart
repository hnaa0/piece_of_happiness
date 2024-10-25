import 'package:shared_preferences/shared_preferences.dart';

class ThemeConfigRepo {
  static const _darkMode = "darkMode";
  final SharedPreferences _preferences;

  ThemeConfigRepo(this._preferences);

  Future<void> setDarkMode(bool value) async {
    _preferences.setBool(_darkMode, value);
  }

  bool isDarkMode() {
    return _preferences.getBool(_darkMode) ?? false;
  }
}
