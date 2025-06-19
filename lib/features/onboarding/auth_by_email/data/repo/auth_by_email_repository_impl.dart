import 'package:flex_travel_sim/features/onboarding/auth_by_email/data/data_sources/auth_by_email_local_data_source.dart';
import 'package:flex_travel_sim/features/onboarding/auth_by_email/data/data_sources/auth_by_email_remote_data_source.dart';
import 'package:flex_travel_sim/features/onboarding/auth_by_email/domain/repo/auth_by_email_repository.dart';

class AuthByEmailRepositoryImpl implements AuthByEmailRepository {
  final AuthByEmailRemoteDataSource remoteDataSource;
  final AuthByEmailLocalDataSource localDataSource;

  AuthByEmailRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<String?> loginByEmail(String email) async {
    final token = await remoteDataSource.loginByEmail(email);
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
