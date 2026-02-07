import 'package:vink_sim/core/storage/local_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> removeToken();

  // New methods
  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  Future<void> saveTokens(
      {required String accessToken, required String refreshToken});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage localStorage;
  static const _tokenKey = 'auth_token';
  static const _refreshTokenKey = 'auth_refresh_token';

  AuthLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> saveToken(String token) =>
      localStorage.setString(_tokenKey, token);

  @override
  Future<String?> getToken() => localStorage.getString(_tokenKey);

  @override
  Future<void> removeToken() async {
    await localStorage.remove(_tokenKey);
    await localStorage.remove(_refreshTokenKey);
  }

  @override
  Future<void> saveRefreshToken(String token) =>
      localStorage.setString(_refreshTokenKey, token);

  @override
  Future<String?> getRefreshToken() => localStorage.getString(_refreshTokenKey);

  @override
  Future<void> saveTokens(
      {required String accessToken, required String refreshToken}) async {
    await saveToken(accessToken);
    await saveRefreshToken(refreshToken);
  }
}
