import 'package:equatable/equatable.dart';

class OtpResponseModel extends Equatable {
  final String token;

  const OtpResponseModel({required this.token});

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return OtpResponseModel(
      token: data['access_token'] ?? data['token'] ?? '',
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