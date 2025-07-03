import 'package:flex_travel_sim/features/auth/domain/entities/country.dart';
import 'package:flex_travel_sim/features/auth/data/country_data.dart';

class PhoneUtils {
  static String normalizePhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'\D'), '');
  }

  static bool isValidPhoneNumber(String phone, Country country) {
    final normalizedPhone = normalizePhoneNumber(phone);

    if (normalizedPhone.isEmpty) return false;

    String localNumber = normalizedPhone;
    final dialCodeDigits = normalizePhoneNumber(country.dialCode);

    if (normalizedPhone.startsWith(dialCodeDigits)) {
      localNumber = normalizedPhone.substring(dialCodeDigits.length);
    }

    switch (country.dialCode) {
      case '+7': // Russia, Kazakhstan
        return localNumber.length == 10;
      case '+1': // US, Canada
        return localNumber.length == 10;
      case '+44': // UK
        return localNumber.length >= 10 && localNumber.length <= 11;
      case '+33': // France
        return localNumber.length == 9;
      case '+49': // Germany
        return localNumber.length >= 10 && localNumber.length <= 12;
      case '+39': // Italy
        return localNumber.length >= 9 && localNumber.length <= 11;
      case '+34': // Spain
        return localNumber.length == 9;
      case '+81': // Japan
        return localNumber.length >= 10 && localNumber.length <= 11;
      case '+86': // China
        return localNumber.length == 11;
      case '+91': // India
        return localNumber.length == 10;
      default:
        // Generic validation for other countries
        return localNumber.length >= 7 && localNumber.length <= 15;
    }
  }

  static String formatPhoneNumber(String phone, Country country) {
    final normalizedPhone = normalizePhoneNumber(phone);

    if (normalizedPhone.isEmpty) return '';

    final dialCodeDigits = normalizePhoneNumber(country.dialCode);
    String localNumber = normalizedPhone;

    if (normalizedPhone.startsWith(dialCodeDigits)) {
      localNumber = normalizedPhone.substring(dialCodeDigits.length);
    }

    switch (country.dialCode) {
      case '+7': // Russia, Kazakhstan
        return _formatRussianNumber(localNumber, country.dialCode);
      case '+1': // US, Canada
        return _formatUSNumber(localNumber, country.dialCode);
      default:
        return _formatGenericNumber(localNumber, country.dialCode);
    }
  }

  static String _formatRussianNumber(String localNumber, String dialCode) {
    if (localNumber.length < 3) return '$dialCode $localNumber';

    final buffer = StringBuffer(dialCode);
    buffer.write(' (');

    final operatorCodeEnd = localNumber.length >= 3 ? 3 : localNumber.length;
    buffer.write(localNumber.substring(0, operatorCodeEnd));

    if (localNumber.length >= 3) {
      buffer.write(')');
    }

    if (localNumber.length > 3) {
      buffer.write(' ');
      final firstGroupEnd = localNumber.length >= 6 ? 6 : localNumber.length;
      buffer.write(localNumber.substring(3, firstGroupEnd));
    }

    if (localNumber.length > 6) {
      buffer.write(' ');
      final secondGroupEnd = localNumber.length >= 8 ? 8 : localNumber.length;
      buffer.write(localNumber.substring(6, secondGroupEnd));
    }

    if (localNumber.length > 8) {
      buffer.write(' ');
      buffer.write(localNumber.substring(8));
    }

    return buffer.toString();
  }

  static String _formatUSNumber(String localNumber, String dialCode) {
    if (localNumber.length < 3) return '$dialCode $localNumber';

    final buffer = StringBuffer(dialCode);
    buffer.write(' (');

    final areaCodeEnd = localNumber.length >= 3 ? 3 : localNumber.length;
    buffer.write(localNumber.substring(0, areaCodeEnd));

    if (localNumber.length >= 3) {
      buffer.write(')');
    }

    if (localNumber.length > 3) {
      buffer.write(' ');
      final firstGroupEnd = localNumber.length >= 6 ? 6 : localNumber.length;
      buffer.write(localNumber.substring(3, firstGroupEnd));
    }

    if (localNumber.length > 6) {
      buffer.write('-');
      buffer.write(localNumber.substring(6));
    }

    return buffer.toString();
  }

  static String _formatGenericNumber(String localNumber, String dialCode) {
    final buffer = StringBuffer(dialCode);
    buffer.write(' ');

    for (int i = 0; i < localNumber.length; i += 3) {
      if (i > 0) buffer.write(' ');
      final end = (i + 3 < localNumber.length) ? i + 3 : localNumber.length;
      buffer.write(localNumber.substring(i, end));
    }

    return buffer.toString();
  }

  static String getInternationalNumber(String phone, Country country) {
    final normalizedPhone = normalizePhoneNumber(phone);
    final dialCodeDigits = normalizePhoneNumber(country.dialCode);

    if (normalizedPhone.startsWith(dialCodeDigits)) {
      return normalizedPhone;
    }

    return dialCodeDigits + normalizedPhone;
  }

  static Country? detectCountryFromPhone(String phone) {
    final normalizedPhone = normalizePhoneNumber(phone);

    if (normalizedPhone.isEmpty) return null;

    for (final country in CountryData.countries) {
      final dialCodeDigits = normalizePhoneNumber(country.dialCode);
      if (normalizedPhone.startsWith(dialCodeDigits)) {
        return country;
      }
    }

    return null;
  }
}
