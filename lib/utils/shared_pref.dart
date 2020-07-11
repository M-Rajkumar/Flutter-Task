import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static SharedPreferences _prefs;

  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs.getString(key) ?? defValue;
  }

  // put string
  static Future<bool> putString(String key, String value) {
    if (_prefs == null) return null;
    return _prefs.setString(key, value);
  }
}
