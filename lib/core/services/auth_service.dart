import 'package:flex_travel_sim/core/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AuthService {
  Future<void> logout();
  Future<bool> isAuthenticated();
  Future<void> clearUserSession();
}

class AuthServiceImpl implements AuthService {
  final LocalStorage localStorage;

  AuthServiceImpl({
    required this.localStorage,
  });

  @override
  Future<void> logout() async {
    await clearUserSession();
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await localStorage.getString('access_token');
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> clearUserSession() async {
    await localStorage.clear();
  }
}

class NavigationService {
  static void goToWelcome(BuildContext context) {
    context.go('/');
  }

  static void goToAuth(BuildContext context) {
    context.go('/auth');
  }

  static void goToMainFlow(BuildContext context) {
    context.go('/main-flow');
  }
}