import 'package:flex_travel_sim/core/storage/local_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> removeToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage localStorage;

  AuthLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> saveToken(String token) async {
    await localStorage.setString('auth_token', token);
  }

  @override
  Future<String?> getToken() async {
    return localStorage.getString('auth_token');
  }
  
  @override
  Future<void> removeToken() async {
    await localStorage.remove('auth_token'); 
  }
}
