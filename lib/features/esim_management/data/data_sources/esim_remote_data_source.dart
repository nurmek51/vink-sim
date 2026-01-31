import 'package:vink_sim/core/network/api_client.dart';
import 'package:vink_sim/features/esim_management/data/models/esim_model.dart';
import 'package:flutter/foundation.dart';

abstract class EsimRemoteDataSource {
  Future<List<EsimModel>> getEsims();
  Future<EsimModel> getEsimById(String id);
  Future<EsimModel> purchaseEsim(String tariffId);
}

class EsimRemoteDataSourceImpl implements EsimRemoteDataSource {
  final ApiClient _apiClient;

  EsimRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<EsimModel>> getEsims() async {
    try {
      final response = await _apiClient.get('/esims');
      final List<dynamic> esimsJson = response['data'] as List<dynamic>;
      return esimsJson
          .map((json) => EsimModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (kDebugMode) print('EsimRemoteDataSource: Error - $e');
      rethrow;
    }
  }

  @override
  Future<EsimModel> getEsimById(String id) async {
    // Since API doesn't have specific ID endpoint, we fetch all and filter
    final esims = await getEsims();
    return esims.firstWhere((e) => e.id == id);
  }

  @override
  Future<EsimModel> purchaseEsim(String tariffId) async {
    try {
      final response = await _apiClient.post(
        '/esims/purchase',
        body: {'tariff_id': tariffId},
      );
      // Determine what the purchase endpoint returns.
      // Based on documentation: "Response: 200 OK (DataResponse<Esim>) — returns provisioned eSIM object"
      return EsimModel.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      if (kDebugMode) print('EsimRemoteDataSource: Purchase Error - $e');
      rethrow;
    }
  }
}
