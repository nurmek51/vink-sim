import 'package:flex_travel_sim/core/network/travel_sim_api_service.dart';
import 'package:flex_travel_sim/core/models/otp_response_model.dart';
import 'package:flutter/foundation.dart';

abstract class OtpAuthDataSource {
  Future<void> sendOtpSms(String phone);
  Future<OtpResponseModel> verifyOtp(String phone, String code);
}

class OtpAuthDataSourceImpl implements OtpAuthDataSource {
  final TravelSimApiService _travelSimApiService;

  OtpAuthDataSourceImpl({
    required TravelSimApiService travelSimApiService,
  }) : _travelSimApiService = travelSimApiService;

  @override
  Future<void> sendOtpSms(String phone) async {
    try {
      if (kDebugMode) {
        print('OTP: Sending SMS to phone: $phone');
      }

      await _travelSimApiService.sendOtpSms(phone);

      if (kDebugMode) {
        print('OTP: SMS sent successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('OTP: Failed to send SMS - $e');
      }
      throw Exception('Failed to send OTP SMS: $e');
    }
  }

  @override
  Future<OtpResponseModel> verifyOtp(String phone, String code) async {
    try {
      if (kDebugMode) {
        print('OTP: Verifying code for phone: $phone');
      }

      final response = await _travelSimApiService.verifyOtp(phone, code);
      final otpResponse = OtpResponseModel.fromJson(response);

      if (kDebugMode) {
        print('OTP: Verification successful');
        print('Token received: ${otpResponse.token.substring(0, 20)}...');
      }

      return otpResponse;
    } catch (e) {
      if (kDebugMode) {
        print('OTP: Verification failed - $e');
      }
      throw Exception('Failed to verify OTP: $e');
    }
  }
}