import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentType { development, production }

class Environment {
  static EnvironmentType get current {
    if (kReleaseMode) {
      return EnvironmentType.production;
    }

    return kDebugMode
        ? EnvironmentType.development
        : EnvironmentType.production;
  }

  static String get envFileName {
    return '.env';
  }

  static Future<void> load() async {
    final fileName = envFileName;

    if (kDebugMode) {
      print('Environment: Loading $fileName');
      print('Current environment: ${current.name}');
    }

    try {
      await dotenv.load(fileName: fileName);

      if (kDebugMode) {
        print('Environment: Successfully loaded $fileName');
        print('API_URL: ${dotenv.env['API_URL']}');
        print('Firebase Project: ${dotenv.env['FIREBASE_PROJECT_ID']}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Environment: Failed to load $fileName - $e');
        print('Falling back to default .env file');
      }

      // Fallback to default .env if specific environment file not found
      await dotenv.load();
    }
  }

  static bool get isDevelopment => current == EnvironmentType.development;
  static bool get isProduction => current == EnvironmentType.production;

  // Configuration getters
  static String _overrideApiUrl = '';
  static String get apiUrl {
    if (kDebugMode) {
       print('Debug: Getting API URL. Override: $_overrideApiUrl, Env: ${dotenv.env['API_URL']}');
    }
    final baseUrl = _overrideApiUrl.isNotEmpty ? _overrideApiUrl : (dotenv.env['API_URL'] ?? '');
    if (baseUrl.isEmpty) return '';
    
    // Ensure API version path is included
    if (!baseUrl.contains('/api/v1') && !baseUrl.endsWith('/api/v1')) {
      final cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      // Check if it already has /api but not version
      if (cleanBaseUrl.endsWith('/api')) {
         return '$cleanBaseUrl/v1';
      }
      return '$cleanBaseUrl/api/v1';
    }
    return baseUrl;
  }
  
  static void setApiUrl(String url) {
    _overrideApiUrl = url;
  }

  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
}
