import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/features/subscriber/data/data_sources/subscriber_local_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class EsimSetupEvent extends Equatable {
  const EsimSetupEvent();

  @override
  List<Object?> get props => [];
}

class SelectOption extends EsimSetupEvent {
  final int index;
  
  const SelectOption(this.index);
  
  @override
  List<Object?> get props => [index];
}

class ResetSelection extends EsimSetupEvent {
  const ResetSelection();
}

class LoadImsiListLength extends EsimSetupEvent {
  const LoadImsiListLength();
}

// State
abstract class EsimSetupState extends Equatable {
  const EsimSetupState();

  @override
  List<Object?> get props => [];
}

class EsimSetupInitial extends EsimSetupState {
  const EsimSetupInitial();
}

class EsimSetupLoading extends EsimSetupState {
  const EsimSetupLoading();
}

class EsimSetupLoaded extends EsimSetupState {
  final int selectedIndex;
  final int imsiListLength;

  const EsimSetupLoaded({
    required this.selectedIndex,
    required this.imsiListLength,
  });

  @override
  List<Object?> get props => [selectedIndex, imsiListLength];

  EsimSetupLoaded copyWith({int? selectedIndex}) {
    return EsimSetupLoaded(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      imsiListLength: imsiListLength,
    );
  }
}

class EsimSetupError extends EsimSetupState {
  final String message;

  const EsimSetupError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Bloc
class EsimSetupBloc extends Bloc<EsimSetupEvent, EsimSetupState> {
  final List<String> options;

  EsimSetupBloc({required this.options}) : super(const EsimSetupInitial()) { 
    on<LoadImsiListLength>(_onLoadImsiListLength);
    on<SelectOption>(_onSelectOption);
    on<ResetSelection>(_onResetSelection);
  }

  Future<void> _onLoadImsiListLength(
    LoadImsiListLength event,
    Emitter<EsimSetupState> emit,
  ) async {
    emit(const EsimSetupLoading());

    final subscriberDataSource = sl.get<SubscriberLocalDataSource>();
    try {
      final length = await subscriberDataSource.getImsiListLength() ?? 0;
      final defaultIndex = length > 1 ? options.length - 1 : 0; 

      emit(
        EsimSetupLoaded(selectedIndex: defaultIndex, imsiListLength: length),
      ); 
    } catch (e) {
      emit(const EsimSetupError(message: 'Ошибка загрузки IMSI'));
    }
  }

  void _onSelectOption(SelectOption event, Emitter<EsimSetupState> emit) {
    final currentState = state;
    if (currentState is EsimSetupLoaded) {
      emit(
        currentState.copyWith(selectedIndex: event.index),
      );
    }
  }

  void _onResetSelection(ResetSelection event, Emitter<EsimSetupState> emit) {
    final currentState = state;
    if (currentState is EsimSetupLoaded) {
      emit(currentState.copyWith(selectedIndex: 0)); 
    }
  }

}
