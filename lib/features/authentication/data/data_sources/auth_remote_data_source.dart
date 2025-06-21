import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRemoteDataSource {
  Future<String?> login(String phone);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<String?> login(String phone) async {
    try {
      final response = await apiClient.post(
        '/api/login/by-phone',
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode('login:password'))}',
          
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
