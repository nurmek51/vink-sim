import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';

abstract class ConfirmNumberRemoteDataSource {
  Future<void> confirmNumber({
    required String token,
    required String ticketCode,
  });
}

class ConfirmNumberRemoteDataSourceImpl implements ConfirmNumberRemoteDataSource {
  final ApiClient apiClient;

  ConfirmNumberRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<void> confirmNumber({
    required String token,
    required String ticketCode,
  }) async {
    try {
      await apiClient.post(
        '/api/login/by-phone/confirm',
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode('login:password'))}',
        },
        body: {
          'token': token,
          'ticketCode': ticketCode,
        },
      );
    } catch (e) {
      throw Exception('Confirm Number Error: $e');
    }
  }
}
