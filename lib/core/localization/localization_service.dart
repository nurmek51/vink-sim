import 'package:flutter/material.dart';

class LocalizationService {
  static void changeLanguage(BuildContext context, String languageCode) {
    // context.setLocale(Locale(languageCode));
  }

  static String getCurrentLanguage(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  static List<Locale> getSupportedLocales() {
    return [const Locale('en'), const Locale('ru')];
  }

  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'ru':
        return 'Русский';
      default:
        return 'English';
    }
  }
}
