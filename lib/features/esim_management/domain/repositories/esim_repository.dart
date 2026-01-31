import 'package:vink_sim/core/utils/result.dart';
import 'package:vink_sim/features/esim_management/domain/entities/esim.dart';

abstract class EsimRepository {
  Future<Result<List<Esim>>> getEsims({bool forceRefresh = false});
  Future<Result<Esim>> getEsimById(String id);
  Future<Result<Esim>> activateEsim(String id, String activationCode);
  Future<Result<Esim>> purchaseEsim(String tariffId, Map<String, dynamic> paymentData);
  Future<Result<void>> deactivateEsim(String id);
  Future<Result<Esim>> updateEsimSettings(String id, Map<String, dynamic> settings);
  Future<Result<Map<String, dynamic>>> getEsimUsageData(String id);
}

