import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ConfigurationService {
  String get apiUrl;
  bool get isDebugMode;
}

class EnvironmentConfigurationService implements ConfigurationService {
  @override
  String get apiUrl {
    final url = dotenv.env['API_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('API_URL not found in .env file');
    }
    return url;
  }

  @override
  bool get isDebugMode => kDebugMode;
}
