import 'package:flex_travel_sim/core/utils/result.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/auth_token.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/credentials.dart';

abstract class AuthRepository {
  Future<Result<AuthToken>> login(Credentials credentials);

  Future<Result<void>> logout();

  Future<Result<void>> confirm({
    required ConfirmMethod method,
    required String token,
    required String ticketCode,
  });
  
  Future<Result<bool>> isAuthenticated();
}