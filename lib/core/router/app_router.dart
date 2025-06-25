import 'package:flex_travel_sim/features/auth/presentation/screens/auth_screen.dart';
import 'package:flex_travel_sim/features/language_screen/language_screen.dart';
import 'package:flex_travel_sim/features/dashboard/screens/main_flow_screen.dart';
import 'package:flex_travel_sim/features/my_account_screen/my_account_screen.dart';
import 'package:flex_travel_sim/features/settings/screens/purchase_history_screen.dart';
import 'package:flex_travel_sim/features/settings/screens/settings_screen.dart';
import 'package:flex_travel_sim/features/esim_management/screens/esim_setup_page.dart';
import 'package:flex_travel_sim/features/guide_page/views/guide_page.dart';
import 'package:flex_travel_sim/features/setting_esim_page/views/setting_esim_page.dart';
import 'package:flex_travel_sim/features/activated_esim_screen/views/activated_esim_screen.dart';
import 'package:flex_travel_sim/features/initial_page/views/initial_page.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/top_up_balance_screen.dart';
import 'package:flex_travel_sim/features/traffic_usage_screen/traffic_usage_screen.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/screens/tariffs_and_countries_screen.dart';
import 'package:flex_travel_sim/features/onboarding/screens/welcome_screen.dart';
import 'package:flex_travel_sim/core/router/route_guard.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.welcome,
    redirect: (context, state) => RouteGuard.redirectLogic(state),
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        name: AppRoutes.welcomeName,
        pageBuilder:
            (context, state) => _buildPageWithSlideTransition(
              context,
              state,
              const WelcomeScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.auth,
        name: AppRoutes.authName,
        pageBuilder:
            (context, state) => _buildPageWithSlideTransition(
              context,
              state,
              const AuthScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.initial,
        name: AppRoutes.initialName,
        pageBuilder:
            (context, state) =>
                _buildPageWithNoTransition(context, state, const InitialPage()),
      ),
      GoRoute(
        path: AppRoutes.mainFlow,
        name: AppRoutes.mainFlowName,
        pageBuilder:
            (context, state) => _buildPageWithNoTransition(
              context,
              state,
              const MainFlowScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.esimSetup,
        name: AppRoutes.esimSetupName,
        pageBuilder:
            (context, state) => _buildPageWithNoTransition(
              context,
              state,
              const EsimSetupPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.settingEsim,
        name: AppRoutes.settingEsimName,
        pageBuilder:
            (context, state) => _buildPageWithNoTransition(
              context,
              state,
              const SettingEsimPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.activatedEsim,
        name: AppRoutes.activatedEsimName,
        pageBuilder:
            (context, state) => _buildPageWithNoTransition(
              context,
              state,
              const ActivatedEsimScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.topUpBalance,
        name: AppRoutes.topUpBalanceName,
        pageBuilder:
            (context, state) => _buildPageWithNoTransition(
              context,
              state,
              const TopUpBalanceScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.myAccount,
        name: AppRoutes.myAccountName,
        pageBuilder:
            (context, state) => _buildPageWithSlideTransition(
              context,
              state,
              const MyAccountScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.guide,
        name: AppRoutes.guideName,
        pageBuilder:
            (context, state) => _buildPageWithSlideTransition(
              context,
              state,
              const GuidePage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.tariffsAndCountries,
        name: AppRoutes.tariffsAndCountriesName,
        pageBuilder:
            (context, state) => _buildPageWithSlideTransition(
              context,
              state,
              const TariffsAndCountriesScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settingsName,
        pageBuilder:
            (context, state) => _buildPageWithSlideTransition(
              context,
              state,
              const SettingsScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.purchaseHistory,
        name: AppRoutes.purchaseHistoryName,
        pageBuilder:
            (context, state) => _buildPageWithSlideTransition(
              context,
              state,
              const PurchaseScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.trafficUsage,
        name: AppRoutes.trafficUsageName,
        pageBuilder:
            (context, state) => _buildPageWithSlideTransition(
              context,
              state,
              const TrafficUsageScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.language,
        name: AppRoutes.languageName,
        pageBuilder:
            (context, state) => _buildPageWithSlideTransition(
              context,
              state,
              const LanguageScreen(),
            ),
      ),
    ],
  );

  // No transition page builder
  static Page _buildPageWithNoTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  // Slide transition page builder
  static Page _buildPageWithSlideTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}

// Route paths and names
class AppRoutes {
  // Route paths
  static const String welcome = '/';
  static const String auth = '/auth';
  static const String initial = '/initial';
  static const String mainFlow = '/main-flow';
  static const String esimSetup = '/esim-setup';
  static const String settingEsim = '/setting-esim';
  static const String activatedEsim = '/activated-esim';
  static const String topUpBalance = '/top-up-balance';
  static const String myAccount = '/my-account';
  static const String guide = '/guide';
  static const String tariffsAndCountries = '/tariffs-and-countries';
  static const String settings = '/settings';
  static const String purchaseHistory = '/purchase-history';
  static const String trafficUsage = '/traffic-usage';
  static const String language = '/language';

  // Route names
  static const String welcomeName = 'welcome';
  static const String authName = 'auth';
  static const String initialName = 'initial';
  static const String mainFlowName = 'mainFlow';
  static const String esimSetupName = 'esimSetup';
  static const String settingEsimName = 'settingEsim';
  static const String activatedEsimName = 'activatedEsim';
  static const String topUpBalanceName = 'topUpBalance';
  static const String myAccountName = 'myAccount';
  static const String guideName = 'guide';
  static const String tariffsAndCountriesName = 'tariffsAndCountries';
  static const String settingsName = 'settings';
  static const String purchaseHistoryName = 'purchaseHistory';
  static const String trafficUsageName = 'trafficUsage';
  static const String languageName = 'language';
}