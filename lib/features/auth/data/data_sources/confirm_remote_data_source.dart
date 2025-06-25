import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ConfirmRemoteDataSource {
  Future<void> confirm({
    required String endpoint,
    required String token,
    required String ticketCode,
  });
}

class ConfirmRemoteDataSourceImpl implements ConfirmRemoteDataSource {
  final ApiClient apiClient;

  ConfirmRemoteDataSourceImpl({ required this.apiClient });


  @override
  Future<void> confirm({
    required String endpoint,
    required String token,
    required String ticketCode,
  }) async {
    final basicCreds =
        dotenv.env['LOGIN_PASSWORD'] ??
        (throw Exception('LOGIN_PASSWORD not set in .env'));
    final authHeader = 'Basic ${base64Encode(utf8.encode(basicCreds))}';

    try {
      await apiClient.post(
        '/api/login/$endpoint/confirm',
        headers: {'Authorization': authHeader},
        body: {'token': token, 'ticketCode': ticketCode},
      );
    } catch (e) {
      throw Exception('Confirm Error: $e');
    }
  }

}