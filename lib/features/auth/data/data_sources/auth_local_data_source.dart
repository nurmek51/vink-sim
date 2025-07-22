import 'package:flex_travel_sim/core/storage/local_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> removeToken();
  
  // Firebase-specific methods
  Future<void> saveAuthToken(String token);
  Future<void> clearAuthToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage localStorage;
  static const _tokenKey = 'auth_token';

  AuthLocalDataSourceImpl({ required this.localStorage });

  @override
  Future<void> saveToken(String token) =>
    localStorage.setString(_tokenKey, token);

  @override
  Future<String?> getToken() =>
    localStorage.getString(_tokenKey);

  @override
  Future<void> removeToken() =>
    localStorage.remove(_tokenKey);
    
  @override
  Future<void> saveAuthToken(String token) =>
    localStorage.setString(_tokenKey, token);
    
  @override
  Future<void> clearAuthToken() =>
    localStorage.remove(_tokenKey);
}