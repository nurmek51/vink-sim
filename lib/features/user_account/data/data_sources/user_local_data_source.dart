import 'package:vink_sim/core/storage/local_storage.dart';
import 'package:vink_sim/features/user_account/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel?> getCachedUser();
  Future<void> cacheUser(UserModel user);
  Future<void> clearUserCache();
  Future<bool> isUserLoggedIn();
  Future<void> setUserLoggedIn(bool isLoggedIn);
  Future<String?> getAuthToken();
  Future<void> setAuthToken(String token);
  Future<void> clearAuthToken();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final LocalStorage _localStorage;
  
  static const String _userKey = 'cached_user';
  static const String _isLoggedInKey = 'is_user_logged_in';
  static const String _authTokenKey = 'auth_token';

  UserLocalDataSourceImpl({
    required LocalStorage localStorage,
  }) : _localStorage = localStorage;

  @override
  Future<UserModel?> getCachedUser() async {
    final userJson = await _localStorage.getJson(_userKey);
    
    if (userJson == null) return null;
    
    return UserModel.fromJson(userJson);
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await _localStorage.setJson(_userKey, user.toJson());
  }

  @override
  Future<void> clearUserCache() async {
    await _localStorage.remove(_userKey);
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final isLoggedIn = await _localStorage.getBool(_isLoggedInKey);
    return isLoggedIn ?? false;
  }

  @override
  Future<void> setUserLoggedIn(bool isLoggedIn) async {
    await _localStorage.setBool(_isLoggedInKey, isLoggedIn);
  }

  @override
  Future<String?> getAuthToken() async {
    return await _localStorage.getString(_authTokenKey);
  }

  @override
  Future<void> setAuthToken(String token) async {
    await _localStorage.setString(_authTokenKey, token);
  }

  @override
  Future<void> clearAuthToken() async {
    await _localStorage.remove(_authTokenKey);
  }
}
