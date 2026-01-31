import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:vink_sim/features/auth/data/data_sources/auth_local_data_source.dart';

class TokenManager {
  FirebaseAuth? _firebaseAuth;
  final AuthLocalDataSource _authLocalDataSource;
  Timer? _tokenRefreshTimer;
  StreamSubscription<User?>? _authStateSubscription;
  bool _isFirebaseAvailable = false;
  String? _externalToken;

  TokenManager({
    FirebaseAuth? firebaseAuth,
    required AuthLocalDataSource authLocalDataSource,
  }) : _authLocalDataSource = authLocalDataSource {
    _initializeFirebaseAuth(firebaseAuth);
  }

  void setExternalToken(String? token) {
    _externalToken = token;
    if (token != null) {
      _cancelTokenRefresh();
      if (kDebugMode) {
        print('TokenManager: Using external token, internal refresh disabled');
      }
    }
  }

  void _initializeFirebaseAuth(FirebaseAuth? firebaseAuth) {
    try {
      if (firebaseAuth != null) {
        _firebaseAuth = firebaseAuth;
        _isFirebaseAvailable = true;
      } else if (Firebase.apps.isNotEmpty) {
        _firebaseAuth = FirebaseAuth.instance;
        _isFirebaseAvailable = true;
      } else {
        _isFirebaseAvailable = false;
        if (kDebugMode) {
          print(
            'TokenManager: Firebase not initialized, running in offline mode',
          );
        }
      }
    } catch (e) {
      _isFirebaseAvailable = false;
      if (kDebugMode) {
        print('TokenManager: Failed to initialize FirebaseAuth: $e');
      }
    }
  }

  void initialize() {
    if (!_isFirebaseAvailable) {
      if (kDebugMode) {
        print('TokenManager: Skipping initialization - Firebase not available');
      }
      return;
    }
    _listenToAuthStateChanges();
    _scheduleTokenRefresh();
  }

  void _listenToAuthStateChanges() {
    if (_firebaseAuth == null) return;

    _authStateSubscription = _firebaseAuth!.authStateChanges().listen((
      User? user,
    ) {
      if (kDebugMode) {
        if (user != null) {
          print('TokenManager: User authenticated - ${user.uid}');
          _scheduleTokenRefresh();
        } else {
          print('TokenManager: User signed out');
          _cancelTokenRefresh();
        }
      }
    });
  }

  void _scheduleTokenRefresh() {
    _cancelTokenRefresh();

    _tokenRefreshTimer = Timer.periodic(const Duration(minutes: 30), (_) {
      _refreshIdToken();
    });

    if (kDebugMode) {
      print('TokenManager: Token refresh scheduled every 30 minutes');
    }
  }

  Future<void> _refreshIdToken() async {
    if (_firebaseAuth == null) return;

    try {
      final user = _firebaseAuth!.currentUser;
      if (user == null) {
        if (kDebugMode) {
          print('TokenManager: No authenticated user for token refresh');
        }
        return;
      }

      final newIdToken = await user.getIdToken(true);

      if (newIdToken != null) {
        await _authLocalDataSource.saveAuthToken(newIdToken);

        if (kDebugMode) {
          print('TokenManager: ID token refreshed successfully');
          print('TokenManager: New token length: ${newIdToken.length}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('TokenManager: Error refreshing ID token: $e');
      }
    }
  }

  Future<String?> refreshIdTokenManually() async {
    if (_firebaseAuth == null) {
      throw Exception('Firebase not available');
    }

    try {
      final user = _firebaseAuth!.currentUser;
      if (user == null) {
        throw Exception('No authenticated user');
      }

      final newIdToken = await user.getIdToken(true);

      if (newIdToken != null) {
        await _authLocalDataSource.saveAuthToken(newIdToken);

        if (kDebugMode) {
          print('TokenManager: Manual token refresh successful');
        }

        return newIdToken;
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('TokenManager: Manual token refresh failed: $e');
      }
      rethrow;
    }
  }

  Future<bool> isTokenValid() async {
    if (_externalToken != null) {
      if (kDebugMode) {
        print('TokenManager: Validating external token (assumed valid)');
      }
      return true;
    }

    // Try to check stored token regardless of Firebase availability
    final storedToken = await _authLocalDataSource.getToken();
    if (storedToken != null && storedToken.isNotEmpty) {
      return true;
    }

    if (!_isFirebaseAvailable || _firebaseAuth == null) {
      return false;
    }

    try {
      final user = _firebaseAuth!.currentUser;
      if (user == null) return false;

      final token = await user.getIdToken(false);
      return token != null;
    } catch (e) {
      if (kDebugMode) {
        print('TokenManager: Token validation failed: $e');
      }
      return false;
    }
  }

  Future<String?> getCurrentIdToken({bool forceRefresh = false}) async {
    if (_externalToken != null) {
      return _externalToken;
    }

    if (_firebaseAuth == null) {
      // If Firebase is not available, try to get the token from local storage
      return await _authLocalDataSource.getToken();
    }

    try {
      final user = _firebaseAuth!.currentUser;
      if (user == null) return null;

      final token = await user.getIdToken(forceRefresh);

      if (token != null && forceRefresh) {
        await _authLocalDataSource.saveAuthToken(token);
      }

      return token;
    } catch (e) {
      if (kDebugMode) {
        print('TokenManager: Failed to get current ID token: $e');
      }
      return null;
    }
  }

  Future<Map<String, dynamic>> getTokenInfo() async {
    if (_firebaseAuth == null) {
      return {'error': 'Firebase not available'};
    }

    try {
      final user = _firebaseAuth!.currentUser;
      if (user == null) {
        return {'error': 'No authenticated user'};
      }

      final token = await user.getIdToken(false);
      final storedToken = await _authLocalDataSource.getToken();

      return {
        'hasCurrentUser': true,
        'userId': user.uid,
        'userEmail': user.email,
        'tokenLength': token?.length ?? 0,
        'storedTokenLength': storedToken?.length ?? 0,
        'tokensMatch': token == storedToken,
        'authTime': user.metadata.lastSignInTime?.millisecondsSinceEpoch,
        'creationTime': user.metadata.creationTime?.millisecondsSinceEpoch,
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  void _cancelTokenRefresh() {
    _tokenRefreshTimer?.cancel();
    _tokenRefreshTimer = null;
  }

  void dispose() {
    _cancelTokenRefresh();
    _authStateSubscription?.cancel();
    _authStateSubscription = null;

    if (kDebugMode) {
      print('TokenManager: Disposed');
    }
  }
}
