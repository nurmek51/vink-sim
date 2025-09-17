import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

class PlatformDetector {
  static bool get isIos {
    if (!kIsWeb) return false;
    final userAgent = web.window.navigator.userAgent.toLowerCase();
    return userAgent.contains('iphone') || userAgent.contains('ipad');
  }

  static bool get isAndroid {
    if (!kIsWeb) return false;
    final userAgent = web.window.navigator.userAgent.toLowerCase();
    return userAgent.contains('android');
  }

  static bool get isWeb => true;

  static String get platformLog {
    if (!kIsWeb) return "PlatformDetector: Unknown Web Platform";
    final userAgent = web.window.navigator.userAgent.toLowerCase();
    if (isIos) return "PlatformDetector: Web iOS - $userAgent";
    if (isAndroid) return "PlatformDetector: Web Android - $userAgent";
    return "PlatformDetector: Web Desktop - $userAgent";
  }

  static bool get isSimulator => false;

}