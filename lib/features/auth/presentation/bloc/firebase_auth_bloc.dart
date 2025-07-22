import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/firebase_login_use_case.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/send_password_reset_use_case.dart';
import 'package:flutter/foundation.dart';

// Events
abstract class FirebaseAuthEvent extends Equatable {
  const FirebaseAuthEvent();

  @override
  List<Object?> get props => [];
}

class FirebaseSignInEvent extends FirebaseAuthEvent {
  final String email;
  final String password;

  const FirebaseSignInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class FirebaseSignUpEvent extends FirebaseAuthEvent {
  final String email;
  final String password;

  const FirebaseSignUpEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class FirebaseSignOutEvent extends FirebaseAuthEvent {
  const FirebaseSignOutEvent();
}

class FirebaseSendPasswordResetEvent extends FirebaseAuthEvent {
  final String email;

  const FirebaseSendPasswordResetEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class FirebaseCheckAuthStatusEvent extends FirebaseAuthEvent {
  const FirebaseCheckAuthStatusEvent();
}

// States
abstract class FirebaseAuthState extends Equatable {
  const FirebaseAuthState();

  @override
  List<Object?> get props => [];
}

class FirebaseAuthInitial extends FirebaseAuthState {}

class FirebaseAuthLoading extends FirebaseAuthState {}

class FirebaseAuthSuccess extends FirebaseAuthState {
  final String token;
  final String? email;
  final bool isEmailVerified;

  const FirebaseAuthSuccess({
    required this.token,
    this.email,
    this.isEmailVerified = false,
  });

  @override
  List<Object?> get props => [token, email, isEmailVerified];
}

class FirebaseAuthFailure extends FirebaseAuthState {
  final String message;

  const FirebaseAuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class FirebasePasswordResetSent extends FirebaseAuthState {
  const FirebasePasswordResetSent();
}

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  final FirebaseLoginUseCase _firebaseLoginUseCase;
  final SendPasswordResetUseCase _sendPasswordResetUseCase;

  FirebaseAuthBloc({
    required FirebaseLoginUseCase firebaseLoginUseCase,
    required SendPasswordResetUseCase sendPasswordResetUseCase,
  }) : _firebaseLoginUseCase = firebaseLoginUseCase,
       _sendPasswordResetUseCase = sendPasswordResetUseCase,
       super(FirebaseAuthInitial()) {
    on<FirebaseSignInEvent>(_onSignIn);
    on<FirebaseSignUpEvent>(_onSignUp);
    on<FirebaseSignOutEvent>(_onSignOut);
    on<FirebaseSendPasswordResetEvent>(_onSendPasswordReset);
    on<FirebaseCheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onSignIn(
    FirebaseSignInEvent event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    try {
      if (kDebugMode) {
        print('FirebaseAuthBloc: Processing sign in for ${event.email}');
      }

      emit(FirebaseAuthLoading());

      final token = await _firebaseLoginUseCase.signInWithEmailAndPassword(
        event.email,
        event.password,
      );

      if (token != null) {
        emit(FirebaseAuthSuccess(token: token));

        if (kDebugMode) {
          print('FirebaseAuthBloc: Sign in successful');
        }
      } else {
        emit(
          const FirebaseAuthFailure(
            message: 'Не удалось получить токен авторизации',
          ),
        );

        if (kDebugMode) {
          print('FirebaseAuthBloc: Sign in failed - no token');
        }
      }
    } catch (e) {
      emit(
        FirebaseAuthFailure(
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );

      if (kDebugMode) {
        print('FirebaseAuthBloc: Sign in error: $e');
      }
    }
  }

  Future<void> _onSignUp(
    FirebaseSignUpEvent event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    try {
      if (kDebugMode) {
        print('FirebaseAuthBloc: Processing sign up for ${event.email}');
      }

      emit(FirebaseAuthLoading());

      final token = await _firebaseLoginUseCase.createUserWithEmailAndPassword(
        event.email,
        event.password,
      );

      if (token != null) {
        emit(FirebaseAuthSuccess(token: token));

        if (kDebugMode) {
          print('FirebaseAuthBloc: Sign up successful');
        }
      } else {
        emit(const FirebaseAuthFailure(message: 'Не удалось создать аккаунт'));

        if (kDebugMode) {
          print('FirebaseAuthBloc: Sign up failed - no token');
        }
      }
    } catch (e) {
      emit(
        FirebaseAuthFailure(
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );

      if (kDebugMode) {
        print('FirebaseAuthBloc: Sign up error: $e');
      }
    }
  }

  Future<void> _onSignOut(
    FirebaseSignOutEvent event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    try {
      if (kDebugMode) {
        print('FirebaseAuthBloc: Processing sign out');
      }

      emit(FirebaseAuthLoading());

      await _firebaseLoginUseCase.signOut();

      emit(FirebaseAuthInitial());

      if (kDebugMode) {
        print('FirebaseAuthBloc: Sign out successful');
      }
    } catch (e) {
      emit(
        FirebaseAuthFailure(
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );

      if (kDebugMode) {
        print('FirebaseAuthBloc: Sign out error: $e');
      }
    }
  }

  Future<void> _onSendPasswordReset(
    FirebaseSendPasswordResetEvent event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    try {
      if (kDebugMode) {
        print(
          'FirebaseAuthBloc: Processing password reset for ${event.email}',
        );
      }

      emit(FirebaseAuthLoading());

      await _sendPasswordResetUseCase.call(event.email);

      emit(const FirebasePasswordResetSent());

      if (kDebugMode) {
        print('FirebaseAuthBloc: Password reset email sent');
      }
    } catch (e) {
      emit(
        FirebaseAuthFailure(
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );

      if (kDebugMode) {
        print('FirebaseAuthBloc: Password reset error: $e');
      }
    }
  }

  Future<void> _onCheckAuthStatus(
    FirebaseCheckAuthStatusEvent event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    try {
      if (kDebugMode) {
        print('FirebaseAuthBloc: Checking auth status');
      }

      final isSignedIn = _firebaseLoginUseCase.isUserSignedIn();

      if (isSignedIn) {
        final userId = _firebaseLoginUseCase.getCurrentUserId();
        final userEmail = _firebaseLoginUseCase.getCurrentUserEmail();
        final isEmailVerified = _firebaseLoginUseCase.isEmailVerified();

        emit(
          FirebaseAuthSuccess(
            token: userId ?? '',
            email: userEmail,
            isEmailVerified: isEmailVerified,
          ),
        );

        if (kDebugMode) {
          print('FirebaseAuthBloc: User is signed in');
          print('Email: $userEmail');
          print('Email verified: $isEmailVerified');
        }
      } else {
        emit(FirebaseAuthInitial());

        if (kDebugMode) {
          print('FirebaseAuthBloc: User is not signed in');
        }
      }
    } catch (e) {
      emit(
        FirebaseAuthFailure(
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );

      if (kDebugMode) {
        print('FirebaseAuthBloc: Check auth status error: $e');
      }
    }
  }
}
