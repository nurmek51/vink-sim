import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// State
class TopUpBalanceState extends Equatable {
  final int amount;
  final bool autoTopUpEnabled;
  final String selectedPaymentMethod;

  const TopUpBalanceState({
    this.amount = 0,
    this.autoTopUpEnabled = true,
    this.selectedPaymentMethod = '',
  });

  TopUpBalanceState copyWith({
    int? amount,
    bool? autoTopUpEnabled,
    String? selectedPaymentMethod,
  }) {
    return TopUpBalanceState(
      amount: amount ?? this.amount,
      autoTopUpEnabled: autoTopUpEnabled ?? this.autoTopUpEnabled,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }

  @override
  List<Object?> get props => [amount, autoTopUpEnabled, selectedPaymentMethod];
}

// Cubit
class TopUpBalanceCubit extends Cubit<TopUpBalanceState> {
  TopUpBalanceCubit() : super(const TopUpBalanceState());

  void setAmount(int amount) {
    emit(state.copyWith(amount: amount));
  }

  void increment() {
    emit(state.copyWith(amount: state.amount + 1));
  }

  void decrement() {
    if (state.amount > 0) {
      emit(state.copyWith(amount: state.amount - 1));
    }
  }

  void toggleAutoTopUp(bool value) {
    emit(state.copyWith(autoTopUpEnabled: value));
  }

  void selectPaymentMethod(String method) {
    emit(state.copyWith(selectedPaymentMethod: method));
  }
}
