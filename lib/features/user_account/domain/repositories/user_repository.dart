import 'package:flex_travel_sim/core/utils/result.dart';
import 'package:flex_travel_sim/features/user_account/domain/entities/user.dart';

abstract class UserRepository {
  Future<Result<User>> getCurrentUser({bool forceRefresh = false});
  Future<Result<User>> updateUserProfile(Map<String, dynamic> userData);
  Future<Result<void>> updateBalance(double amount);
  Future<Result<Map<String, dynamic>>> getBalanceHistory();
  Future<Result<void>> deleteUser();
  Future<Result<User>> uploadAvatar(String filePath);
  Future<Result<void>> changePassword(String oldPassword, String newPassword);
  Future<Result<void>> verifyEmail(String verificationCode);
  Future<Result<void>> verifyPhone(String verificationCode);
  Future<Result<bool>> isUserLoggedIn();
  Future<Result<void>> logout();
}
