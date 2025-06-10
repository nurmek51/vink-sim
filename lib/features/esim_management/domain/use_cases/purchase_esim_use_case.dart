import 'package:flex_travel_sim/core/error/failures.dart';
import 'package:flex_travel_sim/features/esim_management/domain/entities/esim.dart';
import 'package:flex_travel_sim/features/esim_management/domain/repositories/esim_repository.dart';

class PurchaseEsimUseCase {
  final EsimRepository repository;

  PurchaseEsimUseCase(this.repository);

  Future<Either<Failure, Esim>> call(String tariffId, Map<String, dynamic> paymentData) async {
    if (tariffId.isEmpty) {
      return const Left(ValidationFailure('Tariff ID cannot be empty'));
    }

    if (paymentData.isEmpty) {
      return const Left(ValidationFailure('Payment data cannot be empty'));
    }

    // Validate payment data
    final validationResult = _validatePaymentData(paymentData);
    if (validationResult != null) {
      return Left(ValidationFailure(validationResult));
    }

    return await repository.purchaseEsim(tariffId, paymentData);
  }

  String? _validatePaymentData(Map<String, dynamic> paymentData) {
    if (!paymentData.containsKey('amount')) {
      return 'Payment amount is required';
    }

    if (!paymentData.containsKey('currency')) {
      return 'Payment currency is required';
    }

    if (!paymentData.containsKey('payment_method')) {
      return 'Payment method is required';
    }

    final amount = paymentData['amount'];
    if (amount is! num || amount <= 0) {
      return 'Payment amount must be a positive number';
    }

    return null;
  }
}
