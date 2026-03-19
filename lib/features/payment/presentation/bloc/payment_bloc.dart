import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vink_sim/config/feature_config.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/features/payment/domain/repositories/payment_repository.dart';
import 'package:vink_sim/features/payment/presentation/widgets/payment_checkout_webview_screen.dart';

/// Payment operation types for future payment integration
enum PaymentOperationType {
  addFunds,
  newImsi;

  String get operationType {
    switch (this) {
      case PaymentOperationType.addFunds:
        return 'add_funds';
      case PaymentOperationType.newImsi:
        return 'new_imsi';
    }
  }
}

/// Payment result enum
enum PaymentResult { success, cancelled, failure, notImplemented }

// Events
abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class PaymentRequested extends PaymentEvent {
  final int amount;
  final BuildContext context;
  final PaymentOperationType operationType;
  final String? imsi;
  final String? preferredCardId;
  final bool autoTopUpEnabled;

  const PaymentRequested({
    required this.amount,
    required this.context,
    required this.operationType,
    this.imsi,
    this.preferredCardId,
    this.autoTopUpEnabled = false,
  });

  @override
  List<Object?> get props => [
        amount,
        operationType,
        imsi,
        preferredCardId,
        autoTopUpEnabled,
      ];
}

class ApplePayRequested extends PaymentEvent {
  final int amount;
  final BuildContext context;
  final PaymentOperationType operationType;
  final String? imsi;

  const ApplePayRequested({
    required this.amount,
    required this.context,
    required this.operationType,
    this.imsi,
  });

  @override
  List<Object?> get props => [amount, operationType, imsi];
}

class GooglePayRequested extends PaymentEvent {
  final int amount;
  final BuildContext context;
  final PaymentOperationType operationType;
  final String? imsi;

  const GooglePayRequested({
    required this.amount,
    required this.context,
    required this.operationType,
    this.imsi,
  });

  @override
  List<Object?> get props => [amount, operationType, imsi];
}

class PaymentReset extends PaymentEvent {
  const PaymentReset();
}

// States
abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentStatusChecking extends PaymentState {}

class PaymentCancelled extends PaymentState {}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess();
}

class PaymentCompleted extends PaymentSuccess {
  final String paymentId;
  final String status;

  const PaymentCompleted({required this.paymentId, required this.status});

  @override
  List<Object?> get props => [paymentId, status];
}

class PaymentNotImplemented extends PaymentState {
  final String message;

  const PaymentNotImplemented(this.message);

  @override
  List<Object?> get props => [message];
}

class PaymentFailure extends PaymentState {
  final String error;

  const PaymentFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// Mock Payment Bloc - placeholder for future payment integration
///
/// This bloc provides the same interface as the previous Stripe integration
/// but uses the backend API directly to simulate payment success for credits.
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _paymentRepository;
  final String _paymentReturnDeepLinkBase;
  static const Duration _pollInterval = Duration(seconds: 3);
  static const Duration _pollTimeout = Duration(minutes: 10);

