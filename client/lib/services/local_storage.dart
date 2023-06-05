
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<SharedPreferences> get _instance async => _prefsInstance;
  static late SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static Future<bool> setUser(String key, String user) {
    return _prefsInstance.setString(key, user);
  }

  static String? getUser(String key) {
    return _prefsInstance.getString(key);
  }

  static Future<bool> removeUser(String key) {
    return _prefsInstance.remove(key);
  }
}