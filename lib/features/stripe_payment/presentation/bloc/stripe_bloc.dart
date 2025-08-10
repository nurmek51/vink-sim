import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_travel_sim/features/stripe_payment/services/stripe_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Events
abstract class StripeEvent extends Equatable {
  const StripeEvent();

  @override
  List<Object?> get props => [];
}

class StripePaymentRequested extends StripeEvent {
  final int amount;
  final String currency;
  final BuildContext context;
  final StripeOperationType operationType;
  final String? imsi;  

  const StripePaymentRequested({
    required this.amount,
    this.currency = 'usd',
    required this.context,
    required this.operationType,
    this.imsi,
  });

  @override
  List<Object?> get props => [amount, currency];
}

class GooglePayPaymentRequested extends StripeEvent {
  final int amount;
  final String currency;
  final BuildContext context;
  final StripeOperationType operationType;
  final String? imsi;  

  const GooglePayPaymentRequested({
    required this.amount,
    this.currency = 'usd',
    required this.context,
    required this.operationType,
    this.imsi,
  });

  @override
  List<Object?> get props => [amount, currency];
}

class StripeReset extends StripeEvent {
  const StripeReset();
}

class WebPaymentConfirmed extends StripeEvent {
  final String clientSecret;
  final String returnUrl;
  const WebPaymentConfirmed({
    required this.clientSecret,
    required this.returnUrl,
  });
  @override
  List<Object?> get props => [clientSecret, returnUrl];
}

// States
abstract class StripeState extends Equatable {
  const StripeState();

  @override
  List<Object?> get props => [];
}

class StripeInitial extends StripeState {}

class StripeLoading extends StripeState {}

class StripeCancelled extends StripeState {}

class StripeRedirected extends StripeState {}

class StripeSuccess extends StripeState {}

class StripeFailure extends StripeState {
  final String error;

  const StripeFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Bloc
class StripeBloc extends Bloc<StripeEvent, StripeState> {
  final StripeService stripeService;

  StripeBloc({required this.stripeService}) : super(StripeInitial()) {
    on<StripePaymentRequested>(_onPaymentRequested);
    on<GooglePayPaymentRequested>(_onGooglePayRequested);
    on<WebPaymentConfirmed>(_onWebPaymentConfirmed);
    on<StripeReset>((event, emit) => emit(StripeInitial()));
  }

  Future<void> _onPaymentRequested(
    StripePaymentRequested event,
    Emitter<StripeState> emit,
  ) async {
    emit(StripeLoading());

    try {
      final result = await stripeService.makePayment(
        amount: event.amount,
        currency: event.currency,
        context: event.context,
        operationType: event.operationType,
        imsi: event.imsi,
      );

      switch (result) {
        case StripePaymentResult.success:
          if (kDebugMode) print('StripeBloc: SUCCESS!');
          emit(StripeSuccess());
          break;
        case StripePaymentResult.cancelled:
          if (kDebugMode) print('StripeBloc: CANCELLED!');
          emit(StripeCancelled());
          break;
        case StripePaymentResult.failure:
          if (kDebugMode) print('StripeBloc: FAILURE!');
          emit(const StripeFailure('Payment failed'));
          break;
        case StripePaymentResult.redirectedToWeb:
          emit(StripeRedirected()); 
          break;          
      }
    } catch (e) {
      if (kDebugMode) print('StripeBloc error: $e');
      emit(StripeFailure(e.toString()));
    }
  }
  
  Future<void> _onGooglePayRequested(
    GooglePayPaymentRequested event,
    Emitter<StripeState> emit,
  ) async {
    emit(StripeLoading());

    try {
      final result = await stripeService.makeGooglePayOnlyPayment(
        amount: event.amount,
        currency: event.currency, 
        operationType: event.operationType,
        imsi: event.imsi,
      );

      switch (result) {
        case StripePaymentResult.success:
          if (kDebugMode) print('GPay: SUCCESS!');
          emit(StripeSuccess());
          break;
        case StripePaymentResult.cancelled:
          if (kDebugMode) print('GPay: CANCELLED!');
          emit(StripeCancelled());
          break;
        case StripePaymentResult.failure:
          if (kDebugMode) print('GPay: FAILURE!');
          emit(const StripeFailure('Google Pay оплата не удалась'));
          break;
        case StripePaymentResult.redirectedToWeb:
          emit(StripeRedirected()); 
          break;
          
      }
    } catch (e) {
      if (kDebugMode) print('GPay error: $e');
      emit(StripeFailure(e.toString()));
    }
  }
  
  Future<void> _onWebPaymentConfirmed(
    WebPaymentConfirmed event,
    Emitter<StripeState> emit,
  ) async {
    emit(StripeLoading());
    final result = await stripeService.confirmWebPayment(
      clientSecret: event.clientSecret,
      returnUrl: event.returnUrl,
    );
    switch (result) {
      case StripePaymentResult.success:
        emit(StripeSuccess());
        break;
      case StripePaymentResult.cancelled:
        emit(StripeCancelled());
        break;
      default:
        emit(const StripeFailure('Ошибка веб‑оплаты'));
    }
  }


}