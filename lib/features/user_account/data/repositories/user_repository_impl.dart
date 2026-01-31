import 'package:vink_sim/core/utils/result.dart';
import 'package:vink_sim/features/user_account/data/data_sources/user_local_data_source.dart';
import 'package:vink_sim/features/user_account/data/data_sources/user_remote_data_source.dart';
import 'package:vink_sim/features/user_account/domain/entities/user.dart';
import 'package:vink_sim/features/user_account/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
    required UserLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Result<User>> getCurrentUser({
    bool forceRefresh = false,
  }) async {
    return ResultHelper.safeCall(() async {
      if (!forceRefresh) {
        final cachedUser = await _localDataSource.getCachedUser();
        if (cachedUser != null) {
          return cachedUser.toEntity();
        }
      }

      final userModel = await _remoteDataSource.getCurrentUser();
      await _localDataSource.cacheUser(userModel);
      return userModel.toEntity();
    });
  }

  @override
  Future<Result<User>> updateUserProfile(Map<String, dynamic> userData) async {
    return ResultHelper.safeCall(() async {
      final userModel = await _remoteDataSource.updateUserProfile(userData);
      await _localDataSource.cacheUser(userModel);
      return userModel.toEntity();
    });
  }

  @override
  Future<Result<void>> updateBalance(double amount) async {
    return ResultHelper.safeCall(() async {
      await _remoteDataSource.updateBalance(amount);
    });
  }

  @override
  Future<Result<Map<String, dynamic>>> getBalanceHistory() async {
    return ResultHelper.safeCall(() async {
      return await _remoteDataSource.getBalanceHistory();
    });
  }

  @override
  Future<Result<void>> deleteUser() async {
    return ResultHelper.safeCall(() async {
      await _remoteDataSource.deleteUser();
      await _localDataSource.clearUserCache();
    });
  }

  @override
  Future<Result<User>> uploadAvatar(String filePath) async {
    return ResultHelper.safeCall(() async {
      final userModel = await _remoteDataSource.uploadAvatar(filePath);
      await _localDataSource.cacheUser(userModel);
      return userModel.toEntity();
    });
  }

  @override
  Future<Result<void>> changePassword(String oldPassword, String newPassword) async {
    return ResultHelper.safeCall(() async {
      await _remoteDataSource.changePassword(oldPassword, newPassword);
    });
  }

  @override
  Future<Result<void>> verifyEmail(String verificationCode) async {
    return ResultHelper.safeCall(() async {
      await _remoteDataSource.verifyEmail(verificationCode);
    });
  }

  @override
  Future<Result<void>> verifyPhone(String verificationCode) async {
    return ResultHelper.safeCall(() async {
      await _remoteDataSource.verifyPhone(verificationCode);
    });
  }

  @override
  Future<Result<bool>> isUserLoggedIn() async {
    return ResultHelper.safeCall(() async {
      final cachedUser = await _localDataSource.getCachedUser();
      return cachedUser != null;
    });
  }

  @override
  Future<Result<void>> logout() async {
    return ResultHelper.safeCall(() async {
      await _localDataSource.clearUserCache();
    });
  }
}