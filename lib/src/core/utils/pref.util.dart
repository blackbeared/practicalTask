import 'package:flutter_task/all.exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Wraps the [SharedPreferences].
class PrefUtils {
  SharedPreferences? _preferences;

  PrefUtils() {
    initialize();
  }

  Future initialize() async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
  }

  // Clear Preferences and DB for Logout time
  void clearPreferenceAndDB() async {
    bool showThemeSelection = isShowThemeSelection();
    int prefixVal = getInt(keySelectedThemeId);
    bool prefixMode = getBool(keySelectedModeId);

    _preferences?.clear();

    saveInt(keySelectedThemeId, prefixVal);
    saveBoolean(keySelectedModeId, prefixMode);
    saveShowThemeSelection(showThemeSelection);
  }

  /// Gets the int value for the [key] if it exists.
  int getInt(String key, {int defaultValue = 0}) {
    try {
      return _preferences?.getInt(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the bool value for the [key] if it exists.
  bool getBool(String key, {bool defaultValue = false}) {
    try {
      return _preferences?.getString(key)!.toLowerCase() == 'true';
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the String value for the [key] if it exists.
  String getString(String key, {String defaultValue = ""}) {
    try {
      return _preferences?.getString(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the String value for the [key] if it exists.
  double getDouble(String key, {double defaultValue = 0.0}) {
    try {
      return _preferences?.getDouble(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the string list for the [key] or an empty list if it doesn't exist.
  List<String> getStringList(String key) {
    try {
      return _preferences?.getStringList(key) ?? <String>[];
    } catch (e) {
      return <String>[];
    }
  }

  /// Gets the int value for the [key] if it exists.
  void saveInt(String key, int value) {
    _preferences?.setInt(key, value);
  }

  /// Gets the int value for the [key] if it exists.
  void saveBoolean(String key, bool value) {
    _preferences?.setBool(key, value);
  }

  /// Gets the int value for the [key] if it exists.
  void saveString(String key, String? value) {
    _preferences?.setString(key, value ?? "");
  }

  /// Gets the int value for the [key] if it exists.
  void saveDouble(String key, double value) {
    _preferences?.setDouble(key, value);
  }

  /// Gets the string list for the [key] or an empty list if it doesn't exist.
  void saveStringList(String key, List<String> value) {
    _preferences?.setStringList(key, value);
  }

// used Direct Function instead of menual function
  bool isUserLogin() {
    return getUserToken().isNotEmpty;
  }

  bool isShowThemeSelection() {
    return getBool(keyIsShowThemeSelection);
  }

  void saveShowThemeSelection(bool showThemeSelection) {
    saveBoolean(keyIsShowThemeSelection, showThemeSelection);
  }

  String getUserToken() {
    return getString(keyToken);
  }

  String getLanguage() {
    var language = getString(keyLang);
    if (language.isEmpty) {
      return "en_us";
    }
    return language;
  }

  // Unread Notification Count Getter setter
  int getUnreadNotificationCount() {
    return getInt(keyUnreadNotificationCount);
  }

  void saveUnreadNotificationCount(int count) {
    _preferences?.setInt(keyUnreadNotificationCount, count);
  }

  Future saveStringAsync(String s, String jsonEncode) async {
    await initialize();
    _preferences?.setString(s, jsonEncode);
    print("-----------${_preferences?.getString(s)}");
  }

  Future<String> getStringAsync(String s, {String defaultValue = ""}) async {
    try {
      await initialize();
      return _preferences?.getString(s) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }
}
