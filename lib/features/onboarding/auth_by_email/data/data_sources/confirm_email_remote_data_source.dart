import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      final credentials = dotenv.env['LOGIN_PASSWORD'];
      if (credentials == null) throw Exception('LOGIN_PASSWORD not set in .env');

      await apiClient.post(
        '/api/login/by-email/confirm',
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode(credentials))}',
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
