import 'package:flex_travel_sim/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:flex_travel_sim/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:flex_travel_sim/features/authentication/domain/repo/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<String?> login(String phone) async {
    final token = await remoteDataSource.login(phone);
    if (token != null) {
      await localDataSource.saveToken(token);
    }
    return token;
  }

  @override
  Future<void> logout() async {
    await localDataSource.removeToken(); 
  }  

}
