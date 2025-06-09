import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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

// Cubit
class EsimSetupCubit extends Cubit<EsimSetupState> {
  EsimSetupCubit() : super(const EsimSetupState());

  void selectOption(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
