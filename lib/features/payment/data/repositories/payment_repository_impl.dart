import 'package:vink_sim/core/network/travel_sim_api_service.dart';
import 'package:vink_sim/features/payment/domain/repositories/payment_repository.dart';
import 'package:flutter/foundation.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final TravelSimApiService _apiService;

  PaymentRepositoryImpl(this._apiService);

  @override
  Future<bool> topUpBalance(int amount, String imsi) async {
    try {
      final response = await _apiService.topUpBalance(
        amount: amount,
        imsi: imsi,
      );

      if (kDebugMode) {
        print('PaymentRepository: Top up response: $response');
      }

      return response['success'] == true;
    } catch (e) {
      if (kDebugMode) {
        print('PaymentRepository: Top up failed: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> purchaseEsim({String? tariffId, int? amount}) async {
    try {
      final response = await _apiService.purchaseEsim(
        tariffId: tariffId,
        amount: amount,
      );

      if (kDebugMode) {
        print('PaymentRepository: Purchase response: $response');
      }

      // Check if success or if it returns data. Usually /purchase returns 200 with data.
      return response != null;
    } catch (e) {
      if (kDebugMode) {
        print('PaymentRepository: Purchase failed: $e');
      }
      rethrow;
    }
  }
}
