import 'package:vink_sim/core/utils/result.dart';
import 'package:vink_sim/features/esim_management/data/data_sources/esim_local_data_source.dart';
import 'package:vink_sim/features/esim_management/data/data_sources/esim_remote_data_source.dart';
import 'package:vink_sim/features/esim_management/domain/entities/esim.dart';
import 'package:vink_sim/features/esim_management/domain/repositories/esim_repository.dart';

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
  Future<Result<List<Esim>>> getEsims({
    bool forceRefresh = false,
  }) async {
    return ResultHelper.safeCall(() async {
      if (!forceRefresh) {
        final lastCacheTime = await _localDataSource.getLastCacheTime();

        if (lastCacheTime != null) {
          final isValidCache =
              DateTime.now().difference(lastCacheTime) < _cacheValidDuration;

          if (isValidCache) {
            final cachedEsims = await _localDataSource.getCachedEsims();
            if (cachedEsims.isNotEmpty) {
              return cachedEsims.map((model) => model.toEntity()).toList();
            }
          }
        }
      }

      final esimModels = await _remoteDataSource.getEsims();
      await _localDataSource.cacheEsims(esimModels);
      return esimModels.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<Esim>> getEsimById(String id) async {
    return ResultHelper.safeCall(() async {
      final cachedEsim = await _localDataSource.getCachedEsimById(id);

      if (cachedEsim != null) {
        final lastCacheTime = await _localDataSource.getLastCacheTime();

        if (lastCacheTime != null) {
          final isValidCache =
              DateTime.now().difference(lastCacheTime) < _cacheValidDuration;

          if (isValidCache) {
            return cachedEsim.toEntity();
          }
        }
      }

      final esimModel = await _remoteDataSource.getEsimById(id);
      await _localDataSource.cacheEsim(esimModel);
      return esimModel.toEntity();
    });
  }

  @override
  Future<Result<Esim>> activateEsim(
    String id,
    String activationCode,
  ) async {
    // Backend reference implementation does not support activation yet
    return const Failure('Activation not supported by backend yet');
  }

  @override
  Future<Result<Esim>> purchaseEsim(
    String tariffId,
    Map<String, dynamic> paymentData,
  ) async {
    return ResultHelper.safeCall(() async {
      // paymentData is ignored as the backend only requires tariffId
      // and assumes payment is handled or pre-authorized
      final esimModel = await _remoteDataSource.purchaseEsim(
        tariffId,
      );
      await _localDataSource.cacheEsim(esimModel);
      return esimModel.toEntity();
    });
  }

  @override
  Future<Result<void>> deactivateEsim(String id) async {
    // Backend reference implementation does not support deactivation yet
    return const Failure('Deactivation not supported by backend yet');
  }

  @override
  Future<Result<Esim>> updateEsimSettings(
    String id,
    Map<String, dynamic> settings,
  ) async {
    // Backend reference implementation does not support settings update yet
    return const Failure('Settings update not supported by backend yet');
  }

  @override
  Future<Result<Map<String, dynamic>>> getEsimUsageData(
    String id,
  ) async {
    // Backend reference implementation does not support usage data yet
    return const Failure('Usage data not supported by backend yet');
  }
}
