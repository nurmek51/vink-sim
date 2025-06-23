import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      final credentials = dotenv.env['LOGIN_PASSWORD'];
      if (credentials == null) throw Exception('LOGIN_PASSWORD not set in .env');

      await apiClient.post(
        '/api/login/by-phone/confirm',
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode(credentials))}',
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
