import 'package:flutter/material.dart';

class FeatureConfig {
  final String? authToken;
  final String? refreshToken;
  final VoidCallback? onExit;
  final String? apiBaseUrl;
  final bool isShellMode;
  final void Function(Locale locale)? onLocaleChanged;
  final void Function({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
  })? onAuthSuccess;
  final VoidCallback? onLogout;

  const FeatureConfig({
    this.authToken,
    this.refreshToken,
    this.onExit,
    this.apiBaseUrl,
    this.isShellMode = false,
    this.onLocaleChanged,
    this.onAuthSuccess,
    this.onLogout,
  });
}
