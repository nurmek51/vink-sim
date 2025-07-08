import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/credentials.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRemoteDataSource {
  Future<String?> login(Credentials credentials);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<String?> login(Credentials credentials) async {
    await Future.delayed(const Duration(milliseconds: 500));

    String fakeToken;

    if (credentials is PhoneCredentials) {
      fakeToken =
          'mock_token_phone_${credentials.phone.replaceAll(RegExp(r'[^\d]'), '')}';
      if (kDebugMode) {
        print('Mock login for phone: ${credentials.phone}');
      }
    } else if (credentials is EmailCredentials) {
      fakeToken =
          'mock_token_email_${credentials.email.replaceAll('@', '_at_').replaceAll('.', '_dot_')}';
      if (kDebugMode) {
        print('Mock login for email: ${credentials.email}');
      }
    } else {
      throw Exception('Unsupported credentials type');
    }

    if (kDebugMode) {
      print('Generated mock token: $fakeToken');
    }

    return fakeToken;

    /* 
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
    */
  }
}
