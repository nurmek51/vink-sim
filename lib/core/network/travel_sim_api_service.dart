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

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    return await _apiClient.post(
      '/token/refresh',
      body: {'refresh_token': refreshToken},
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

  Future<Map<String, dynamic>> initiatePayment({
    required int amount,
    String? imsi,
    bool saveCard = false,
    String? paymentMethod,
    String language = 'rus',
  }) async {
    return await _apiClient.post(
      '/payments/initiate',
      body: {
        'amount': amount,
        if (imsi != null) 'imsi': imsi,
        'save_card': saveCard,
        if (paymentMethod != null) 'payment_method': paymentMethod,
        'language': language,
      },
    );
  }

  Future<Map<String, dynamic>> getPaymentStatus(
    String paymentId, {
    bool sync = true,
  }) async {
    return await _apiClient.get(
      '/payments/status/$paymentId',
      queryParameters: {'sync': sync},
    );
  }

  Future<Map<String, dynamic>> getSavedCards() async {
    return await _apiClient.get('/payments/saved-cards');
  }

  Future<Map<String, dynamic>> deleteSavedCard(String cardId) async {
    return await _apiClient.delete('/payments/saved-cards/$cardId');
  }

  Future<Map<String, dynamic>> recurrentPayment({
    String? imsi,
    String? esimId,
    required String cardId,
    required int amount,
    String currency = 'USD',
    String description = 'Subscription',
  }) async {
    if ((imsi == null || imsi.isEmpty) && (esimId == null || esimId.isEmpty)) {
      throw ArgumentError('Either imsi or esimId must be provided');
    }

    return await _apiClient.post(
      '/payments/recurrent',
      body: {
        if (imsi != null && imsi.isNotEmpty) 'imsi': imsi,
        if (esimId != null && esimId.isNotEmpty) 'esim_id': esimId,
        'card_id': cardId,
        'amount': amount,
        'description': description,
        'currency': currency,
      },
    );
  }
}
