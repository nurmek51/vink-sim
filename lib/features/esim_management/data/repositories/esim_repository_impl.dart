import 'package:flex_travel_sim/core/error/exceptions.dart';
import 'package:flex_travel_sim/core/error/failures.dart';
import 'package:flex_travel_sim/features/esim_management/data/data_sources/esim_local_data_source.dart';
import 'package:flex_travel_sim/features/esim_management/data/data_sources/esim_remote_data_source.dart';
import 'package:flex_travel_sim/features/esim_management/domain/entities/esim.dart';
import 'package:flex_travel_sim/features/esim_management/domain/repositories/esim_repository.dart';

class EsimRepositoryImpl implements EsimRepository {
  final EsimRemoteDataSource _remoteDataSource;
  final EsimLocalDataSource _localDataSource;

  static const Duration _cacheValidDuration = Duration(minutes: 30);

  EsimRepositoryImpl({
    required EsimRemoteDataSource remoteDataSource,
    required EsimLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<Esim>>> getEsims({
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final lastCacheTime = await _localDataSource.getLastCacheTime();

        if (lastCacheTime != null) {
          final isValidCache =
              DateTime.now().difference(lastCacheTime) < _cacheValidDuration;

          if (isValidCache) {
            final cachedEsims = await _localDataSource.getCachedEsims();
            if (cachedEsims.isNotEmpty) {
              return Right(
                cachedEsims.map((model) => model.toEntity()).toList(),
              );
            }
          }
        }
      }

      final esimModels = await _remoteDataSource.getEsims();

      await _localDataSource.cacheEsims(esimModels);

      return Right(esimModels.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      try {
        final cachedEsims = await _localDataSource.getCachedEsims();
        if (cachedEsims.isNotEmpty) {
          return Right(cachedEsims.map((model) => model.toEntity()).toList());
        }
      } catch (_) {}

      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      try {
        final cachedEsims = await _localDataSource.getCachedEsims();
        if (cachedEsims.isNotEmpty) {
          return Right(cachedEsims.map((model) => model.toEntity()).toList());
        }
      } catch (_) {}

      return Left(NetworkFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Esim>> getEsimById(String id) async {
    try {
      final cachedEsim = await _localDataSource.getCachedEsimById(id);

      if (cachedEsim != null) {
        final lastCacheTime = await _localDataSource.getLastCacheTime();

        if (lastCacheTime != null) {
          final isValidCache =
              DateTime.now().difference(lastCacheTime) < _cacheValidDuration;

          if (isValidCache) {
            return Right(cachedEsim.toEntity());
          }
        }
      }

      final esimModel = await _remoteDataSource.getEsimById(id);

      await _localDataSource.cacheEsim(esimModel);

      return Right(esimModel.toEntity());
    } on ServerException catch (e) {
      final cachedEsim = await _localDataSource.getCachedEsimById(id);
      if (cachedEsim != null) {
        return Right(cachedEsim.toEntity());
      }

      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      final cachedEsim = await _localDataSource.getCachedEsimById(id);
      if (cachedEsim != null) {
        return Right(cachedEsim.toEntity());
      }

      return Left(NetworkFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Esim>> activateEsim(
    String id,
    String activationCode,
  ) async {
    try {
      final esimModel = await _remoteDataSource.activateEsim(
        id,
        activationCode,
      );

      await _localDataSource.cacheEsim(esimModel);

      return Right(esimModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Esim>> purchaseEsim(
    String tariffId,
    Map<String, dynamic> paymentData,
  ) async {
    try {
      final esimModel = await _remoteDataSource.purchaseEsim(
        tariffId,
        paymentData,
      );

      await _localDataSource.cacheEsim(esimModel);

      return Right(esimModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deactivateEsim(String id) async {
    try {
      await _remoteDataSource.deactivateEsim(id);

      await _localDataSource.removeCachedEsim(id);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Esim>> updateEsimSettings(
    String id,
    Map<String, dynamic> settings,
  ) async {
    try {
      final esimModel = await _remoteDataSource.updateEsimSettings(
        id,
        settings,
      );

      await _localDataSource.cacheEsim(esimModel);

      return Right(esimModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getEsimUsageData(
    String id,
  ) async {
    try {
      final usageData = await _remoteDataSource.getEsimUsageData(id);

      return Right(usageData);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
