import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/credentials.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AuthRemoteDataSource {
  Future<String?> login(Credentials credentials);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({ required this.apiClient });

  @override
  Future<String?> login(Credentials credentials) async {
    final basicCreds = dotenv.env['LOGIN_PASSWORD'];
    if (basicCreds == null) {
      throw Exception('LOGIN_PASSWORD not found');
    }
    final authHeader = 'Basic ${base64Encode(utf8.encode(basicCreds))}';

    String endpointPath;
    Map<String, String> body;

    if (credentials is PhoneCredentials) {
      endpointPath = '/api/login/by-phone';
      body = {'phone': credentials.phone};
    } else if (credentials is EmailCredentials) {
      endpointPath = '/api/login/by-email';
      body = {'email': credentials.email};
    } else {
      throw Exception('Unsupported credentials type');
    }

    try {
      final response = await apiClient.post(
        endpointPath,
        headers: {'Authorization': authHeader},
        body: body,
      );
      final String? token = response['token'];
      if (kDebugMode) {
        print('Server token: $token');
        print('Login($endpointPath) response: $response');
      }
      return token;
    } catch (e) {
      throw Exception('Remote Login error: $e');
    }
  }
}