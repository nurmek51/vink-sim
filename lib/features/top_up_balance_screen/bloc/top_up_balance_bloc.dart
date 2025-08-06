import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class TopUpBalanceEvent extends Equatable {
  const TopUpBalanceEvent();

  @override
  List<Object?> get props => [];
}

class SetAmount extends TopUpBalanceEvent {
  final int amount;
  
  const SetAmount(this.amount);
  
  @override
  List<Object?> get props => [amount];
}

class IncrementAmount extends TopUpBalanceEvent {
  const IncrementAmount();
}

class DecrementAmount extends TopUpBalanceEvent {
  const DecrementAmount();
}

class ToggleAutoTopUp extends TopUpBalanceEvent {
  final bool enabled;
  
  const ToggleAutoTopUp(this.enabled);
  
  @override
  List<Object?> get props => [enabled];
}

class SelectPaymentMethod extends TopUpBalanceEvent {
  final String method;
  
  const SelectPaymentMethod(this.method);
  
  @override
  List<Object?> get props => [method];
}

class ResetState extends TopUpBalanceEvent {
  const ResetState();
}

// State
class TopUpBalanceState extends Equatable {
  final int amount;
  final bool autoTopUpEnabled;
  final String selectedPaymentMethod;

  const TopUpBalanceState({
    this.amount = 0,
    this.autoTopUpEnabled = true,
    this.selectedPaymentMethod = 'apple_pay',
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

// Bloc
class TopUpBalanceBloc extends Bloc<TopUpBalanceEvent, TopUpBalanceState> {
  TopUpBalanceBloc() : super(const TopUpBalanceState()) {
    on<SetAmount>(_onSetAmount);
    on<IncrementAmount>(_onIncrementAmount);
    on<DecrementAmount>(_onDecrementAmount);
    on<ToggleAutoTopUp>(_onToggleAutoTopUp);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<ResetState>(_onResetState);
  }

  void _onSetAmount(SetAmount event, Emitter<TopUpBalanceState> emit) {
    emit(state.copyWith(amount: event.amount));
  }

  void _onIncrementAmount(IncrementAmount event, Emitter<TopUpBalanceState> emit) {
    emit(state.copyWith(amount: state.amount + 1));
  }

  void _onDecrementAmount(DecrementAmount event, Emitter<TopUpBalanceState> emit) {
    if (state.amount > 0) {
      emit(state.copyWith(amount: state.amount - 1));
    }
  }

  void _onToggleAutoTopUp(ToggleAutoTopUp event, Emitter<TopUpBalanceState> emit) {
    emit(state.copyWith(autoTopUpEnabled: event.enabled));
  }

  void _onSelectPaymentMethod(SelectPaymentMethod event, Emitter<TopUpBalanceState> emit) {
    emit(state.copyWith(selectedPaymentMethod: event.method));
  }

  void _onResetState(ResetState event, Emitter<TopUpBalanceState> emit) {
    emit(const TopUpBalanceState());
  }
}
