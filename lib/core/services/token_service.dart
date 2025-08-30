import 'package:flex_travel_sim/core/utils/result.dart';

abstract class TokenService {
  Future<Result<String?>> getAccessToken();
  Future<Result<String?>> getRefreshToken();
  Future<Result<void>> saveTokens({
    required String accessToken,
    String? refreshToken,
  });
  Future<Result<void>> clearTokens();
  Future<Result<String>> refreshAccessToken();
  Future<Result<bool>> isTokenValid();
  void initialize();
  void dispose();
}

abstract class CacheService {
  Future<Result<T?>> get<T>(String key);
  Future<Result<void>> set<T>(String key, T value);
  Future<Result<void>> remove(String key);
  Future<Result<void>> clear();
  Future<Result<bool>> contains(String key);
}
