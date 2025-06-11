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

// State
class EsimSetupState extends Equatable {
  final int selectedIndex;
  
  const EsimSetupState({
    this.selectedIndex = 0,
  });

  EsimSetupState copyWith({
    int? selectedIndex,
  }) {
    return EsimSetupState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}

// Bloc
class EsimSetupBloc extends Bloc<EsimSetupEvent, EsimSetupState> {
  EsimSetupBloc() : super(const EsimSetupState()) {
    on<SelectOption>(_onSelectOption);
    on<ResetSelection>(_onResetSelection);
  }

  void _onSelectOption(SelectOption event, Emitter<EsimSetupState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onResetSelection(ResetSelection event, Emitter<EsimSetupState> emit) {
    emit(state.copyWith(selectedIndex: 0));
  }
}
