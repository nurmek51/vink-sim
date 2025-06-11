import 'package:flex_travel_sim/core/error/failures.dart';
import 'package:flex_travel_sim/features/esim_management/domain/repositories/esim_repository.dart';
import 'package:flex_travel_sim/features/user_account/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser({bool forceRefresh = false});
  Future<Either<Failure, User>> updateUserProfile(Map<String, dynamic> userData);
  Future<Either<Failure, void>> updateBalance(double amount);
  Future<Either<Failure, Map<String, dynamic>>> getBalanceHistory();
  Future<Either<Failure, void>> deleteUser();
  Future<Either<Failure, User>> uploadAvatar(String filePath);
  Future<Either<Failure, void>> changePassword(String oldPassword, String newPassword);
  Future<Either<Failure, void>> verifyEmail(String verificationCode);
  Future<Either<Failure, void>> verifyPhone(String verificationCode);
  Future<Either<Failure, bool>> isUserLoggedIn();
  Future<Either<Failure, void>> logout();
}
