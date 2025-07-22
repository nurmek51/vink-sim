import 'dart:convert';
import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flutter/foundation.dart';
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

  ConfirmRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<void> confirm({
    required String endpoint,
    required String token,
    required String ticketCode,
  }) async {
    // 🚧 MOCK: Принимаем любой OTP код для демонстрации
    if (kDebugMode) {
      print('MOCK: OTP confirmation for endpoint: $endpoint');
      print('MOCK: Token: $token');
      print('MOCK: Ticket code: $ticketCode');
      print('MOCK: Confirmation always successful');
    }
    
    // Имитация задержки API
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Всегда успешно
    if (kDebugMode) {
      print('MOCK: Confirmation successful for endpoint: $endpoint');
    }
    
    // Оригинальный код закомментирован для мока
    /*
    final basicCreds = dotenv.env['LOGIN_PASSWORD'];
    if (basicCreds == null) {
      throw Exception('LOGIN_PASSWORD not found in .env file');
    }
    final authHeader = 'Basic ${base64Encode(utf8.encode(basicCreds))}';

    try {
      await apiClient.post(
        '/api/login/$endpoint/confirm',
        headers: {'Authorization': authHeader},
        body: {'token': token, 'ticketCode': ticketCode},
      );
      
      if (kDebugMode) {
        print('Confirmation successful for endpoint: $endpoint');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Confirm Error: $e');
      }
      throw Exception('Confirm Error: $e');
    }
    */
  }
}
