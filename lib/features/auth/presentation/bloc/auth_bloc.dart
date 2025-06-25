import 'package:flex_travel_sim/features/auth/domain/entities/credentials.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/login_use_case.dart';
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
  final Credentials credentials;
  AuthRequested(this.credentials);
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({ required this.loginUseCase }) : super(AuthInitial()) {
    on<AuthRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final authToken = await loginUseCase(event.credentials);
        if (authToken != null) {
          emit(AuthSuccess(authToken.token));
        } else {
          emit(AuthFailure('Invalid credentials'));
        }
      } catch (e) {
        emit(AuthFailure('Login failed: $e'));
      }
    });
  }
}