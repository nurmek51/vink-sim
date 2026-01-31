import 'package:equatable/equatable.dart';

class Tariff extends Equatable {
  final String plmn;
  final String networkName;
  final String countryName;
  final double dataRate;

  const Tariff({
    required this.plmn,
    required this.networkName,
    required this.countryName,
    required this.dataRate,
  });

  @override
  List<Object?> get props => [plmn, networkName, countryName, dataRate];
}
