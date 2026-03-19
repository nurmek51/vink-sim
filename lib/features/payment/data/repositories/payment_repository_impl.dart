import 'package:vink_sim/core/network/travel_sim_api_service.dart';
import 'package:vink_sim/features/payment/domain/repositories/payment_repository.dart';
import 'package:flutter/foundation.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final TravelSimApiService _apiService;

  PaymentRepositoryImpl(this._apiService);

  @override
  Future<PaymentInitiateResult> initiatePayment({
    required int amount,
    String? imsi,
    bool saveCard = false,
    String? paymentMethod,
    String language = 'rus',
  }) async {
    try {
      final response = await _apiService.initiatePayment(
        amount: amount,
        imsi: imsi,
        saveCard: saveCard,
        paymentMethod: paymentMethod,
        language: language,
      );

      if (kDebugMode) {
        print('PaymentRepository: Initiate response: $response');
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid initiate payment response');
      }

      final paymentId = data['payment_id']?.toString();
      final checkoutUrl = data['checkout_url']?.toString();
      final invoiceId = data['invoice_id']?.toString();
      final backLink = data['back_link']?.toString();
      final failureBackLink = data['failure_back_link']?.toString();

      if (paymentId == null || paymentId.isEmpty) {
        throw Exception('Missing payment_id in initiate response');
      }
      if (checkoutUrl == null || checkoutUrl.isEmpty) {
        throw Exception('Missing checkout_url in initiate response');
      }

      return PaymentInitiateResult(
        paymentId: paymentId,
        checkoutUrl: checkoutUrl,
        invoiceId: invoiceId,
        backLink: backLink,
        failureBackLink: failureBackLink,
      );
    } catch (e) {
      if (kDebugMode) {
        print('PaymentRepository: Initiate failed: $e');
      }
      rethrow;
    }
  }

  @override
  Future<PaymentStatusResult> getPaymentStatus(
    String paymentId, {
    bool sync = true,
  }) async {
    try {
      final response =
          await _apiService.getPaymentStatus(paymentId, sync: sync);

      if (kDebugMode) {
        print('PaymentRepository: Status response: $response');
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid payment status response');
      }

      final status = data['status']?.toString();
      final responsePaymentId = data['payment_id']?.toString() ?? paymentId;
      final invoiceId = data['invoice_id']?.toString();

      if (status == null || status.isEmpty) {
        throw Exception('Missing status in payment status response');
      }

      return PaymentStatusResult(
        paymentId: responsePaymentId,
        status: status,
        invoiceId: invoiceId,
      );
    } catch (e) {
      if (kDebugMode) {
        print('PaymentRepository: Status failed: $e');
      }
      rethrow;
    }
  }

  @override
  Future<List<SavedCard>> getSavedCards() async {
    try {
      final response = await _apiService.getSavedCards();
      final data = response['data'];

      if (data is! List) {
        return const [];
      }

      return data
          .whereType<Map<String, dynamic>>()
          .map(
            (card) => SavedCard(
              id: card['id']?.toString() ?? '',
              cardMask: card['card_mask']?.toString() ?? '',
              cardType: card['card_type']?.toString(),
              payerName: card['payer_name']?.toString(),
              createdDate: card['created_date']?.toString(),
            ),
          )
          .where((card) => card.id.isNotEmpty)
          .toList(growable: false);
    } catch (e) {
      if (kDebugMode) {
        print('PaymentRepository: Get saved cards failed: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> deleteSavedCard(String cardId) async {
    try {
      await _apiService.deleteSavedCard(cardId);
    } catch (e) {
      if (kDebugMode) {
        print('PaymentRepository: Delete saved card failed: $e');
      }
      rethrow;
    }
  }

  @override
  Future<RecurrentPaymentResult> recurrentPayment({
    String? imsi,
    String? esimId,
    required String cardId,
    required int amount,
    String currency = 'USD',
    String description = 'Subscription',
  }) async {
    try {
      final response = await _apiService.recurrentPayment(
        imsi: imsi,
        esimId: esimId,
        cardId: cardId,
        amount: amount,
        currency: currency,
        description: description,
      );

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid recurrent payment response');
      }

      final paymentId = data['payment_id']?.toString();
      final status = data['status']?.toString();
      final invoiceId = data['invoice_id']?.toString();
      final requires3ds = data['requires_3ds'] == true;

      if (paymentId == null || paymentId.isEmpty) {
        throw Exception('Missing payment_id in recurrent response');
      }

      if (status == null || status.isEmpty) {
        throw Exception('Missing status in recurrent response');
      }

      return RecurrentPaymentResult(
        paymentId: paymentId,
        invoiceId: invoiceId,
        status: status,
        requires3ds: requires3ds,
      );
    } catch (e) {
      if (kDebugMode) {
        print('PaymentRepository: Recurrent payment failed: $e');
      }
      rethrow;
    }
  }
}