  PaymentBloc({required PaymentRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        _paymentReturnDeepLinkBase = sl.isRegistered<FeatureConfig>()
            ? sl<FeatureConfig>().paymentReturnDeepLinkBase
            : 'vinksim://payment-return',
        super(PaymentInitial()) {
    on<PaymentRequested>(_onPaymentRequested);
    on<GooglePayRequested>(_onGooglePayRequested);
    on<ApplePayRequested>(_onApplePayRequested);
    on<PaymentReset>((event, emit) => emit(PaymentInitial()));
  }

  Future<void> _onPaymentRequested(
    PaymentRequested event,
    Emitter<PaymentState> emit,
  ) async {
    await _processPayment(
      amount: event.amount,
      imsi: event.imsi,
      operationType: event.operationType,
      preferRecurrent: event.preferredCardId != null,
      preferredCardId: event.preferredCardId,
      saveCardOnInitiate: event.autoTopUpEnabled,
      paymentMethod: null,
      context: event.context,
      emit: emit,
    );
  }

  Future<void> _onGooglePayRequested(
    GooglePayRequested event,
    Emitter<PaymentState> emit,
  ) async {
    await _processPayment(
      amount: event.amount,
      imsi: event.imsi,
      operationType: event.operationType,
      preferRecurrent: false,
      preferredCardId: null,
      saveCardOnInitiate: false,
      paymentMethod: 'google_pay',
      context: event.context,
      emit: emit,
    );
  }

  Future<void> _onApplePayRequested(
    ApplePayRequested event,
    Emitter<PaymentState> emit,
  ) async {
    await _processPayment(
      amount: event.amount,
      imsi: event.imsi,
      operationType: event.operationType,
      preferRecurrent: false,
      preferredCardId: null,
      saveCardOnInitiate: false,
      paymentMethod: 'apple_pay',
      context: event.context,
      emit: emit,
    );
  }

  Future<void> _processPayment({
    required int amount,
    String? imsi,
    required PaymentOperationType operationType,
    required bool preferRecurrent,
    required String? preferredCardId,
    required bool saveCardOnInitiate,
    required String? paymentMethod,
    required BuildContext context,
    required Emitter<PaymentState> emit,
  }) async {
    emit(PaymentLoading());

    try {
      final language = _resolveLanguage(context);
      final requestImsi =
          operationType == PaymentOperationType.addFunds ? imsi : null;

      if (kDebugMode) {
        print('PaymentBloc: Initiating payment for amount=$amount');
        print('PaymentBloc: imsi=$requestImsi');
        print('PaymentBloc: operation=$operationType');
        print('PaymentBloc: language=$language');
      }

      if (preferRecurrent && requestImsi != null && preferredCardId != null) {
        final recurrentResult = await _tryRecurrentTopUp(
          imsi: requestImsi,
          amount: amount,
          preferredCardId: preferredCardId,
        );

        if (recurrentResult != null) {
          if (_isSuccessStatus(recurrentResult.status)) {
            emit(
              PaymentCompleted(
                paymentId: recurrentResult.paymentId,
                status: recurrentResult.status,
              ),
            );
            return;
          }

          if (_isCancelledStatus(recurrentResult.status)) {
            emit(PaymentCancelled());
            return;
          }
        }
      }

      final initiateResult = await _paymentRepository.initiatePayment(
        amount: amount,
        imsi: requestImsi,
        saveCard: saveCardOnInitiate,
        paymentMethod: paymentMethod,
        language: language,
      );

      final checkoutUri = Uri.tryParse(initiateResult.checkoutUrl);
      if (checkoutUri == null) {
        emit(const PaymentFailure('Invalid checkout URL'));
        return;
      }

      if (kIsWeb) {
        if (kDebugMode) {
          print('PaymentBloc: Web checkout opened in new tab: $checkoutUri');
        }
        final opened = await launchUrl(
          checkoutUri,
          mode: LaunchMode.platformDefault,
          webOnlyWindowName: '_blank',
        );
        if (!opened) {
          emit(const PaymentFailure('Unable to open checkout page'));
          return;
        }
      } else {
        if (!context.mounted) {
          emit(const PaymentFailure('Unable to open checkout page'));
          return;
        }

        final checkoutCloseReason = await PaymentCheckoutWebViewScreen.open(
          context,
          checkoutUrl: checkoutUri.toString(),
          paymentId: initiateResult.paymentId,
          paymentReturnDeepLinkBase: _paymentReturnDeepLinkBase,
          backLink: initiateResult.backLink,
          failureBackLink: initiateResult.failureBackLink,
        );

        if (checkoutCloseReason == PaymentCheckoutCloseReason.userCancelled) {
          emit(PaymentCancelled());
          return;
        }
      }

      emit(PaymentStatusChecking());

      final pollResult = await _pollFinalStatus(initiateResult.paymentId);
      if (pollResult == null) {
        emit(const PaymentFailure('Payment status check timed out'));
        return;
      }

      final normalizedStatus = pollResult.status.toLowerCase();

      if (_isSuccessStatus(normalizedStatus)) {
        if (kDebugMode) {
          print('PaymentBloc: Payment successful. status=$normalizedStatus');
        }
        emit(
          PaymentCompleted(
            paymentId: pollResult.paymentId,
            status: normalizedStatus,
          ),
        );
      } else if (_isCancelledStatus(normalizedStatus)) {
        emit(PaymentCancelled());
      } else {
        emit(PaymentFailure('Payment failed with status: $normalizedStatus'));
      }
    } catch (e) {
      if (kDebugMode) {
        print('PaymentBloc: Error: $e');
      }
      emit(PaymentFailure(e.toString()));
    }
  }

  Future<RecurrentPaymentResult?> _tryRecurrentTopUp({
    required String imsi,
    required int amount,
    String? preferredCardId,
  }) async {
    try {
      if (preferredCardId == null || preferredCardId.isEmpty) {
        return null;
      }

      final recurrentResult = await _paymentRepository.recurrentPayment(
        imsi: imsi,
        cardId: preferredCardId,
        amount: amount,
      );

      return RecurrentPaymentResult(
        paymentId: recurrentResult.paymentId,
        invoiceId: recurrentResult.invoiceId,
        status: recurrentResult.status.toLowerCase(),
        requires3ds: recurrentResult.requires3ds,
      );
    } catch (e) {
      if (kDebugMode) {
        print('PaymentBloc: Recurrent flow failed, fallback to checkout. $e');
      }
      return null;
    }
  }

  Future<PaymentStatusResult?> _pollFinalStatus(String paymentId) async {
    final startedAt = DateTime.now();

    while (DateTime.now().difference(startedAt) < _pollTimeout) {
      final statusResult = await _paymentRepository.getPaymentStatus(
        paymentId,
        sync: true,
      );
      final normalized = statusResult.status.toLowerCase();

      if (_isFinalStatus(normalized)) {
        return statusResult;
      }

      await Future<void>.delayed(_pollInterval);
    }

    return null;
  }

  bool _isFinalStatus(String status) {
    return _isSuccessStatus(status) ||
        _isFailureStatus(status) ||
        _isCancelledStatus(status);
  }

  bool _isSuccessStatus(String status) {
    return status == 'auth' || status == 'charge';
  }

  bool _isFailureStatus(String status) {
    return status == 'failed' || status == 'refund';
  }

  bool _isCancelledStatus(String status) {
    return status == 'cancel';
  }

  String _resolveLanguage(BuildContext context) {
    try {
      final code = Localizations.localeOf(context).languageCode.toLowerCase();
      if (code == 'ru') return 'rus';
      if (code == 'kk' || code == 'kz') return 'kaz';
      return 'eng';
    } catch (_) {
      return 'eng';
    }
  }
}
