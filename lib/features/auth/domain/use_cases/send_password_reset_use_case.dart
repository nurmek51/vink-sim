import 'package:flex_travel_sim/features/auth/data/repo/firebase_auth_repository_impl.dart';
import 'package:flutter/foundation.dart';

class SendPasswordResetUseCase {
  final FirebaseAuthRepositoryImpl _repository;

  SendPasswordResetUseCase(this._repository);

  Future<void> call(String email) async {
    try {
      if (kDebugMode) {
        print('SendPasswordResetUseCase: Sending password reset for $email');
      }

      await _repository.sendPasswordResetEmail(email);

      if (kDebugMode) {
        print('SendPasswordResetUseCase: Password reset email sent');
      }
    } catch (e) {
      if (kDebugMode) {
        print('SendPasswordResetUseCase: Error: $e');
      }
      rethrow;
    }
  }
}