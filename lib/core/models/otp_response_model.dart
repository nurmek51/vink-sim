import 'package:equatable/equatable.dart';

class OtpResponseModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final int refreshExpiresIn;
  final String userId;
  final String firebaseCustomToken;

  const OtpResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.userId,
    required this.firebaseCustomToken,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return OtpResponseModel(
      accessToken: data['access_token'] ?? data['token'] ?? '',
      refreshToken: data['refresh_token'] ?? '',
      tokenType: data['token_type'] ?? 'bearer',
      expiresIn: data['expires_in'] ?? 0,
      refreshExpiresIn: data['refresh_expires_in'] ?? 0,
      userId: data['user_id'] ?? '',
      firebaseCustomToken: data['firebase_custom_token'] ?? '',
    );
  }

  // Helper alias for backward compatibility if needed, though we should migrate usages
  String get token => accessToken;

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'refresh_expires_in': refreshExpiresIn,
      'user_id': userId,
      'firebase_custom_token': firebaseCustomToken,
    };
  }

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        tokenType,
        expiresIn,
        refreshExpiresIn,
        userId,
        firebaseCustomToken,
      ];
}
