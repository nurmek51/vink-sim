class NetworkOperatorModel {
  final String plmn;
  final String networkName;
  final String countryName;
  final double dataRate;

  const NetworkOperatorModel({
    required this.plmn,
    required this.networkName,
    required this.countryName,
    required this.dataRate,
  });

  factory NetworkOperatorModel.fromJson(Map<String, dynamic> json) {
    return NetworkOperatorModel(
      plmn: json['PLMN'] as String,
      networkName: json['NetworkName'] as String,
      countryName: json['CountryName'] as String,
      dataRate: (json['DataRate'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PLMN': plmn,
      'NetworkName': networkName,
      'CountryName': countryName,
      'DataRate': dataRate,
    };
  }

  @override
  String toString() {
    return 'NetworkOperatorModel(plmn: $plmn, networkName: $networkName, countryName: $countryName, dataRate: $dataRate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NetworkOperatorModel &&
        other.plmn == plmn &&
        other.networkName == networkName &&
        other.countryName == countryName &&
        other.dataRate == dataRate;
  }

  @override
  int get hashCode {
    return plmn.hashCode ^
        networkName.hashCode ^
        countryName.hashCode ^
        dataRate.hashCode;
  }
}