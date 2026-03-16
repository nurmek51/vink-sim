import 'package:flutter/services.dart';
import 'package:vink_sim/core/platform_device/platform_detector.dart';

class WalletPaymentAvailability {
  static const String applePayConfigAssetPath =
      'assets/payments/apple_pay_config.json';
  static const String googlePayConfigAssetPath =
      'assets/payments/google_pay_config.json';
  static final Future<List<Map<String, dynamic>>> paymentMethodsFuture =
      resolvePaymentMethods();

  static Future<List<Map<String, dynamic>>> resolvePaymentMethods() async {
    final methods = <Map<String, dynamic>>[
      {'logo': 'credCard', 'method': 'credit_card', 'enabled': true},
    ];

    if (PlatformDetector.isIos && await _hasAsset(applePayConfigAssetPath)) {
      methods.insert(0, {
        'logo': 'apple_pay_logo',
        'method': 'apple_pay',
        'enabled': true,
      });
    } else if (PlatformDetector.isAndroid &&
        await _hasAsset(googlePayConfigAssetPath)) {
      methods.insert(0, {
        'logo': 'google_pay_logo',
        'method': 'google_pay',
        'enabled': true,
      });
    }

    methods.add({'logo': 'crypto', 'method': 'crypto', 'enabled': false});
    return methods;
  }

  static Future<bool> _hasAsset(String assetPath) async {
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      return manifest.listAssets().contains(assetPath);
    } catch (_) {
      return false;
    }
  }
}
