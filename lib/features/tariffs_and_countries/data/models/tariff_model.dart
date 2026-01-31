import 'package:vink_sim/features/tariffs_and_countries/domain/entities/tariff.dart';

class TariffModel extends Tariff {
  const TariffModel({
    required super.plmn,
    required super.networkName,
    required super.countryName,
    required super.dataRate,
  });

  factory TariffModel.fromJson(Map<String, dynamic> json) {
    return TariffModel(
      plmn: json['plmn'] as String? ?? json['PLMN'] as String? ?? '',
      networkName:
          json['network_name'] as String? ??
          json['NetworkName'] as String? ??
          '',
      countryName:
          json['country_name'] as String? ??
          json['CountryName'] as String? ??
          '',
      dataRate:
          (json['data_rate'] as num?)?.toDouble() ??
          (json['DataRate'] as num?)?.toDouble() ??
          0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plmn': plmn,
      'network_name': networkName,
      'country_name': countryName,
      'data_rate': dataRate,
    };
  }
}
