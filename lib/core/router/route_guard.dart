import 'package:flex_travel_sim/core/router/app_router.dart';
import 'package:go_router/go_router.dart';

/// Route guard for handling authentication and navigation permissions
class RouteGuard {
  /// Check if user is authenticated (placeholder for future implementation)
  static bool get isAuthenticated {
    // TODO: Implement actual authentication check
    // This could check SharedPreferences, Secure Storage, or global state
    return true; // For now, always return true
  }

  /// Check if user has completed onboarding
  static bool get hasCompletedOnboarding {
    // TODO: Implement onboarding completion check
    return true; // For now, always return true
  }

  /// Redirect logic for protected routes
  static String? redirectLogic(GoRouterState state) {
    final isOnWelcomeScreen = state.uri.path == AppRoutes.initial;
    final isOnAuthScreen = state.uri.path == AppRoutes.auth;
    
    // If user is not authenticated and not on auth/welcome screens
    if (!isAuthenticated && !isOnAuthScreen && !isOnWelcomeScreen) {
      return AppRoutes.initial;
    }

    // If user is authenticated but hasn't completed onboarding
    if (isAuthenticated && !hasCompletedOnboarding && !isOnWelcomeScreen) {
      return AppRoutes.initial;
    }

    // No redirect needed
    return null;
  }

  /// List of public routes that don't require authentication
  static const List<String> publicRoutes = [
    AppRoutes.welcome,
    AppRoutes.auth,
    AppRoutes.initial,
  ];

  /// Check if a route is public
  static bool isPublicRoute(String path) {
    return publicRoutes.contains(path);
  }

  /// List of routes that require authentication
  static const List<String> protectedRoutes = [
    AppRoutes.mainFlow,
    AppRoutes.topUpBalance,
    AppRoutes.myAccount,
    AppRoutes.purchaseHistory,
    AppRoutes.trafficUsage,
    AppRoutes.settings,
  ];

  /// Check if a route requires authentication
  static bool isProtectedRoute(String path) {
    return protectedRoutes.contains(path);
  }
}
