import 'package:flex_travel_sim/features/auth/domain/entities/auth_token.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/credentials.dart';
import 'package:flex_travel_sim/features/auth/domain/repo/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({ required this.repository });

  Future<AuthToken?> call(Credentials credentials) {
    return repository.login(credentials);
  }
}