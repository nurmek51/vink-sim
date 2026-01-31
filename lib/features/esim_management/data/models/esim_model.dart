import 'package:equatable/equatable.dart';
import 'package:vink_sim/features/esim_management/domain/entities/esim.dart';

class EsimModel extends Equatable {
  final String id;
  final String name;
  final String provider;
  final String country;
  final String region;
  final bool isActive;
  final double dataUsed;
  final double dataLimit;
  final DateTime? activationDate;
  final DateTime? expirationDate;
  final String status;
  final String? qrCode;
  final String? activationCode;
  final double price;
  final String currency;
  final List<String> supportedNetworks;

  const EsimModel({
    required this.id,
    required this.name,
    required this.provider,
    required this.country,
    required this.region,
    required this.isActive,
    required this.dataUsed,
    required this.dataLimit,
    this.activationDate,
    this.expirationDate,
    required this.status,
    this.qrCode,
    this.activationCode,
    required this.price,
    required this.currency,
    required this.supportedNetworks,
  });

  factory EsimModel.fromJson(Map<String, dynamic> json) {
    return EsimModel(
      id: json['id'] as String,
      name: json['name'] as String,
      provider: json['provider'] as String,
      country: json['country'] as String,
      region: json['region'] as String,
      isActive: json['is_active'] as bool,
      dataUsed: (json['data_used'] as num).toDouble(),
      dataLimit: (json['data_limit'] as num).toDouble(),
      activationDate:
          json['activation_date'] != null
              ? DateTime.parse(json['activation_date'] as String)
              : null,
      expirationDate:
          json['expiration_date'] != null
              ? DateTime.parse(json['expiration_date'] as String)
              : null,
      status: json['status'] as String,
      qrCode: json['qr_code'] as String?,
      activationCode: json['activation_code'] as String?,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      supportedNetworks: List<String>.from(json['supported_networks'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'provider': provider,
      'country': country,
      'region': region,
      'is_active': isActive,
      'data_used': dataUsed,
      'data_limit': dataLimit,
      'activation_date': activationDate?.toIso8601String(),
      'expiration_date': expirationDate?.toIso8601String(),
      'status': status,
      'qr_code': qrCode,
      'activation_code': activationCode,
      'price': price,
      'currency': currency,
      'supported_networks': supportedNetworks,
    };
  }

  Esim toEntity() {
    return Esim(
      id: id,
      name: name,
      provider: provider,
      country: country,
      region: region,
      isActive: isActive,
      dataUsed: dataUsed,
      dataLimit: dataLimit,
      activationDate: activationDate,
      expirationDate: expirationDate,
      status: status,
      qrCode: qrCode,
      activationCode: activationCode,
      price: price,
      currency: currency,
      supportedNetworks: supportedNetworks,
    );
  }

  factory EsimModel.fromEntity(Esim entity) {
    return EsimModel(
      id: entity.id,
      name: entity.name,
      provider: entity.provider,
      country: entity.country,
      region: entity.region,
      isActive: entity.isActive,
      dataUsed: entity.dataUsed,
      dataLimit: entity.dataLimit,
      activationDate: entity.activationDate,
      expirationDate: entity.expirationDate,
      status: entity.status,
      qrCode: entity.qrCode,
      activationCode: entity.activationCode,
      price: entity.price,
      currency: entity.currency,
      supportedNetworks: entity.supportedNetworks,
    );
  }

  EsimModel copyWith({
    String? id,
    String? name,
    String? provider,
    String? country,
    String? region,
    bool? isActive,
    double? dataUsed,
    double? dataLimit,
    DateTime? activationDate,
    DateTime? expirationDate,
    String? status,
    String? qrCode,
    String? activationCode,
    double? price,
    String? currency,
    List<String>? supportedNetworks,
  }) {
    return EsimModel(
      id: id ?? this.id,
      name: name ?? this.name,
      provider: provider ?? this.provider,
      country: country ?? this.country,
      region: region ?? this.region,
      isActive: isActive ?? this.isActive,
      dataUsed: dataUsed ?? this.dataUsed,
      dataLimit: dataLimit ?? this.dataLimit,
      activationDate: activationDate ?? this.activationDate,
      expirationDate: expirationDate ?? this.expirationDate,
      status: status ?? this.status,
      qrCode: qrCode ?? this.qrCode,
      activationCode: activationCode ?? this.activationCode,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      supportedNetworks: supportedNetworks ?? this.supportedNetworks,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    provider,
    country,
    region,
    isActive,
    dataUsed,
    dataLimit,
    activationDate,
    expirationDate,
    status,
    qrCode,
    activationCode,
    price,
    currency,
    supportedNetworks,
  ];
}
