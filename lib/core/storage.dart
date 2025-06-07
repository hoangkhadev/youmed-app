import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const _accessTokenKey = 'access_token';
  static const _userKey = 'user';
  static const _secure = FlutterSecureStorage();

  static Future<void> saveAccessToken(String token) async {
    await _secure.write(key: _accessTokenKey, value: token);
  }

  static Future<String?> getAccessToken() async {
    return await _secure.read(key: _accessTokenKey);
  }

  static Future<void> clearAccessToken() async {
    await _secure.delete(key: _accessTokenKey);
  }

  static Future<void> saveUser(String userJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, userJson);
  }

  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  static Future<void> clearAll() async {
    await clearAccessToken();
    await clearUser();
  }
}
