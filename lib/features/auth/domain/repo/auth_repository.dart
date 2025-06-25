import 'package:flex_travel_sim/features/auth/domain/entities/auth_token.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/credentials.dart';

abstract class AuthRepository {
  Future<AuthToken?> login(Credentials credentials);

  Future<void> logout();

  Future<void> confirm({
    required ConfirmMethod method,
    required String token,
    required String ticketCode,
  });  
}