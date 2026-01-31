import 'package:vink_sim/core/network/api_client.dart';

class TravelSimApiService {
  final ApiClient _apiClient;

  TravelSimApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Map<String, dynamic>> sendOtpSms(String phone) async {
    return await _apiClient.post(
      '/otp/whatsapp',
      body: {'phone_number': phone},
    );
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String code) async {
    return await _apiClient.post(
      '/otp/verify',
      body: {'phone_number': phone, 'otp_code': code},
    );
  }

  Future<Map<String, dynamic>> getSubscriberInfo() async {
    return await _apiClient.get('/subscriber');
  }

  Future<Map<String, dynamic>> topUpBalance({
    required int amount,
    required String imsi,
  }) async {
    return await _apiClient.post(
      '/user/balance/top-up',
      body: {'amount': amount, 'imsi': imsi},
    );
  }

  Future<Map<String, dynamic>> purchaseEsim({
    String? tariffId,
    int? amount,
  }) async {
    return await _apiClient.post(
      '/esims/purchase',
      body: {
        if (tariffId != null) 'tariff_id': tariffId,
        if (amount != null) 'amount': amount,
      },
    );
  }
}
