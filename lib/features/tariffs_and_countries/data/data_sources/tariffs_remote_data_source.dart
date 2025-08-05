import 'dart:convert';
import 'package:flex_travel_sim/features/tariffs_and_countries/data/models/network_operator_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class TariffsRemoteDataSource {
  Future<List<NetworkOperatorModel>> getNetworkOperators();
}

class TariffsRemoteDataSourceImpl implements TariffsRemoteDataSource {
  final http.Client _client;
  static const String _baseUrl = 'https://imsimarket.com/js/data/alternative.rates.json';

  TariffsRemoteDataSourceImpl({http.Client? client})
      : _client = client ?? http.Client();

  @override
  Future<List<NetworkOperatorModel>> getNetworkOperators() async {
    try {
      if (kDebugMode) {
        print('TariffsRemoteDataSource: Fetching network operators from $_baseUrl');
      }

      final response = await _client.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        
        if (kDebugMode) {
          print('TariffsRemoteDataSource: Successfully fetched ${jsonList.length} operators');
        }

        final operators = jsonList
            .map((json) => NetworkOperatorModel.fromJson(json))
            .toList();

        return operators;
      } else {
        if (kDebugMode) {
          print('TariffsRemoteDataSource: HTTP Error ${response.statusCode}: ${response.body}');
        }
        throw Exception('Failed to load network operators: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TariffsRemoteDataSource: Error fetching operators - $e');
      }
      throw Exception('Failed to fetch network operators: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}