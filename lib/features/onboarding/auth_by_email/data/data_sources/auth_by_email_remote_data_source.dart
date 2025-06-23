import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AuthByEmailRemoteDataSource {
  Future<String?> loginByEmail(String email);
}

class AuthByEmailRemoteDataSourceImpl implements AuthByEmailRemoteDataSource {
  final ApiClient apiClient;

  AuthByEmailRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<String?> loginByEmail(String email) async {
    try {
      final credentials = dotenv.env['LOGIN_PASSWORD'];
      if (credentials == null) throw Exception('LOGIN_PASSWORD not set in .env');

      final response = await apiClient.post(
        '/api/login/by-email',
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode(credentials))}',
          
        },
        body: {'email': email},
      );

      final token = response['token'];  
      if (kDebugMode) {
        print('TOKEN FROM SERVER: $token');
      }

      return response['token'];
    } catch (e) {
      throw Exception('Auth By Email Error: $e');
    }
  }
}
