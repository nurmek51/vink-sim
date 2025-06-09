import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// State
class WelcomeState extends Equatable {
  final bool isAnimating;
  
  const WelcomeState({
    this.isAnimating = true,
  });

  @override
  List<Object?> get props => [isAnimating];
}

// Cubit
class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeState());

  void stopAnimation() {
    emit(const WelcomeState(isAnimating: false));
  }

  void startAnimation() {
    emit(const WelcomeState(isAnimating: true));
  }
}
