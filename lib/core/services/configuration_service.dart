import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ConfigurationService {
  String get apiUrl;
  String get stripePublishableKey;
  String get stripeMerchantIdentifier;
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
  String get stripePublishableKey {
    final key = dotenv.env['STRIPE_PUBLISHABLE_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('STRIPE_PUBLISHABLE_KEY not found in .env file');
    }
    return key;
  }

  @override
  String get stripeMerchantIdentifier => 'merchant.com.flextravelsim.app';

  @override
  bool get isDebugMode => kDebugMode;
}