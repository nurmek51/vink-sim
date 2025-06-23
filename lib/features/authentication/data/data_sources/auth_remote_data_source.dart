import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AuthRemoteDataSource {
  Future<String?> login(String phone);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<String?> login(String phone) async {
    try {
      final credentials = dotenv.env['LOGIN_PASSWORD'];
      if (credentials == null) throw Exception('LOGIN_PASSWORD not set in .env');
      
      final response = await apiClient.post(
        '/api/login/by-phone',
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode(credentials))}',
          
        },
        body: {'phone': phone},
      );

      final token = response['token'];  
      if (kDebugMode) {
        print('TOKEN FROM SERVER: $token');
      }

      return response['token'];
    } catch (e) {
      throw Exception('Login Error: $e');
    }
  }
}
