import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class TechSupportLauncher {
  static Future<void> _log(String msg) async {
    if (kDebugMode) print('TechSupportLauncher: $msg');
  }

  static Future<void> openTelegram(String username) async {
    final tgUri = Uri.parse('tg://resolve?domain=$username');
    final webUri = Uri.parse('https://t.me/$username');

    try {
      if (await canLaunchUrl(tgUri)) {
        final isNativeTgOpened = await launchUrl(tgUri, mode: LaunchMode.externalApplication);

        if (isNativeTgOpened) {
          await _log('Открылся Telegram (нативно)');
          return;
        }
      }
    } catch (e) {
      await _log('Ошибка при открытии Telegram (нативно) - $e');
    }

    try {
      final isWebTgOpened = await launchUrl(webUri, mode: LaunchMode.platformDefault);

      if (isWebTgOpened) {
        await _log('Открылся Telegram (веб)');
      }
    } catch (e) {
      await _log('Ошибка при открытии Telegram (веб) - $e');
    }
  }

  static Future<void> openWhatsApp(String phoneNumber) async {
    final url = Uri.parse('https://wa.me/$phoneNumber');

    try {
      final isWhatsAppOpened = await launchUrl(url, mode: LaunchMode.platformDefault);
      if (isWhatsAppOpened) {
        await _log('Открылся WhatsApp');
      }
    } catch (e) {
      await _log('Ошибка при открытии WhatsApp - $e');
    }
  }
}