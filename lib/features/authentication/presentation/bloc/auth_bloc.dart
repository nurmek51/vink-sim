import 'package:flex_travel_sim/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// State
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final String token;
  AuthSuccess(this.token);
}
class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

// Event
abstract class AuthEvent {}
class AuthRequested extends AuthEvent {
  final String phone;
  AuthRequested(this.phone);
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<AuthRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await loginUseCase.call(event.phone);
        if (token != null) {
          emit(AuthSuccess(token));
        } else {
          emit(AuthFailure('Token not found'));
        }
      } catch (e) {
        emit(AuthFailure('Login failed: $e'));
      }
    });
  }
}
