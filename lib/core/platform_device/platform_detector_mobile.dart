import 'dart:io' show Platform;

class PlatformDetector {
  static bool get isIos => Platform.isIOS;
  static bool get isAndroid => Platform.isAndroid;
  static bool get isWeb => false;

  static String get platformLog {
    if (isIos) return "PlatformDetector: Mobile iOS";
    if (isAndroid) return "PlatformDetector: Mobile Android";
    return "PlatformDetector: Unknown Mobile Platform";
  }

}