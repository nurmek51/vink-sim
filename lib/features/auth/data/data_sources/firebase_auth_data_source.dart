import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class FirebaseAuthDataSource {
  Future<String?> signInWithEmailAndPassword(String email, String password);
  Future<String?> createUserWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  User? getCurrentUser();
  Stream<User?> get authStateChanges;
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSourceImpl({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      if (kDebugMode) {
        print('Firebase: Attempting sign in for email: $email');
      }

      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        final idToken = await user.getIdToken();
        
        if (kDebugMode) {
          print('Firebase: Sign in successful');
          print('User ID: ${user.uid}');
          print('Email: ${user.email}');
          print('Email verified: ${user.emailVerified}');
        }
        
        return idToken;
      }
      
      return null;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth Error: ${e.code} - ${e.message}');
      }
      
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'User with this email not found';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'user-disabled':
          errorMessage = 'Account disabled';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Try again later';
          break;
        default:
          errorMessage = 'Authentication error: ${e.message}';
      }
      
      throw Exception(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected error: $e');
      }
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<String?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      if (kDebugMode) {
        print('Firebase: Creating account for email: $email');
      }

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          if (kDebugMode) {
            print('Email verification sent');
          }
        }

        final idToken = await user.getIdToken();
        
        if (kDebugMode) {
          print('Firebase: Account created successfully');
          print('User ID: ${user.uid}');
        }
        
        return idToken;
      }
      
      return null;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth Error: ${e.code} - ${e.message}');
      }
      
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'Password too weak';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email already in use';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Registration disabled';
          break;
        default:
          errorMessage = 'Registration error: ${e.message}';
      }
      
      throw Exception(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected error: $e');
      }
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      if (kDebugMode) {
        print('Firebase: Sending password reset email to: $email');
      }

      await _firebaseAuth.sendPasswordResetEmail(email: email);
      
      if (kDebugMode) {
        print('Password reset email sent');
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth Error: ${e.code} - ${e.message}');
      }
      
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'User with this email not found';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        default:
          errorMessage = 'Email sending error: ${e.message}';
      }
      
      throw Exception(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected error: $e');
      }
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (kDebugMode) {
        print('Firebase: Signing out');
      }

      await _firebaseAuth.signOut();
      
      if (kDebugMode) {
        print('Firebase: Sign out successful');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Sign out error: $e');
      }
      throw Exception('Sign out error: $e');
    }
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}