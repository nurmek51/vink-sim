import 'package:equatable/equatable.dart';

class Esim extends Equatable {
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

  const Esim({
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

  double get dataUsagePercentage {
    if (dataLimit == 0) return 0;
    return (dataUsed / dataLimit).clamp(0.0, 1.0);
  }

  bool get isExpired {
    if (expirationDate == null) return false;
    return DateTime.now().isAfter(expirationDate!);
  }

  bool get isNearExpiry {
    if (expirationDate == null) return false;
    final daysUntilExpiry = expirationDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiry <= 7 && daysUntilExpiry > 0;
  }

  bool get isDataAlmostUsed {
    return dataUsagePercentage >= 0.9;
  }

  String get formattedDataUsage {
    return '${dataUsed.toStringAsFixed(2)} GB / ${dataLimit.toStringAsFixed(2)} GB';
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
