import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Extension on BuildContext to provide convenient navigation methods
extension RouterExtensions on BuildContext {
  /// Navigate to a route by path
  void navigateTo(String path) => go(path);

  /// Push a new route onto the stack
  void pushTo(String path) => push(path);

  /// Replace the current route
  void replaceTo(String path) => pushReplacement(path);

  /// Navigate by route name
  void navigateToNamed(String name, {Map<String, String>? pathParameters}) =>
      goNamed(name, pathParameters: pathParameters ?? {});

  /// Push by route name
  void pushToNamed(String name, {Map<String, String>? pathParameters}) =>
      pushNamed(name, pathParameters: pathParameters ?? {});

  /// Pop the current route
  void goBack() => pop();

  /// Check if can pop
  bool canGoBack() => canPop();

  /// Get current route location
  String get currentLocation => GoRouterState.of(this).uri.toString();

  /// Get current route name
  String? get currentRouteName => GoRouterState.of(this).name;
}
