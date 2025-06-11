import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flex_travel_sim/features/esim_management/data/models/esim_model.dart';

abstract class EsimRemoteDataSource {
  Future<List<EsimModel>> getEsims();
  Future<EsimModel> getEsimById(String id);
  Future<EsimModel> activateEsim(String id, String activationCode);
  Future<EsimModel> purchaseEsim(String tariffId, Map<String, dynamic> paymentData);
  Future<void> deactivateEsim(String id);
  Future<EsimModel> updateEsimSettings(String id, Map<String, dynamic> settings);
  Future<Map<String, dynamic>> getEsimUsageData(String id);
}

class EsimRemoteDataSourceImpl implements EsimRemoteDataSource {
  final ApiClient _apiClient;

  EsimRemoteDataSourceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<EsimModel>> getEsims() async {
    final response = await _apiClient.get('/esims');
    
    final List<dynamic> esimsJson = response['data'] as List<dynamic>;
    return esimsJson
        .map((json) => EsimModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<EsimModel> getEsimById(String id) async {
    final response = await _apiClient.get('/esims/$id');
    
    return EsimModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<EsimModel> activateEsim(String id, String activationCode) async {
    final response = await _apiClient.post(
      '/esims/$id/activate',
      body: {
        'activation_code': activationCode,
      },
    );
    
    return EsimModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<EsimModel> purchaseEsim(String tariffId, Map<String, dynamic> paymentData) async {
    final response = await _apiClient.post(
      '/esims/purchase',
      body: {
        'tariff_id': tariffId,
        'payment_data': paymentData,
      },
    );
    
    return EsimModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deactivateEsim(String id) async {
    await _apiClient.post('/esims/$id/deactivate');
  }

  @override
  Future<EsimModel> updateEsimSettings(String id, Map<String, dynamic> settings) async {
    final response = await _apiClient.put(
      '/esims/$id/settings',
      body: settings,
    );
    
    return EsimModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<Map<String, dynamic>> getEsimUsageData(String id) async {
    final response = await _apiClient.get('/esims/$id/usage');
    
    return response['data'] as Map<String, dynamic>;
  }
}
