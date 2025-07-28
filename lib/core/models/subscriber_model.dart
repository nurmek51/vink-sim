import 'package:equatable/equatable.dart';
import 'package:flex_travel_sim/core/models/imsi_model.dart';

class SubscriberModel extends Equatable {
  final double balance;
  final List<ImsiModel> imsiList;

  const SubscriberModel({
    required this.balance,
    required this.imsiList,
  });

  factory SubscriberModel.fromJson(Map<String, dynamic> json) {
    return SubscriberModel(
      balance: (json['balance'] as num).toDouble(),
      imsiList: (json['imsi'] as List<dynamic>)
          .map((imsi) => ImsiModel.fromJson(imsi as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'imsi': imsiList.map((imsi) => imsi.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [balance, imsiList];
}