import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';

abstract class ConfirmEmailRemoteDataSource {
  Future<void> confirmEmail({
    required String token,
    required String ticketCode,
  });
}

class ConfirmEmailRemoteDataSourceImpl implements ConfirmEmailRemoteDataSource {
  final ApiClient apiClient;

  ConfirmEmailRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<void> confirmEmail({
    required String token,
    required String ticketCode,
  }) async {
    try {
      await apiClient.post(
        '/api/login/by-email/confirm',
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode('login:password'))}',
        },
        body: {
          'token': token,
          'ticketCode': ticketCode,
        },
      );
    } catch (e) {
      throw Exception('Confirm Email Error: $e');
    }
  }
}
