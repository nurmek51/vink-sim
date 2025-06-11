import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? avatarUrl;
  final double balance;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final String preferredLanguage;
  final String preferredCurrency;
  final List<String> favoriteCountries;

  const User({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.avatarUrl,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.preferredLanguage,
    required this.preferredCurrency,
    required this.favoriteCountries,
  });

  String get fullName {
    final first = firstName ?? '';
    final last = lastName ?? '';
    
    if (first.isEmpty && last.isEmpty) {
      return email.split('@').first;
    }
    
    return '$first $last'.trim();
  }

  String get initials {
    final first = firstName?.isNotEmpty == true ? firstName![0] : '';
    final last = lastName?.isNotEmpty == true ? lastName![0] : '';
    
    if (first.isEmpty && last.isEmpty) {
      return email.isNotEmpty ? email[0].toUpperCase() : 'U';
    }
    
    return '$first$last'.toUpperCase();
  }

  String get formattedBalance {
    return '${balance.toStringAsFixed(2)} $currency';
  }

  bool get isProfileComplete {
    return firstName != null && 
           lastName != null && 
           phoneNumber != null &&
           isEmailVerified &&
           isPhoneVerified;
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        phoneNumber,
        avatarUrl,
        balance,
        currency,
        createdAt,
        updatedAt,
        isEmailVerified,
        isPhoneVerified,
        preferredLanguage,
        preferredCurrency,
        favoriteCountries,
      ];
}
