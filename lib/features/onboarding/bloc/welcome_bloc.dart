import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object?> get props => [];
}

class StartAnimation extends WelcomeEvent {
  const StartAnimation();
}

class StopAnimation extends WelcomeEvent {
  const StopAnimation();
}

// State
class WelcomeState extends Equatable {
  final bool isAnimating;
  
  const WelcomeState({
    this.isAnimating = true,
  });

  WelcomeState copyWith({
    bool? isAnimating,
  }) {
    return WelcomeState(
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }

  @override
  List<Object?> get props => [isAnimating];
}

// Bloc
class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState()) {
    on<StartAnimation>(_onStartAnimation);
    on<StopAnimation>(_onStopAnimation);
  }

  void _onStartAnimation(StartAnimation event, Emitter<WelcomeState> emit) {
    emit(state.copyWith(isAnimating: true));
  }

  void _onStopAnimation(StopAnimation event, Emitter<WelcomeState> emit) {
    emit(state.copyWith(isAnimating: false));
  }
}
