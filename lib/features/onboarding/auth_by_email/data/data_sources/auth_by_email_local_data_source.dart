import 'package:flex_travel_sim/core/storage/local_storage.dart';

abstract class AuthByEmailLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> removeToken();
}

class AuthByEmailLocalDataSourceImpl implements AuthByEmailLocalDataSource {
  final LocalStorage localStorage;

  AuthByEmailLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> saveToken(String token) async {
    await localStorage.setString('auth_by_email_token', token);
  }

  @override
  Future<String?> getToken() async {
    return localStorage.getString('auth_by_email_token');
  }
  
  @override
  Future<void> removeToken() async {
    await localStorage.remove('auth_by_email_token'); 
  }
}
