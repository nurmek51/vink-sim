import 'package:vink_sim/core/storage/local_storage.dart';
import 'package:vink_sim/features/esim_management/data/models/esim_model.dart';

abstract class EsimLocalDataSource {
  Future<List<EsimModel>> getCachedEsims();
  Future<void> cacheEsims(List<EsimModel> esims);
  Future<EsimModel?> getCachedEsimById(String id);
  Future<void> cacheEsim(EsimModel esim);
  Future<void> removeCachedEsim(String id);
  Future<void> clearEsimsCache();
  Future<DateTime?> getLastCacheTime();
  Future<void> setLastCacheTime(DateTime time);
}

class EsimLocalDataSourceImpl implements EsimLocalDataSource {
  final LocalStorage _localStorage;

  static const String _esimsKey = 'cached_esims';
  static const String _lastCacheTimeKey = 'esims_last_cache_time';

  EsimLocalDataSourceImpl({required LocalStorage localStorage})
    : _localStorage = localStorage;

  @override
  Future<List<EsimModel>> getCachedEsims() async {
    final esimsJsonList = await _localStorage.getJsonList(_esimsKey);

    if (esimsJsonList == null) {
      return [];
    }

    return esimsJsonList.map((json) => EsimModel.fromJson(json)).toList();
  }

  @override
  Future<void> cacheEsims(List<EsimModel> esims) async {
    final esimsJsonList = esims.map((esim) => esim.toJson()).toList();

    await _localStorage.setJsonList(_esimsKey, esimsJsonList);
    await setLastCacheTime(DateTime.now());
  }

  @override
  Future<EsimModel?> getCachedEsimById(String id) async {
    final cachedEsims = await getCachedEsims();

    try {
      return cachedEsims.firstWhere((esim) => esim.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheEsim(EsimModel esim) async {
    final cachedEsims = await getCachedEsims();

    cachedEsims.removeWhere((cached) => cached.id == esim.id);

    cachedEsims.add(esim);

    await cacheEsims(cachedEsims);
  }

  @override
  Future<void> removeCachedEsim(String id) async {
    final cachedEsims = await getCachedEsims();

    cachedEsims.removeWhere((esim) => esim.id == id);

    await cacheEsims(cachedEsims);
  }

  @override
  Future<void> clearEsimsCache() async {
    await _localStorage.remove(_esimsKey);
    await _localStorage.remove(_lastCacheTimeKey);
  }

  @override
  Future<DateTime?> getLastCacheTime() async {
    final timeString = await _localStorage.getString(_lastCacheTimeKey);

    if (timeString == null) return null;

    return DateTime.tryParse(timeString);
  }

  @override
  Future<void> setLastCacheTime(DateTime time) async {
    await _localStorage.setString(_lastCacheTimeKey, time.toIso8601String());
  }
}
