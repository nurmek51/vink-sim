import 'package:flex_travel_sim/core/error/exceptions.dart';
import 'package:flex_travel_sim/core/error/failures.dart';
import 'package:flex_travel_sim/features/esim_management/domain/repositories/esim_repository.dart';
import 'package:flex_travel_sim/features/user_account/data/data_sources/user_local_data_source.dart';
import 'package:flex_travel_sim/features/user_account/data/data_sources/user_remote_data_source.dart';
import 'package:flex_travel_sim/features/user_account/domain/entities/user.dart';
import 'package:flex_travel_sim/features/user_account/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
    required UserLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Either<Failure, User>> getCurrentUser({
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final cachedUser = await _localDataSource.getCachedUser();
        if (cachedUser != null) {
          return Right(cachedUser.toEntity());
        }
      }

      final userModel = await _remoteDataSource.getCurrentUser();

      await _localDataSource.cacheUser(userModel);

      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      try {
        final cachedUser = await _localDataSource.getCachedUser();
        if (cachedUser != null) {
          return Right(cachedUser.toEntity());
        }
      } catch (_) {}

      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      try {
        final cachedUser = await _localDataSource.getCachedUser();
        if (cachedUser != null) {
          return Right(cachedUser.toEntity());
        }
      } catch (_) {}

      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      await logout();
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserProfile(
    Map<String, dynamic> userData,
  ) async {
    try {
      final userModel = await _remoteDataSource.updateUserProfile(userData);

      await _localDataSource.cacheUser(userModel);

      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on AuthenticationException catch (e) {
      await logout();
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateBalance(double amount) async {
    try {
      await _remoteDataSource.updateBalance(amount);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on AuthenticationException catch (e) {
      await logout();
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getBalanceHistory() async {
    try {
      final history = await _remoteDataSource.getBalanceHistory();

      return Right(history);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      await logout();
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser() async {
    try {
      await _remoteDataSource.deleteUser();

      await logout();

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      await logout();
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> uploadAvatar(String filePath) async {
    try {
      final userModel = await _remoteDataSource.uploadAvatar(filePath);

      await _localDataSource.cacheUser(userModel);

      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on AuthenticationException catch (e) {
      await logout();
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      await _remoteDataSource.changePassword(oldPassword, newPassword);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on AuthenticationException catch (e) {
      await logout();
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail(String verificationCode) async {
    try {
      await _remoteDataSource.verifyEmail(verificationCode);

      await getCurrentUser(forceRefresh: true);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on AuthenticationException catch (e) {
      await logout();
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> verifyPhone(String verificationCode) async {
    try {
      await _remoteDataSource.verifyPhone(verificationCode);

      await getCurrentUser(forceRefresh: true);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on AuthenticationException catch (e) {
      await logout();
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserLoggedIn() async {
    try {
      final isLoggedIn = await _localDataSource.isUserLoggedIn();
      final hasToken = await _localDataSource.getAuthToken() != null;

      return Right(isLoggedIn && hasToken);
    } catch (e) {
      return Left(CacheFailure('Failed to check login status: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _localDataSource.clearUserCache();
      await _localDataSource.clearAuthToken();
      await _localDataSource.setUserLoggedIn(false);

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to logout: $e'));
    }
  }
}
