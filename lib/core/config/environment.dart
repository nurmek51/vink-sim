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
    switch (current) {
      case EnvironmentType.development:
        return '.env.development';
      case EnvironmentType.production:
        return '.env.production';
    }
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
  static String get apiUrl => dotenv.env['API_URL'] ?? '';
  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  static String get stripePublishableKey =>
      dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
}
