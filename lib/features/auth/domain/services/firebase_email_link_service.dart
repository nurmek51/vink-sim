import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:vink_sim/core/services/firebase_helper.dart';

class FirebaseEmailLinkService {
  static FirebaseAuth? get _auth => FirebaseHelper.authInstance;
  static const String _emailKey = 'pending_email_link_auth';

  static bool get isAvailable => FirebaseHelper.isAvailable;

  static void _checkAvailability() {
    if (!isAvailable) {
      throw Exception(
        'Firebase is not available. Please configure Firebase credentials.',
      );
    }
  }

  static Future<void> sendSignInLinkToEmail(String email) async {
    _checkAvailability();

    try {
      if (kDebugMode) {
        print('Sending email link to: $email');
      }

      final actionCodeSettings = ActionCodeSettings(
        url: 'https://travel-sim-test-aa.firebaseapp.com/auth/verify',

        handleCodeInApp: true,
        iOSBundleId: 'com.example.flexTravelSim',
        androidPackageName: 'com.example.flex_travel_sim',
        androidInstallApp: true,
        androidMinimumVersion: '12',
      );

      await _auth!.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );

      await _saveEmailForPendingSignIn(email);

      if (kDebugMode) {
        print('Email link sent to $email');
        print(
          'Verification URL: https://travel-sim-test-aa.firebaseapp.com/auth/verify',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending email link: $e');
      }
      throw Exception('Failed to send email link: ${e.toString()}');
    }
  }

  static bool isSignInWithEmailLink(String emailLink) {
    if (!isAvailable) return false;
    return _auth!.isSignInWithEmailLink(emailLink);
  }

  static Future<UserCredential> signInWithEmailLink({
    required String email,
    required String emailLink,
  }) async {
    _checkAvailability();

    try {
      if (kDebugMode) {
        print('Completing authentication for: $email');
        print('Link: $emailLink');
      }

      if (!isSignInWithEmailLink(emailLink)) {
        throw Exception('Invalid authentication link');
      }

      final userCredential = await _auth!.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );

      await _clearPendingEmail();

      await _saveUserData(userCredential.user!);

      if (kDebugMode) {
        print('Authentication successful: ${userCredential.user?.uid}');
      }

      return userCredential;
    } catch (e) {
      if (kDebugMode) {
        print('Email link authentication error: $e');
      }
      throw Exception('Authentication failed: ${e.toString()}');
    }
  }

  static Future<UserCredential?> completeSignInWithSavedEmail(
    String emailLink,
  ) async {
    try {
      final savedEmail = await _getSavedEmail();
      if (savedEmail == null) {
        if (kDebugMode) {
          print('No saved email found for completing authentication');
        }
        return null;
      }

      return await signInWithEmailLink(email: savedEmail, emailLink: emailLink);
    } catch (e) {
      if (kDebugMode) {
        print('Automatic authentication completion error: $e');
      }
      return null;
    }
  }

  static Future<void> _saveEmailForPendingSignIn(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);

    if (kDebugMode) {
      print('Email saved for completing authentication: $email');
    }
  }

  static Future<String?> _getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  static Future<void> _clearPendingEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);

    if (kDebugMode) {
      print('Saved email cleared');
    }
  }

  static Future<void> _saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final token = await user.getIdToken();

    await prefs.setString('auth_token', token ?? '');
    await prefs.setString('user_email', user.email ?? '');
    await prefs.setString('user_id', user.uid);
    await prefs.setBool('email_verified', user.emailVerified);

    if (kDebugMode) {
      print('User data saved:');
      print('  - Email: ${user.email}');
      print('  - UID: ${user.uid}');
      print('  - Verified: ${user.emailVerified}');
    }
  }

  static User? getCurrentUser() {
    return _auth?.currentUser;
  }

  static Future<bool> isUserAuthenticated() async {
    final user = _auth?.currentUser;
    if (user == null) return false;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    return token != null && user.emailVerified;
  }

  static Future<String?> getCurrentUserEmail() async {
    final user = _auth?.currentUser;
    if (user?.email != null) {
      return user!.email;
    }

    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  static Future<void> signOut() async {
    if (!isAvailable) return;

    try {
      await _auth!.signOut();

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('user_email');
      await prefs.remove('user_id');
      await prefs.remove('email_verified');
      await _clearPendingEmail();

      if (kDebugMode) {
        print('User signed out');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Sign out error: $e');
      }
      throw Exception('Sign out error');
    }
  }

  static Future<void> resendSignInLink(String email) async {
    await sendSignInLinkToEmail(email);
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  static Future<Map<String, dynamic>> getPendingSignInStatus() async {
    final savedEmail = await _getSavedEmail();

    return {'hasPendingSignIn': savedEmail != null, 'email': savedEmail};
  }

  static Future<UserCredential?> handleIncomingLink(String link) async {
    try {
      if (kDebugMode) {
        print('Processing incoming link: $link');
      }

      if (!isSignInWithEmailLink(link)) {
        if (kDebugMode) {
          print('Link is not for authentication');
        }
        return null;
      }

      return await completeSignInWithSavedEmail(link);
    } catch (e) {
      if (kDebugMode) {
        print('Link processing error: $e');
      }
      return null;
    }
  }

  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (kDebugMode) {
      print('All data cleared');
    }
  }
}
