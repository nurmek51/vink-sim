import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ResendCodeTimerEvent extends Equatable {
  const ResendCodeTimerEvent();

  @override
  List<Object?> get props => [];
}

class StartTimer extends ResendCodeTimerEvent {
  const StartTimer();
}

class TickTimer extends ResendCodeTimerEvent {
  const TickTimer();
}

class ResendCode extends ResendCodeTimerEvent {
  const ResendCode();
}

class ResetTimer extends ResendCodeTimerEvent {
  const ResetTimer();
}

// State
class ResendCodeTimerState extends Equatable {
  final int secondsRemaining;
  final bool canResend;

  const ResendCodeTimerState({
    required this.secondsRemaining,
    required this.canResend,
  });

  ResendCodeTimerState copyWith({
    int? secondsRemaining,
    bool? canResend,
  }) {
    return ResendCodeTimerState(
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      canResend: canResend ?? this.canResend,
    );
  }

  @override
  List<Object?> get props => [secondsRemaining, canResend];
}

// Bloc
class ResendCodeTimerBloc extends Bloc<ResendCodeTimerEvent, ResendCodeTimerState> {
  static const int _startSeconds = 60;
  Timer? _timer;

  ResendCodeTimerBloc()
      : super(
          const ResendCodeTimerState(
            secondsRemaining: _startSeconds,
            canResend: false,
          ),
        ) {
    on<StartTimer>(_onStartTimer);
    on<TickTimer>(_onTickTimer);
    on<ResendCode>(_onResendCode);
    on<ResetTimer>(_onResetTimer);
    
    // Auto start timer
    add(const StartTimer());
  }

  void _onStartTimer(StartTimer event, Emitter<ResendCodeTimerState> emit) {
    _timer?.cancel();
    emit(state.copyWith(secondsRemaining: _startSeconds, canResend: false));
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(const TickTimer());
    });
  }

  void _onTickTimer(TickTimer event, Emitter<ResendCodeTimerState> emit) {
    if (state.secondsRemaining == 0) {
      _timer?.cancel();
      emit(state.copyWith(canResend: true));
    } else {
      emit(state.copyWith(secondsRemaining: state.secondsRemaining - 1));
    }
  }

  void _onResendCode(ResendCode event, Emitter<ResendCodeTimerState> emit) {
    if (state.canResend) {
      add(const StartTimer());
    }
  }

  void _onResetTimer(ResetTimer event, Emitter<ResendCodeTimerState> emit) {
    _timer?.cancel();
    emit(const ResendCodeTimerState(secondsRemaining: _startSeconds, canResend: false));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
