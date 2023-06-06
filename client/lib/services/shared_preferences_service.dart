import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<SharedPreferencesService> getInstance() async => SharedPreferencesService._(
    await SharedPreferences.getInstance(),
  );

  final SharedPreferences _prefs;
  SharedPreferencesService._(
    this._prefs,
  );

  Future<void> clear() async {
    try {
      await _prefs.clear();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setUser(String key, String user) {
    return _prefs.setString(key, user);
  }

  String? getUser(String key) {
    return _prefs.getString(key);
  }

  Future<bool> removeUser(String key) {
    return _prefs.remove(key);
  }

}
