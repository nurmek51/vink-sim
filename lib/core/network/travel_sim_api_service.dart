import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flutter/foundation.dart';

class TravelSimApiService {
  final ApiClient _apiClient;
  
  TravelSimApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Map<String, dynamic>> sendOtpSms(String phone) async {
    if (kDebugMode) {
      print('TravelSimAPI: Sending OTP SMS request');
      print('Phone: $phone');
      print('URL: ${_apiClient.baseUrl}/otp/whatsapp');
    }
    
    try {
      final response = await _apiClient.post(
        '/otp/whatsapp',
        body: {'phone': phone},
      );
      if (kDebugMode) {
        print('TravelSimAPI: SMS sent successfully');
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('TravelSimAPI: Failed to send SMS - $e');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String code) async {
    if (kDebugMode) {
      print('TravelSimAPI: Verifying OTP');
      print('Phone: $phone');
      print('Code: $code');
      print('URL: ${_apiClient.baseUrl}${kDebugMode ? '/dev/otp/verify' : '/otp/verify'}');
    }
    
    try {
      final response = await _apiClient.post(
        kDebugMode ? '/dev/otp/verify' : '/otp/verify',
        body: {
          'phone': phone,
          'code': code,
        },
      );
      if (kDebugMode) {
        print('TravelSimAPI: OTP verification successful');
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('TravelSimAPI: Failed to verify OTP - $e');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getSubscriberInfo() async {
    if (kDebugMode) {
      print('TravelSimAPI: Getting subscriber info');
      print('URL: ${_apiClient.baseUrl}/subscriber');
    }
    
    try {
      final response = await _apiClient.get('/subscriber');
      
      if (kDebugMode) {
        print('TravelSimAPI: Subscriber info retrieved successfully');
        print('Response keys: ${response.keys}');
      }
      
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('TravelSimAPI: Failed to get subscriber info - $e');
      }
      rethrow;
    }
  }

}