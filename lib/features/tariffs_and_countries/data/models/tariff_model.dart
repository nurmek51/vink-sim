import 'package:equatable/equatable.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/domain/entities/tariff.dart';

class TariffModel extends Equatable {
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

  const TariffModel({
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

  factory TariffModel.fromJson(Map<String, dynamic> json) {
    return TariffModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      countryCode: json['country_code'] as String,
      countryName: json['country_name'] as String,
      region: json['region'] as String,
      dataAmount: (json['data_amount'] as num).toDouble(),
      validityDays: json['validity_days'] as int,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      features: List<String>.from(json['features'] as List),
      restrictions: List<String>.from(json['restrictions'] as List),
      isUnlimited: json['is_unlimited'] as bool,
      speedLimit: json['speed_limit'] as String?,
      isRoamingEnabled: json['is_roaming_enabled'] as bool,
      supportedNetworks: List<String>.from(json['supported_networks'] as List),
      provider: json['provider'] as String,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'country_code': countryCode,
      'country_name': countryName,
      'region': region,
      'data_amount': dataAmount,
      'validity_days': validityDays,
      'price': price,
      'currency': currency,
      'features': features,
      'restrictions': restrictions,
      'is_unlimited': isUnlimited,
      'speed_limit': speedLimit,
      'is_roaming_enabled': isRoamingEnabled,
      'supported_networks': supportedNetworks,
      'provider': provider,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Tariff toEntity() {
    return Tariff(
      id: id,
      name: name,
      description: description,
      countryCode: countryCode,
      countryName: countryName,
      region: region,
      dataAmount: dataAmount,
      validityDays: validityDays,
      price: price,
      currency: currency,
      features: features,
      restrictions: restrictions,
      isUnlimited: isUnlimited,
      speedLimit: speedLimit,
      isRoamingEnabled: isRoamingEnabled,
      supportedNetworks: supportedNetworks,
      provider: provider,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory TariffModel.fromEntity(Tariff entity) {
    return TariffModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      countryCode: entity.countryCode,
      countryName: entity.countryName,
      region: entity.region,
      dataAmount: entity.dataAmount,
      validityDays: entity.validityDays,
      price: entity.price,
      currency: entity.currency,
      features: entity.features,
      restrictions: entity.restrictions,
      isUnlimited: entity.isUnlimited,
      speedLimit: entity.speedLimit,
      isRoamingEnabled: entity.isRoamingEnabled,
      supportedNetworks: entity.supportedNetworks,
      provider: entity.provider,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  TariffModel copyWith({
    String? id,
    String? name,
    String? description,
    String? countryCode,
    String? countryName,
    String? region,
    double? dataAmount,
    int? validityDays,
    double? price,
    String? currency,
    List<String>? features,
    List<String>? restrictions,
    bool? isUnlimited,
    String? speedLimit,
    bool? isRoamingEnabled,
    List<String>? supportedNetworks,
    String? provider,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TariffModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      region: region ?? this.region,
      dataAmount: dataAmount ?? this.dataAmount,
      validityDays: validityDays ?? this.validityDays,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      features: features ?? this.features,
      restrictions: restrictions ?? this.restrictions,
      isUnlimited: isUnlimited ?? this.isUnlimited,
      speedLimit: speedLimit ?? this.speedLimit,
      isRoamingEnabled: isRoamingEnabled ?? this.isRoamingEnabled,
      supportedNetworks: supportedNetworks ?? this.supportedNetworks,
      provider: provider ?? this.provider,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
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
