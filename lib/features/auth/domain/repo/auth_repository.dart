import 'package:vink_sim/core/utils/result.dart';
import 'package:vink_sim/features/auth/domain/entities/auth_token.dart';

abstract class AuthRepository {
  Future<Result<void>> requestOtp(String phone);
  Future<Result<AuthToken>> verifyOtp(String phone, String otp);
  Future<Result<void>> logout();
  Future<Result<bool>> isAuthenticated();
}