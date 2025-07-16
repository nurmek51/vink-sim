import 'package:flex_travel_sim/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/firebase_auth_data_source.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthRepositoryImpl {
  final FirebaseAuthDataSource _firebaseDataSource;
  final AuthLocalDataSource _localDataSource;

  FirebaseAuthRepositoryImpl({
    required FirebaseAuthDataSource firebaseDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _firebaseDataSource = firebaseDataSource,
       _localDataSource = localDataSource;

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      if (kDebugMode) {
        print('FirebaseAuthRepository: Attempting sign in for $email');
      }

      final token = await _firebaseDataSource.signInWithEmailAndPassword(email, password);
      
      if (token != null) {
        await _localDataSource.saveAuthToken(token);
        
        if (kDebugMode) {
          print('FirebaseAuthRepository: Sign in successful, token saved');
        }
      }
      
      return token;
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseAuthRepository: Sign in error: $e');
      }
      rethrow;
    }
  }

  Future<String?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      if (kDebugMode) {
        print('FirebaseAuthRepository: Creating account for $email');
      }

      final token = await _firebaseDataSource.createUserWithEmailAndPassword(email, password);
      
      if (token != null) {
        await _localDataSource.saveAuthToken(token);
        
        if (kDebugMode) {
          print('FirebaseAuthRepository: Account created successfully, token saved');
        }
      }
      
      return token;
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseAuthRepository: Create account error: $e');
      }
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      if (kDebugMode) {
        print('FirebaseAuthRepository: Sending password reset email to $email');
      }

      await _firebaseDataSource.sendPasswordResetEmail(email);
      
      if (kDebugMode) {
        print('FirebaseAuthRepository: Password reset email sent successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseAuthRepository: Send password reset error: $e');
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      if (kDebugMode) {
        print('FirebaseAuthRepository: Signing out');
      }

      await _firebaseDataSource.signOut();
      await _localDataSource.clearAuthToken();
      
      if (kDebugMode) {
        print('FirebaseAuthRepository: Sign out successful');
      }
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseAuthRepository: Sign out error: $e');
      }
      rethrow;
    }
  }

  bool isUserSignedIn() {
    final user = _firebaseDataSource.getCurrentUser();
    return user != null;
  }

  String? getCurrentUserId() {
    final user = _firebaseDataSource.getCurrentUser();
    return user?.uid;
  }

  String? getCurrentUserEmail() {
    final user = _firebaseDataSource.getCurrentUser();
    return user?.email;
  }

  bool isEmailVerified() {
    final user = _firebaseDataSource.getCurrentUser();
    return user?.emailVerified ?? false;
  }
}