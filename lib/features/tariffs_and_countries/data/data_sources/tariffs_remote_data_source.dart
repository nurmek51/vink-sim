import 'package:flutter/foundation.dart';
import 'package:vink_sim/core/network/api_client.dart';
import 'package:vink_sim/features/tariffs_and_countries/data/models/tariff_model.dart';

abstract class TariffsRemoteDataSource {
  Future<List<TariffModel>> getTariffs();
}

class TariffsRemoteDataSourceImpl implements TariffsRemoteDataSource {
  final ApiClient _apiClient;

  TariffsRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<TariffModel>> getTariffs() async {
    try {
      if (kDebugMode) {
        print('TariffsRemoteDataSource: Fetching tariffs from /tariffs');
      }

      final response = await _apiClient.get('/tariffs');

      final List<dynamic> jsonList;
      if (response is List) {
        jsonList = response;
      } else if (response is Map && response.containsKey('data')) {
        jsonList = response['data'] as List<dynamic>;
      } else {
        throw Exception('Unexpected response format: $response');
      }

      if (kDebugMode) {
        print(
          'TariffsRemoteDataSource: Successfully fetched ${jsonList.length} tariffs',
        );
      }

      return jsonList
          .map((json) => TariffModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('TariffsRemoteDataSource: Error fetching tariffs - $e');
      }
      rethrow;
    }
  }
}
