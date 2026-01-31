import 'package:vink_sim/core/router/app_router.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/core/services/token_manager.dart';
import 'package:go_router/go_router.dart';

/// Route guard for handling authentication and navigation permissions
class RouteGuard {
  /// Check if user is authenticated
  static Future<bool> get isAuthenticated async {
    try {
      final tokenManager = sl.get<TokenManager>();
      return await tokenManager.isTokenValid();
    } catch (e) {
      return false;
    }
  }

  /// Check if user has completed onboarding
  static bool get hasCompletedOnboarding {
    // TODO: Implement onboarding completion check
    return true; // For now, always return true
  }

  /// Redirect logic for protected routes
  static Future<String?> redirectLogic(GoRouterState state) async {
    final currentPath = state.uri.path;
    final isOnInitialScreen = currentPath == AppRoutes.initial;
    final userIsAuthenticated = await isAuthenticated;

    if (isOnInitialScreen) return null;
        
    // If user is not authenticated and trying to access protected routes
    if (!userIsAuthenticated && isProtectedRoute(currentPath)) {
      return AppRoutes.welcome;
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
    AppRoutes.esimEntry,
  ];

  /// Check if a route requires authentication
  static bool isProtectedRoute(String path) {
    return protectedRoutes.contains(path);
  }
}
