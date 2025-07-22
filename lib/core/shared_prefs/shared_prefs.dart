import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance => _prefs!;

  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  static Future<void> clearAll() async {
    await _prefs?.clear();
  }

  static String? getUserId() => getString("user_uid");

  static Future<void> setUserId(String userId) async {
    await setString("user_uid", userId);
  }
}
