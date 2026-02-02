import 'package:vink_sim/core/platform_device/platform_detector.dart';
import 'package:flutter/services.dart';

class EsimService {
  static const MethodChannel _channel =
      MethodChannel('com.flexunion.FlexSim/esim');

  static Future<String> installEsimProfile({
    required String smdpServer,
    required String activationCode,
  }) async {
    try {
      final result = await _channel.invokeMethod('installEsim', {
        'smdpServer': smdpServer,
        'activationCode': activationCode,
      });
      return result.toString();
    } on PlatformException catch (e) {
      // Handle different error codes
      switch (e.code) {
        case 'UNSUPPORTED_VERSION':
          if (PlatformDetector.isIos) {
            throw Exception('eSIM requires iOS 12.0 or later');
          } else if (PlatformDetector.isAndroid) {
            throw Exception('eSIM requires Android 9.0 (API 28) or later');
          }
          break;
        case 'ESIM_NOT_SUPPORTED':
          throw Exception('eSIM is not supported or enabled on this device');
        case 'INVALID_ARGUMENTS':
          throw Exception('Invalid eSIM parameters provided');
        case 'NO_SETTINGS':
          throw Exception('Cannot open device settings');
        case 'INSTALL_ERROR':
        default:
          throw Exception('Failed to install eSIM profile: ${e.message}');
      }
      throw Exception('Failed to install eSIM profile: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  static Future<bool> isEsimSupported() async {
    try {
      if (PlatformDetector.isIos && !_isIOS12OrLater()) {
        return false;
      }
      if (PlatformDetector.isAndroid && !_isAndroid9OrLater()) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool _isIOS12OrLater() {
    // This is a simplified check - in a real app you might want to use device_info_plus
    return true; // Assume modern iOS version for now
  }

  static bool _isAndroid9OrLater() {
    // This is a simplified check - in a real app you might want to use device_info_plus
    return true; // Assume modern Android version for now
  }
}
