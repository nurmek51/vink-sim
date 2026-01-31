import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vink_sim/core/error/exceptions.dart';

abstract class LocalStorage {
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> setInt(String key, int value);
  Future<int?> getInt(String key);
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> setJson(String key, Map<String, dynamic> value);
  Future<Map<String, dynamic>?> getJson(String key);
  Future<void> setJsonList(String key, List<Map<String, dynamic>> value);
  Future<List<Map<String, dynamic>>?> getJsonList(String key);
  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
}

class SharedPreferencesStorage implements LocalStorage {
  SharedPreferences? _preferences;

  Future<SharedPreferences> get _prefs async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  @override
  Future<void> setString(String key, String value) async {
    try {
      final prefs = await _prefs;
      await prefs.setString(key, value);
    } catch (e) {
      throw CacheException('Failed to save string: $e');
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getString(key);
    } catch (e) {
      throw CacheException('Failed to get string: $e');
    }
  }

  @override
  Future<void> setInt(String key, int value) async {
    try {
      final prefs = await _prefs;
      await prefs.setInt(key, value);
    } catch (e) {
      throw CacheException('Failed to save int: $e');
    }
  }

  @override
  Future<int?> getInt(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getInt(key);
    } catch (e) {
      throw CacheException('Failed to get int: $e');
    }
  }

  @override
  Future<void> setBool(String key, bool value) async {
    try {
      final prefs = await _prefs;
      await prefs.setBool(key, value);
    } catch (e) {
      throw CacheException('Failed to save bool: $e');
    }
  }

  @override
  Future<bool?> getBool(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getBool(key);
    } catch (e) {
      throw CacheException('Failed to get bool: $e');
    }
  }

  @override
  Future<void> setJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      await setString(key, jsonString);
    } catch (e) {
      throw CacheException('Failed to save JSON: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getJson(String key) async {
    try {
      final jsonString = await getString(key);
      if (jsonString == null) return null;
      
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw CacheException('Failed to get JSON: $e');
    }
  }

  @override
  Future<void> setJsonList(String key, List<Map<String, dynamic>> value) async {
    try {
      final jsonString = jsonEncode(value);
      await setString(key, jsonString);
    } catch (e) {
      throw CacheException('Failed to save JSON list: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>?> getJsonList(String key) async {
    try {
      final jsonString = await getString(key);
      if (jsonString == null) return null;
      
      final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      throw CacheException('Failed to get JSON list: $e');
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      final prefs = await _prefs;
      await prefs.remove(key);
    } catch (e) {
      throw CacheException('Failed to remove key: $e');
    }
  }

  @override
  Future<void> clear() async {
    try {
      final prefs = await _prefs;
      await prefs.clear();
    } catch (e) {
      throw CacheException('Failed to clear storage: $e');
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.containsKey(key);
    } catch (e) {
      throw CacheException('Failed to check key: $e');
    }
  }
}
