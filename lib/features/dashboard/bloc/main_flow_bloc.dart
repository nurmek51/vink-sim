import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class MainFlowEvent extends Equatable {
  const MainFlowEvent();

  @override
  List<Object?> get props => [];
}

class PageChangedEvent extends MainFlowEvent {
  final int pageIndex;

  const PageChangedEvent(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

class ShowBottomSheetEvent extends MainFlowEvent {}

class HideBottomSheetEvent extends MainFlowEvent {}

class UpdateCircleBalanceEvent extends MainFlowEvent {
  final int circleIndex;
  final double addedAmount;
  const UpdateCircleBalanceEvent({
    required this.circleIndex,
    required this.addedAmount,
  });

  @override
  List<Object?> get props => [circleIndex, addedAmount];
}

enum BalanceLevel { low, medium, high }

class AddCircleEvent extends MainFlowEvent {
  final BalanceLevel level;
  const AddCircleEvent(this.level);

  @override
  List<Object?> get props => [level];
}

// States
class MainFlowState extends Equatable {
  final int currentPage;
  final List<double> progressValues;
  final bool isBottomSheetVisible;
  final List<double> moneyBalance;

  const MainFlowState({
    this.currentPage = 0,
    this.progressValues = const [0.40, 0],
    this.isBottomSheetVisible = false,
    this.moneyBalance = const [0.0, 0.0],
  });

  MainFlowState copyWith({
    int? currentPage,
    List<double>? progressValues,
    List<double>? moneyBalance,
    bool? isBottomSheetVisible,
  }) {
    return MainFlowState(
      currentPage: currentPage ?? this.currentPage,
      progressValues: progressValues ?? this.progressValues,
      moneyBalance: moneyBalance ?? this.moneyBalance,
      isBottomSheetVisible: isBottomSheetVisible ?? this.isBottomSheetVisible,
    );
  }

  @override
  List<Object?> get props => [
    currentPage,
    progressValues,
    isBottomSheetVisible,
  ];
}

// Bloc
class MainFlowBloc extends Bloc<MainFlowEvent, MainFlowState> {
  static const double maxGB = 25.0;
  static const int maxCircles = 10;

  MainFlowBloc() : super(const MainFlowState()) {
    on<PageChangedEvent>(_onPageChanged);
    on<ShowBottomSheetEvent>(_onShowBottomSheet);
    on<HideBottomSheetEvent>(_onHideBottomSheet);
    on<AddCircleEvent>(_onAddCircle);
    on<UpdateCircleBalanceEvent>(_onUpdateCircleBalanceEvent);
  }

  void _onPageChanged(PageChangedEvent event, Emitter<MainFlowState> emit) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }

  void _onShowBottomSheet(
    ShowBottomSheetEvent event,
    Emitter<MainFlowState> emit,
  ) {
    emit(state.copyWith(isBottomSheetVisible: true));
  }

  void _onHideBottomSheet(
    HideBottomSheetEvent event,
    Emitter<MainFlowState> emit,
  ) {
    emit(state.copyWith(isBottomSheetVisible: false));
  }

  void _onAddCircle(AddCircleEvent event, Emitter<MainFlowState> emit) { 
    final List<double> updatedProgressValues = List.of(state.progressValues);
    final List<double> updatedMoneyBalance = List.of(state.moneyBalance);
    if (updatedProgressValues.length >= maxCircles - 1) return;

    double newValue;
    switch (event.level) {
      case BalanceLevel.low:
        newValue = 0.0;
        break;
      case BalanceLevel.medium:
        newValue = 0.6;
        break;
      case BalanceLevel.high:
        newValue = 15.0;
        break;
    }

    updatedProgressValues.insert(updatedProgressValues.length, newValue);
    updatedMoneyBalance.insert(updatedMoneyBalance.length, 0.0); 

    emit(state.copyWith(
      progressValues: updatedProgressValues,
      moneyBalance: updatedMoneyBalance,
    ));
  }

  void _onUpdateCircleBalanceEvent(
    UpdateCircleBalanceEvent event,
    Emitter<MainFlowState> emit,
  ) {
    final List<double> updatedProgressValues = List.from(state.progressValues);
    final List<double> updatedMoneyBalances = List.from(state.moneyBalance);

    if (event.circleIndex >= 0 &&
        event.circleIndex < updatedProgressValues.length) {
      updatedMoneyBalances[event.circleIndex] += event.addedAmount;
      const double gbPerDollar = 1.0 / 15.0;
      final double addedGb = event.addedAmount * gbPerDollar;

      final double newGbValue =
          updatedProgressValues[event.circleIndex] + addedGb;
      updatedProgressValues[event.circleIndex] = newGbValue;

      emit(
        state.copyWith(
          progressValues: updatedProgressValues,
          moneyBalance: updatedMoneyBalances,
        ),
      );
    }
  }  
}
