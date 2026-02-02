import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:vink_sim/features/auth/data/data_sources/auth_local_data_source.dart';

class TokenManager {
  final AuthLocalDataSource _authLocalDataSource;
  String? _externalToken;

  TokenManager({
    required AuthLocalDataSource authLocalDataSource,
  }) : _authLocalDataSource = authLocalDataSource;

  void setExternalToken(String? token) {
    _externalToken = token;
    if (token != null) {
      if (kDebugMode) {
        print('TokenManager: Using external token');
      }
    }
  }

  void initialize() {
    // No-op for now unless we implement auto-refresh against backend
    if (kDebugMode) {
      print('TokenManager: Initialized (Pure Backend Mode)');
    }
  }

  Future<String?> getCurrentIdToken({bool forceRefresh = false}) async {
    if (_externalToken != null) {
      return _externalToken;
    }
    // Return stored token
    return await _authLocalDataSource.getToken();
  }

  Future<bool> isTokenValid() async {
    if (_externalToken != null) return true;
    final token = await _authLocalDataSource.getToken();
    return token != null && token.isNotEmpty;
  }

  Future<String?> refreshIdTokenManually() async {
    // TODO: Implement backend refresh logic if API supports it
    return getCurrentIdToken();
  }

  Future<Map<String, dynamic>> getTokenInfo() async {
    final storedToken = await _authLocalDataSource.getToken();
    return {
      'hasCurrentUser': storedToken != null,
      'tokenLength': storedToken?.length ?? 0,
      'storedTokenLength': storedToken?.length ?? 0,
    };
  }

  void dispose() {
    // Cleanup if needed
  }
}
