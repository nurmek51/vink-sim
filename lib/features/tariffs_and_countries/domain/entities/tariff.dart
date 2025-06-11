import 'package:equatable/equatable.dart';

class Tariff extends Equatable {
  final String id;
  final String name;
  final String description;
  final String countryCode;
  final String countryName;
  final String region;
  final double dataAmount;
  final int validityDays;
  final double price;
  final String currency;
  final List<String> features;
  final List<String> restrictions;
  final bool isUnlimited;
  final String? speedLimit;
  final bool isRoamingEnabled;
  final List<String> supportedNetworks;
  final String provider;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tariff({
    required this.id,
    required this.name,
    required this.description,
    required this.countryCode,
    required this.countryName,
    required this.region,
    required this.dataAmount,
    required this.validityDays,
    required this.price,
    required this.currency,
    required this.features,
    required this.restrictions,
    required this.isUnlimited,
    this.speedLimit,
    required this.isRoamingEnabled,
    required this.supportedNetworks,
    required this.provider,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  String get formattedDataAmount {
    if (isUnlimited) return 'Unlimited';
    return '${dataAmount.toStringAsFixed(1)} GB';
  }

  String get formattedPrice {
    return '${price.toStringAsFixed(2)} $currency';
  }

  String get formattedValidity {
    if (validityDays == 1) return '1 day';
    if (validityDays < 30) return '$validityDays days';
    if (validityDays == 30) return '1 month';
    if (validityDays < 365) {
      final months = (validityDays / 30).round();
      return '$months months';
    }
    final years = (validityDays / 365).round();
    return '$years years';
  }

  double get pricePerGb {
    if (isUnlimited || dataAmount == 0) return 0;
    return price / dataAmount;
  }

  String get formattedPricePerGb {
    if (isUnlimited) return 'N/A';
    return '${pricePerGb.toStringAsFixed(2)} $currency/GB';
  }

  bool get isBestValue {
    return pricePerGb < 5.0 && validityDays >= 7;
  }

  bool get isPopular {
    return dataAmount >= 5.0 && validityDays >= 7 && validityDays <= 30;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    countryCode,
    countryName,
    region,
    dataAmount,
    validityDays,
    price,
    currency,
    features,
    restrictions,
    isUnlimited,
    speedLimit,
    isRoamingEnabled,
    supportedNetworks,
    provider,
    isActive,
    createdAt,
    updatedAt,
  ];
}
