import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Helper class to check Firebase availability
class FirebaseHelper {
  static bool _isInitialized = false;
  static bool _initializationAttempted = false;

  /// Check if Firebase is properly initialized
  static bool get isAvailable {
    if (!_initializationAttempted) {
      _checkInitialization();
    }
    return _isInitialized;
  }

  static void _checkInitialization() {
    _initializationAttempted = true;
    try {
      if (Firebase.apps.isNotEmpty) {
        // Try to actually access FirebaseAuth to make sure it works
        FirebaseAuth.instance;
        _isInitialized = true;
        if (kDebugMode) {
          print('FirebaseHelper: Firebase is available');
        }
      } else {
        _isInitialized = false;
        if (kDebugMode) {
          print('FirebaseHelper: No Firebase apps initialized');
        }
      }
    } catch (e) {
      _isInitialized = false;
      if (kDebugMode) {
        print('FirebaseHelper: Firebase check failed: $e');
      }
    }
  }

  /// Get FirebaseAuth instance if available
  static FirebaseAuth? get authInstance {
    if (!isAvailable) return null;
    try {
      return FirebaseAuth.instance;
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseHelper: Failed to get FirebaseAuth instance: $e');
      }
      return null;
    }
  }

  /// Reset the initialization state (useful for testing)
  static void reset() {
    _isInitialized = false;
    _initializationAttempted = false;
  }
}
