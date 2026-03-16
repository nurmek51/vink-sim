import 'package:equatable/equatable.dart';

class PaymentInitiateResult {
  final String paymentId;
  final String checkoutUrl;
  final String? invoiceId;
  final String? backLink;
  final String? failureBackLink;

  const PaymentInitiateResult({
    required this.paymentId,
    required this.checkoutUrl,
    this.invoiceId,
    this.backLink,
    this.failureBackLink,
  });
}

class PaymentStatusResult {
  final String paymentId;
  final String status;
  final String? invoiceId;

  const PaymentStatusResult({
    required this.paymentId,
    required this.status,
    this.invoiceId,
  });
}

class SavedCard extends Equatable {
  final String id;
  final String cardMask;
  final String? cardType;
  final String? payerName;
  final String? createdDate;

  const SavedCard({
    required this.id,
    required this.cardMask,
    this.cardType,
    this.payerName,
    this.createdDate,
  });

  @override
  List<Object?> get props => [id, cardMask, cardType, payerName, createdDate];
}

class RecurrentPaymentResult {
  final String paymentId;
  final String? invoiceId;
  final String status;
  final bool requires3ds;

  const RecurrentPaymentResult({
    required this.paymentId,
    this.invoiceId,
    required this.status,
    required this.requires3ds,
  });
}

abstract class PaymentRepository {
  Future<PaymentInitiateResult> initiatePayment({
    required int amount,
    String? imsi,
    bool saveCard = false,
    String? paymentMethod,
    String language = 'rus',
  });

  Future<PaymentStatusResult> getPaymentStatus(
    String paymentId, {
    bool sync = true,
  });

  Future<List<SavedCard>> getSavedCards();

  Future<void> deleteSavedCard(String cardId);

  Future<RecurrentPaymentResult> recurrentPayment({
    required String imsi,
    required String cardId,
    required int amount,
    String currency = 'KZT',
  });
}
