import 'package:flex_travel_sim/features/auth/data/repo/firebase_auth_repository_impl.dart';
import 'package:flutter/foundation.dart';

class FirebaseLoginUseCase {
  final FirebaseAuthRepositoryImpl _repository;

  FirebaseLoginUseCase({required FirebaseAuthRepositoryImpl repository})
    : _repository = repository;

  Future<String?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (kDebugMode) {
        print('FirebaseLoginUseCase: Attempting sign in for $email');
      }

      final token = await _repository.signInWithEmailAndPassword(
        email,
        password,
      );

      if (kDebugMode) {
        if (token != null) {
          print('FirebaseLoginUseCase: Sign in successful');
        } else {
          print('FirebaseLoginUseCase: Sign in failed - no token returned');
        }
      }

      return token;
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseLoginUseCase: Sign in error: $e');
      }
      rethrow;
    }
  }

  Future<String?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (kDebugMode) {
        print('FirebaseLoginUseCase: Creating account for $email');
      }

      final token = await _repository.createUserWithEmailAndPassword(
        email,
        password,
      );

      if (kDebugMode) {
        if (token != null) {
          print('FirebaseLoginUseCase: Account created successfully');
        } else {
          print(
            'FirebaseLoginUseCase: Account creation failed - no token returned',
          );
        }
      }

      return token;
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseLoginUseCase: Create account error: $e');
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      if (kDebugMode) {
        print('FirebaseLoginUseCase: Signing out');
      }

      await _repository.signOut();

      if (kDebugMode) {
        print('FirebaseLoginUseCase: Sign out successful');
      }
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseLoginUseCase: Sign out error: $e');
      }
      rethrow;
    }
  }

  bool isUserSignedIn() {
    return _repository.isUserSignedIn();
  }

  String? getCurrentUserId() {
    return _repository.getCurrentUserId();
  }

  String? getCurrentUserEmail() {
    return _repository.getCurrentUserEmail();
  }

  bool isEmailVerified() {
    return _repository.isEmailVerified();
  }

  Future<String?> signInWithCustomToken(String token) async {
    try {
      if (kDebugMode) {
        print('FirebaseLoginUseCase: Signing in with custom token');
      }
      final idToken = await _repository.signInWithCustomToken(token);
      return idToken;
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseLoginUseCase: Custom token sign-in error: $e');
      }
      rethrow;
    }
  }

}
