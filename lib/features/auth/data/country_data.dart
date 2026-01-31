import 'package:vink_sim/features/auth/domain/entities/country.dart';

class CountryData {
  static const List<Country> countries = [
    Country(name: 'Argentina', code: 'AR', dialCode: '+54', flag: '🇦🇷'),
    Country(name: 'Armenia', code: 'AM', dialCode: '+374', flag: '🇦🇲'),
    Country(name: 'Australia', code: 'AU', dialCode: '+61', flag: '🇦🇺'),
    Country(name: 'Austria', code: 'AT', dialCode: '+43', flag: '🇦🇹'),
    Country(name: 'Azerbaijan', code: 'AZ', dialCode: '+994', flag: '🇦🇿'),
    Country(name: 'Belarus', code: 'BY', dialCode: '+375', flag: '🇧🇾'),
    Country(name: 'Belgium', code: 'BE', dialCode: '+32', flag: '🇧🇪'),
    Country(name: 'Brazil', code: 'BR', dialCode: '+55', flag: '🇧🇷'),
    Country(name: 'Bulgaria', code: 'BG', dialCode: '+359', flag: '🇧🇬'),
    Country(name: 'Canada', code: 'CA', dialCode: '+1', flag: '🇨🇦'),
    Country(name: 'China', code: 'CN', dialCode: '+86', flag: '🇨🇳'),
    Country(name: 'Croatia', code: 'HR', dialCode: '+385', flag: '🇭🇷'),
    Country(name: 'Cyprus', code: 'CY', dialCode: '+357', flag: '🇨🇾'),
    Country(name: 'Czech Republic', code: 'CZ', dialCode: '+420', flag: '🇨🇿'),
    Country(name: 'Denmark', code: 'DK', dialCode: '+45', flag: '🇩🇰'),
    Country(name: 'Egypt', code: 'EG', dialCode: '+20', flag: '🇪🇬'),
    Country(name: 'Estonia', code: 'EE', dialCode: '+372', flag: '🇪🇪'),
    Country(name: 'Finland', code: 'FI', dialCode: '+358', flag: '🇫🇮'),
    Country(name: 'France', code: 'FR', dialCode: '+33', flag: '🇫🇷'),
    Country(name: 'Georgia', code: 'GE', dialCode: '+995', flag: '🇬🇪'),
    Country(name: 'Germany', code: 'DE', dialCode: '+49', flag: '🇩🇪'),
    Country(name: 'Greece', code: 'GR', dialCode: '+30', flag: '🇬🇷'),
    Country(name: 'Hungary', code: 'HU', dialCode: '+36', flag: '🇭🇺'),
    Country(name: 'Iceland', code: 'IS', dialCode: '+354', flag: '🇮🇸'),
    Country(name: 'India', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
    Country(name: 'Indonesia', code: 'ID', dialCode: '+62', flag: '🇮🇩'),
    Country(name: 'Ireland', code: 'IE', dialCode: '+353', flag: '🇮🇪'),
    Country(name: 'Israel', code: 'IL', dialCode: '+972', flag: '🇮🇱'),
    Country(name: 'Italy', code: 'IT', dialCode: '+39', flag: '🇮🇹'),
    Country(name: 'Japan', code: 'JP', dialCode: '+81', flag: '🇯🇵'),
    Country(name: 'Kazakhstan', code: 'KZ', dialCode: '+7', flag: '🇰🇿'),
    Country(name: 'Kyrgyzstan', code: 'KG', dialCode: '+996', flag: '🇰🇬'),
    Country(name: 'Latvia', code: 'LV', dialCode: '+371', flag: '🇱🇻'),
    Country(name: 'Lithuania', code: 'LT', dialCode: '+370', flag: '🇱🇹'),
    Country(name: 'Luxembourg', code: 'LU', dialCode: '+352', flag: '🇱🇺'),
    Country(name: 'Malaysia', code: 'MY', dialCode: '+60', flag: '🇲🇾'),
    Country(name: 'Malta', code: 'MT', dialCode: '+356', flag: '🇲🇹'),
    Country(name: 'Mexico', code: 'MX', dialCode: '+52', flag: '🇲🇽'),
    Country(name: 'Moldova', code: 'MD', dialCode: '+373', flag: '🇲🇩'),
    Country(name: 'Mongolia', code: 'MN', dialCode: '+976', flag: '🇲🇳'),
    Country(name: 'Montenegro', code: 'ME', dialCode: '+382', flag: '🇲🇪'),
    Country(name: 'Netherlands', code: 'NL', dialCode: '+31', flag: '🇳🇱'),
    Country(name: 'Norway', code: 'NO', dialCode: '+47', flag: '🇳🇴'),
    Country(name: 'Philippines', code: 'PH', dialCode: '+63', flag: '🇵🇭'),
    Country(name: 'Poland', code: 'PL', dialCode: '+48', flag: '🇵🇱'),
    Country(name: 'Portugal', code: 'PT', dialCode: '+351', flag: '🇵🇹'),
    Country(name: 'Romania', code: 'RO', dialCode: '+40', flag: '🇷🇴'),
    Country(name: 'Russia', code: 'RU', dialCode: '+7', flag: '🇷🇺'),
    Country(name: 'Saudi Arabia', code: 'SA', dialCode: '+966', flag: '🇸🇦'),
    Country(name: 'Serbia', code: 'RS', dialCode: '+381', flag: '🇷🇸'),
    Country(name: 'Singapore', code: 'SG', dialCode: '+65', flag: '🇸🇬'),
    Country(name: 'Slovakia', code: 'SK', dialCode: '+421', flag: '🇸🇰'),
    Country(name: 'Slovenia', code: 'SI', dialCode: '+386', flag: '🇸🇮'),
    Country(name: 'South Africa', code: 'ZA', dialCode: '+27', flag: '🇿🇦'),
    Country(name: 'South Korea', code: 'KR', dialCode: '+82', flag: '🇰🇷'),
    Country(name: 'Spain', code: 'ES', dialCode: '+34', flag: '🇪🇸'),
    Country(name: 'Sweden', code: 'SE', dialCode: '+46', flag: '🇸🇪'),
    Country(name: 'Switzerland', code: 'CH', dialCode: '+41', flag: '🇨🇭'),
    Country(name: 'Tajikistan', code: 'TJ', dialCode: '+992', flag: '🇹🇯'),
    Country(name: 'Thailand', code: 'TH', dialCode: '+66', flag: '🇹🇭'),
    Country(name: 'Turkey', code: 'TR', dialCode: '+90', flag: '🇹🇷'),
    Country(name: 'Turkmenistan', code: 'TM', dialCode: '+993', flag: '🇹🇲'),
    Country(name: 'Ukraine', code: 'UA', dialCode: '+380', flag: '🇺🇦'),
    Country(
      name: 'United Arab Emirates',
      code: 'AE',
      dialCode: '+971',
      flag: '🇦🇪',
    ),
    Country(name: 'United Kingdom', code: 'GB', dialCode: '+44', flag: '🇬🇧'),
    Country(name: 'United States', code: 'US', dialCode: '+1', flag: '🇺🇸'),
    Country(name: 'Uzbekistan', code: 'UZ', dialCode: '+998', flag: '🇺🇿'),
    Country(name: 'Vietnam', code: 'VN', dialCode: '+84', flag: '🇻🇳'),
  ];

  static Country get defaultCountry =>
      countries.firstWhere((country) => country.code == 'US');

  static Country? findByDialCode(String dialCode) {
    try {
      return countries.firstWhere((country) => country.dialCode == dialCode);
    } catch (e) {
      return null;
    }
  }

  static List<Country> searchCountries(String query) {
    if (query.isEmpty) return countries;

    final lowercaseQuery = query.toLowerCase();
    return countries.where((country) {
      return country.name.toLowerCase().contains(lowercaseQuery) ||
          country.dialCode.contains(query) ||
          country.code.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
