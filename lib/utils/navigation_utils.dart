import 'package:flex_travel_sim/core/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class NavigationService {
  // Push navigation (adds to stack)
  static void openTariffsAndCountriesPage(BuildContext context, {bool isAuthorized = false}) {
    final qp = isAuthorized ? '?isAuthorized=true' : '';
    context.push('${AppRoutes.tariffsAndCountries}$qp');
  }
  
  static void openSettingsEsimPage(BuildContext context, {bool isAuthorized = false}) {
    final qp = isAuthorized ? '?isAuthorized=true' : '';
    context.push('${AppRoutes.settingEsim}$qp');
  }

  static void openEsimSetupPage(BuildContext context) {
    context.push(AppRoutes.esimSetup);
  }

  static void openTopUpBalanceScreen(BuildContext context) {
    context.push(AppRoutes.topUpBalance);
  }

  static void openAuthScreen(BuildContext context) {
    context.push(AppRoutes.auth);
  }


  static void openPurchaseScreen(BuildContext context) {
    context.push(AppRoutes.purchaseHistory);
  }

  static void openMyAccountScreen(BuildContext context) {
    context.push(AppRoutes.myAccount);
  }
  
  static void openGuidePage(BuildContext context, {bool isAuthorized = false}) {
    final qp = isAuthorized ? '?isAuthorized=true' : '';
    context.push('${AppRoutes.guide}$qp');
  }

  static void openSettingsScreen(BuildContext context) {
    context.push(AppRoutes.settings);
  }

  static void openTrafficUsageScreen(BuildContext context) {
    context.push(AppRoutes.trafficUsage);
  }

  static void openLanguageScreen(BuildContext context) {
    context.push(AppRoutes.language);
  }

  static void openUserProfileScreen(BuildContext context) {
    context.push(AppRoutes.myAccount);
  }

  // Push replacement navigation (replaces current route)
  static void openInitialPage(BuildContext context) {
    context.pushReplacement(AppRoutes.initial);
  }

  static void openMainFlowScreen(BuildContext context) {
    context.pushReplacement(AppRoutes.mainFlow);
  }

  static void openActivatedEsimScreen(BuildContext context) {
    context.pushReplacement(AppRoutes.activatedEsim);
  }

  // Go navigation (replaces entire stack)
  static void goToWelcome(BuildContext context) {
    context.go(AppRoutes.welcome);
  }

  static void goToMainFlow(BuildContext context) {
    context.go(AppRoutes.mainFlow);
  }

  static void goToAuth(BuildContext context) {
    context.go(AppRoutes.auth);
  }

  // Named navigation
  static void pushNamed(BuildContext context, String routeName, {Map<String, String>? pathParameters}) {
    context.pushNamed(routeName, pathParameters: pathParameters ?? {});
  }

  static void goNamed(BuildContext context, String routeName, {Map<String, String>? pathParameters}) {
    context.goNamed(routeName, pathParameters: pathParameters ?? {});
  }

  // Pop navigation
  static void pop(BuildContext context) {
    context.pop();
  }

  static bool canPop(BuildContext context) {
    return context.canPop();
  }
}

// Legacy function aliases for backward compatibility
void openSettingsEsimPage(BuildContext context) => NavigationService.openSettingsEsimPage(context);
void openEsimSetupPage(BuildContext context) => NavigationService.openEsimSetupPage(context);
void openInitialPage(BuildContext context) => NavigationService.openInitialPage(context);
void openTopUpBalanceScreen(BuildContext context) => NavigationService.openTopUpBalanceScreen(context);
void openMainFlowScreen(BuildContext context) => NavigationService.openMainFlowScreen(context);
void openAuthScreen(BuildContext context) => NavigationService.openAuthScreen(context);
void openActivatedEsimScreen(BuildContext context) => NavigationService.openActivatedEsimScreen(context);
void openPurchaseScreen(BuildContext context) => NavigationService.openPurchaseScreen(context);
void openMyAccountScreen(BuildContext context) => NavigationService.openMyAccountScreen(context);
void openGuidePage(BuildContext context) => NavigationService.openGuidePage(context);
void openTariffsAndCountriesPage(BuildContext context) => NavigationService.openTariffsAndCountriesPage(context);
void openSettingsScreen(BuildContext context) => NavigationService.openSettingsScreen(context);
