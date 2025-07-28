import 'package:equatable/equatable.dart';

class OtpResponseModel extends Equatable {
  final String token;

  const OtpResponseModel({required this.token});

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }

  @override
  List<Object?> get props => [token];
}