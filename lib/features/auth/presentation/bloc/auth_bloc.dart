import 'package:flex_travel_sim/features/auth/domain/entities/credentials.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

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
      
      if (kDebugMode) {
        if (event.credentials is PhoneCredentials) {
          print('AuthBloc: Login requested for phone: ${(event.credentials as PhoneCredentials).phone}');
        } else if (event.credentials is EmailCredentials) {
          print('AuthBloc: Login requested for email: ${(event.credentials as EmailCredentials).email}');
        }
      }
      
      try {
        final authToken = await loginUseCase(event.credentials);
        if (authToken != null) {
          if (kDebugMode) {
            print('AuthBloc: Login successful, token: ${authToken.token}');
          }
          emit(AuthSuccess(authToken.token));
        } else {
          if (kDebugMode) {
            print('AuthBloc: Login failed - null token returned');
          }
          emit(AuthFailure('Invalid credentials'));
        }
      } catch (e) {
        if (kDebugMode) {
          print('AuthBloc: Login error: $e');
        }
        emit(AuthFailure('Login failed: $e'));
      }
    });
  }
}