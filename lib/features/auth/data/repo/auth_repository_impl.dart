import 'package:flex_travel_sim/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/confirm_remote_data_source.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/auth_token.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/credentials.dart';
import 'package:flex_travel_sim/features/auth/domain/repo/auth_repository.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final ConfirmRemoteDataSource confirmRemoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.confirmRemoteDataSource,
  });

  @override
  Future<AuthToken?> login(Credentials credentials) async {
    final rawToken = await remoteDataSource.login(credentials);
    if (rawToken != null) {
      await localDataSource.saveToken(rawToken);
      return AuthToken(rawToken);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await localDataSource.removeToken();
  }

  @override
  Future<void> confirm({
    required ConfirmMethod method,
    required String token,
    required String ticketCode,
  }) {
    // метод path приходит из ConfirmMethodExtension
    return confirmRemoteDataSource.confirm(
      endpoint: method.path,
      token: token,
      ticketCode: ticketCode,
    );
  }

}