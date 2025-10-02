import 'package:shared_preferences/shared_preferences.dart';
import '../../config/constants/app_constants.dart';

abstract class StorageService {
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> setInt(String key, int value);
  Future<int?> getInt(String key);
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> setDouble(String key, double value);
  Future<double?> getDouble(String key);
  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
}

class StorageServiceImpl implements StorageService {
  final SharedPreferences _prefs;

  StorageServiceImpl(this._prefs);

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  @override
  Future<double?> getDouble(String key) async {
    return _prefs.getDouble(key);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _prefs.containsKey(key);
  }

  // Convenience methods for app-specific storage
  Future<void> setUserToken(String token) async {
    await setString(AppConstants.keyUserToken, token);
  }

  Future<String?> getUserToken() async {
    return getString(AppConstants.keyUserToken);
  }

  Future<void> setUserId(String userId) async {
    await setString(AppConstants.keyUserId, userId);
  }

  Future<String?> getUserId() async {
    return getString(AppConstants.keyUserId);
  }

  Future<void> setIsLoggedIn(bool isLoggedIn) async {
    await setBool(AppConstants.keyIsLoggedIn, isLoggedIn);
  }

  Future<bool> getIsLoggedIn() async {
    return await getBool(AppConstants.keyIsLoggedIn) ?? false;
  }

  Future<void> setIsFirstTime(bool isFirstTime) async {
    await setBool(AppConstants.keyIsFirstTime, isFirstTime);
  }

  Future<bool> getIsFirstTime() async {
    return await getBool(AppConstants.keyIsFirstTime) ?? true;
  }

  Future<void> logout() async {
    await remove(AppConstants.keyUserToken);
    await remove(AppConstants.keyUserId);
    await setIsLoggedIn(false);
  }
}
