import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_travel_sim/core/models/imsi_model.dart';

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

class SelectSimCard extends TopUpBalanceEvent {
  final ImsiModel simCard;
  
  const SelectSimCard(this.simCard);
  
  @override
  List<Object?> get props => [simCard];
}

class InitializeWithImsi extends TopUpBalanceEvent {
  final String? imsi;
  final List<ImsiModel> simCards;
  
  const InitializeWithImsi(this.imsi, this.simCards);
  
  @override
  List<Object?> get props => [imsi, simCards];
}

// State
class TopUpBalanceState extends Equatable {
  final int amount;
  final bool autoTopUpEnabled;
  final String selectedPaymentMethod;
  final ImsiModel? selectedSimCard;

  const TopUpBalanceState({
    this.amount = 0,
    this.autoTopUpEnabled = false,
    this.selectedPaymentMethod = 'apple_pay',
    this.selectedSimCard,
  });

  TopUpBalanceState copyWith({
    int? amount,
    bool? autoTopUpEnabled,
    String? selectedPaymentMethod,
    ImsiModel? selectedSimCard,
  }) {
    return TopUpBalanceState(
      amount: amount ?? this.amount,
      autoTopUpEnabled: autoTopUpEnabled ?? this.autoTopUpEnabled,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      selectedSimCard: selectedSimCard ?? this.selectedSimCard,
    );
  }

  @override
  List<Object?> get props => [amount, autoTopUpEnabled, selectedPaymentMethod, selectedSimCard];
}

// Bloc
class TopUpBalanceBloc extends Bloc<TopUpBalanceEvent, TopUpBalanceState> {
  TopUpBalanceBloc() : super(const TopUpBalanceState()) {
    on<SetAmount>(_onSetAmount);
    on<IncrementAmount>(_onIncrementAmount);
    on<DecrementAmount>(_onDecrementAmount);
    on<ToggleAutoTopUp>(_onToggleAutoTopUp);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<SelectSimCard>(_onSelectSimCard);
    on<ResetState>(_onResetState);
    on<InitializeWithImsi>(_onInitializeWithImsi);
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

  void _onSelectSimCard(SelectSimCard event, Emitter<TopUpBalanceState> emit) {
    emit(state.copyWith(selectedSimCard: event.simCard));
  }

  void _onResetState(ResetState event, Emitter<TopUpBalanceState> emit) {
    emit(const TopUpBalanceState());
  }

  void _onInitializeWithImsi(InitializeWithImsi event, Emitter<TopUpBalanceState> emit) {
    if (event.imsi != null && event.simCards.isNotEmpty) {
      final simCard = event.simCards.firstWhere(
        (sim) => sim.imsi == event.imsi,
        orElse: () => event.simCards.first,
      );
      emit(state.copyWith(selectedSimCard: simCard));
    }
  }
}
