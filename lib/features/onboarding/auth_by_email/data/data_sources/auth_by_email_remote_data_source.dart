import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';

abstract class AuthByEmailRemoteDataSource {
  Future<String?> loginByEmail(String email);
}

class AuthByEmailRemoteDataSourceImpl implements AuthByEmailRemoteDataSource {
  final ApiClient apiClient;

  AuthByEmailRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<String?> loginByEmail(String email) async {
    try {
      final response = await apiClient.post(
        '/api/login/by-email',
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode('login:password'))}',
          
        },
        body: {'email': email},
      );

      return response['token'];
    } catch (e) {
      throw Exception('Auth By Email Error: $e');
    }
  }
}
