import 'package:equatable/equatable.dart';

class ImsiModel extends Equatable {
  final String imsi;
  final double balance;
  final String? country;
  final String? iso;
  final String? brand;
  final double? rate;

  const ImsiModel({
    required this.imsi,
    required this.balance,
    this.country,
    this.iso,
    this.brand,
    this.rate,
  });

  factory ImsiModel.fromJson(Map<String, dynamic> json) {
    return ImsiModel(
      imsi: json['imsi'] as String,
      balance: (json['balance'] as num).toDouble(),
      country: json['country'] as String?,
      iso: json['iso'] as String?,
      brand: json['brand'] as String?,
      rate: json['rate'] != null ? (json['rate'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imsi': imsi,
      'balance': balance,
      if (country != null) 'country': country,
      if (iso != null) 'iso': iso,
      if (brand != null) 'brand': brand,
      if (rate != null) 'rate': rate,
    };
  }

  @override
  List<Object?> get props => [imsi, balance, country, iso, brand, rate];
}