class AuthToken {
  final String token;
  final String refreshToken;
  final int expiresIn;

  AuthToken({
    required this.token,
    required this.refreshToken,
    required this.expiresIn,
  });
}
