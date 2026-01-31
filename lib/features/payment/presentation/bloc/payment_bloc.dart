import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vink_sim/features/payment/domain/repositories/payment_repository.dart';

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

  const PaymentRequested({
    required this.amount,
    required this.context,
    required this.operationType,
    this.imsi,
  });

  @override
  List<Object?> get props => [amount, operationType, imsi];
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

class PaymentCancelled extends PaymentState {}

class PaymentSuccess extends PaymentState {}

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

  PaymentBloc({required PaymentRepository paymentRepository})
    : _paymentRepository = paymentRepository,
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
      emit: emit,
    );
  }

  Future<void> _processPayment({
    required int amount,
    String? imsi,
    required PaymentOperationType operationType,
    required Emitter<PaymentState> emit,
  }) async {
    emit(PaymentLoading());

    try {
      if (kDebugMode) {
        print('PaymentBloc: Processing payment for \$$amount');
        print('PaymentBloc: IMSI: $imsi');
        print('PaymentBloc: Operation: $operationType');
      }

      bool success = false;
      if (operationType == PaymentOperationType.newImsi || imsi == null) {
        // Purchase new eSIM
        success = await _paymentRepository.purchaseEsim(amount: amount);
      } else {
        // Top up existing balance
        success = await _paymentRepository.topUpBalance(amount, imsi);
      }

      if (success) {
        if (kDebugMode) {
          print('PaymentBloc: Payment successful');
        }
        emit(PaymentSuccess());
      } else {
        emit(const PaymentFailure('Payment failed'));
      }
    } catch (e) {
      if (kDebugMode) {
        print('PaymentBloc: Error: $e');
      }
      emit(PaymentFailure(e.toString()));
    }
  }
}
