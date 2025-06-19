import 'package:flex_travel_sim/features/onboarding/auth_by_email/domain/use_cases/login_by_email_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// State
abstract class AuthByEmailState {}
class AuthByEmailInitial extends AuthByEmailState {}
class AuthByEmailLoading extends AuthByEmailState {}
class AuthByEmailSuccess extends AuthByEmailState {
  final String token;
  AuthByEmailSuccess(this.token);
}
class AuthByEmailFailure extends AuthByEmailState {
  final String error;
  AuthByEmailFailure(this.error);
}

// Event
abstract class AuthByEmailEvent {}
class AuthByEmailRequested extends AuthByEmailEvent {
  final String email;
  AuthByEmailRequested(this.email);
}

// Bloc
class AuthByEmailBloc extends Bloc<AuthByEmailEvent, AuthByEmailState> {
  final LoginByEmailUseCase loginByEmailUseCase;

  AuthByEmailBloc({required this.loginByEmailUseCase}) : super(AuthByEmailInitial()) {
    on<AuthByEmailRequested>((event, emit) async {
      emit(AuthByEmailLoading());
      try {
        final token = await loginByEmailUseCase.call(event.email);
        if (token != null) {
          emit(AuthByEmailSuccess(token));
        } else {
          emit(AuthByEmailFailure('Token not found'));
        }
      } catch (e) {
        emit(AuthByEmailFailure('Auth by email failed: $e'));
      }
    });
  }
}
