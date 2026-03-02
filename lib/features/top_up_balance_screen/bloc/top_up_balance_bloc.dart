import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vink_sim/core/models/imsi_model.dart';
import 'package:vink_sim/features/payment/domain/repositories/payment_repository.dart';

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

class LoadSavedCards extends TopUpBalanceEvent {
  const LoadSavedCards();
}

class SelectSavedCard extends TopUpBalanceEvent {
  final SavedCard savedCard;

  const SelectSavedCard(this.savedCard);

  @override
  List<Object?> get props => [savedCard];
}

// State
class TopUpBalanceState extends Equatable {
  final int amount;
  final bool autoTopUpEnabled;
  final String selectedPaymentMethod;
  final ImsiModel? selectedSimCard;
  final List<SavedCard> savedCards;
  final SavedCard? selectedSavedCard;
  final bool isSavedCardsLoading;
  final bool hasSavedCardsLoaded;

  const TopUpBalanceState({
    this.amount = 15,
    this.autoTopUpEnabled = false,
    this.selectedPaymentMethod = 'credit_card',
    this.selectedSimCard,
    this.savedCards = const [],
    this.selectedSavedCard,
    this.isSavedCardsLoading = false,
    this.hasSavedCardsLoaded = false,
  });

  TopUpBalanceState copyWith({
    int? amount,
    bool? autoTopUpEnabled,
    String? selectedPaymentMethod,
    ImsiModel? selectedSimCard,
    List<SavedCard>? savedCards,
    SavedCard? selectedSavedCard,
    bool? isSavedCardsLoading,
    bool? hasSavedCardsLoaded,
  }) {
    return TopUpBalanceState(
      amount: amount ?? this.amount,
      autoTopUpEnabled: autoTopUpEnabled ?? this.autoTopUpEnabled,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      selectedSimCard: selectedSimCard ?? this.selectedSimCard,
      savedCards: savedCards ?? this.savedCards,
      selectedSavedCard: selectedSavedCard ?? this.selectedSavedCard,
      isSavedCardsLoading: isSavedCardsLoading ?? this.isSavedCardsLoading,
      hasSavedCardsLoaded: hasSavedCardsLoaded ?? this.hasSavedCardsLoaded,
    );
  }

  @override
  List<Object?> get props => [
        amount,
        autoTopUpEnabled,
        selectedPaymentMethod,
        selectedSimCard,
        savedCards,
        selectedSavedCard,
        isSavedCardsLoading,
        hasSavedCardsLoaded,
      ];
}

// Bloc
class TopUpBalanceBloc extends Bloc<TopUpBalanceEvent, TopUpBalanceState> {
  final PaymentRepository _paymentRepository;

  TopUpBalanceBloc({required PaymentRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        super(const TopUpBalanceState()) {
    on<SetAmount>(_onSetAmount);
    on<IncrementAmount>(_onIncrementAmount);
    on<DecrementAmount>(_onDecrementAmount);
    on<ToggleAutoTopUp>(_onToggleAutoTopUp);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<SelectSimCard>(_onSelectSimCard);
    on<ResetState>(_onResetState);
    on<InitializeWithImsi>(_onInitializeWithImsi);
    on<LoadSavedCards>(_onLoadSavedCards);
    on<SelectSavedCard>(_onSelectSavedCard);
  }

  void _onSetAmount(SetAmount event, Emitter<TopUpBalanceState> emit) {
    emit(state.copyWith(amount: event.amount));
  }

  void _onIncrementAmount(
    IncrementAmount event,
    Emitter<TopUpBalanceState> emit,
  ) {
    emit(state.copyWith(amount: state.amount + 1));
  }

  void _onDecrementAmount(
    DecrementAmount event,
    Emitter<TopUpBalanceState> emit,
  ) {
    if (state.amount > 0) {
      emit(state.copyWith(amount: state.amount - 1));
    }
  }

  void _onToggleAutoTopUp(
    ToggleAutoTopUp event,
    Emitter<TopUpBalanceState> emit,
  ) {
    emit(state.copyWith(autoTopUpEnabled: event.enabled));
  }

  void _onSelectPaymentMethod(
    SelectPaymentMethod event,
    Emitter<TopUpBalanceState> emit,
  ) {
    emit(state.copyWith(selectedPaymentMethod: event.method));

    if (event.method == 'credit_card' &&
        !state.hasSavedCardsLoaded &&
        !state.isSavedCardsLoading) {
      add(const LoadSavedCards());
    }
  }

  void _onSelectSimCard(SelectSimCard event, Emitter<TopUpBalanceState> emit) {
    emit(state.copyWith(selectedSimCard: event.simCard));
  }

  void _onResetState(ResetState event, Emitter<TopUpBalanceState> emit) {
    emit(const TopUpBalanceState());
  }

  void _onInitializeWithImsi(
    InitializeWithImsi event,
    Emitter<TopUpBalanceState> emit,
  ) {
    if (event.imsi != null && event.simCards.isNotEmpty) {
      final simCard = event.simCards.firstWhere(
        (sim) => sim.imsi == event.imsi,
        orElse: () => event.simCards.first,
      );
      emit(state.copyWith(selectedSimCard: simCard));
    }
  }

  Future<void> _onLoadSavedCards(
    LoadSavedCards event,
    Emitter<TopUpBalanceState> emit,
  ) async {
    if (state.isSavedCardsLoading) {
      return;
    }

    emit(
      state.copyWith(
        isSavedCardsLoading: true,
      ),
    );

    try {
      final cards = await _paymentRepository.getSavedCards();
      final selectedCard = state.selectedSavedCard != null &&
              cards.any((card) => card.id == state.selectedSavedCard!.id)
          ? cards.firstWhere(
              (card) => card.id == state.selectedSavedCard!.id,
            )
          : (cards.isNotEmpty ? cards.first : null);

      emit(
        state.copyWith(
          savedCards: cards,
          selectedSavedCard: selectedCard,
          isSavedCardsLoading: false,
          hasSavedCardsLoaded: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          savedCards: const [],
          isSavedCardsLoading: false,
          hasSavedCardsLoaded: true,
        ),
      );
    }
  }

  void _onSelectSavedCard(
    SelectSavedCard event,
    Emitter<TopUpBalanceState> emit,
  ) {
    emit(state.copyWith(selectedSavedCard: event.savedCard));
  }
}
