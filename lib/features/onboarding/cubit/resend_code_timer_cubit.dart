import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// State
class ResendCodeTimerState extends Equatable {
  final int secondsRemaining;
  final bool canResend;

  const ResendCodeTimerState({
    required this.secondsRemaining,
    required this.canResend,
  });

  @override
  List<Object?> get props => [secondsRemaining, canResend];
}

// Cubit
class ResendCodeTimerCubit extends Cubit<ResendCodeTimerState> {
  static const int _startSeconds = 60;
  Timer? _timer;

  ResendCodeTimerCubit()
    : super(
        const ResendCodeTimerState(
          secondsRemaining: _startSeconds,
          canResend: false,
        ),
      ) {
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    emit(
      const ResendCodeTimerState(
        secondsRemaining: _startSeconds,
        canResend: false,
      ),
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining == 0) {
        timer.cancel();
        emit(const ResendCodeTimerState(secondsRemaining: 0, canResend: true));
      } else {
        emit(
          ResendCodeTimerState(
            secondsRemaining: state.secondsRemaining - 1,
            canResend: false,
          ),
        );
      }
    });
  }

  void resendCode() {
    if (state.canResend) {
      _startTimer();
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
