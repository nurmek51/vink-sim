import 'package:flex_travel_sim/features/auth_screen/auth_screen.dart';
import 'package:flex_travel_sim/features/main_flow_screen/main_flow_screen.dart';
import 'package:flex_travel_sim/features/my_account_screen/my_account_screen.dart';
import 'package:flex_travel_sim/features/purchase_history_screen.dart/purchase_history_screen.dart';
import 'package:flex_travel_sim/features/screen112/views/esim_setup_page.dart';
import 'package:flex_travel_sim/features/screen141/views/guide_page.dart';
import 'package:flex_travel_sim/features/screen142/views/tariffs_and_countries_page.dart';
import 'package:flex_travel_sim/features/screen143/views/setting_esim_page.dart';
import 'package:flex_travel_sim/features/screen145/views/activated_esim_screen.dart';
import 'package:flex_travel_sim/features/screen149/views/initial_page.dart';
import 'package:flex_travel_sim/features/settings_screen/views/settings_screen.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/top_up_balance_screen.dart';
import 'package:flutter/material.dart';

void openSettingsEsimPage(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SettingEsimPage(),
      transitionDuration: Duration.zero,       
      reverseTransitionDuration: Duration.zero,   
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;  
      },
    ),
  );
}

void openEsimSetupPage(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const EsimSetupPage(),
      transitionDuration: Duration.zero,       
      reverseTransitionDuration: Duration.zero,   
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;  
      },
    ),
  );
}

void openInitialPage(BuildContext context) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const InitialPage(),
      transitionDuration: Duration.zero,       
      reverseTransitionDuration: Duration.zero,   
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;  
      },
    ),
  );
}

void openTopUpBalanceScreen(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const TopUpBalanceScreen(),
      transitionDuration: Duration.zero,       
      reverseTransitionDuration: Duration.zero,   
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;  
      },
    ),
  );
}


void openMainFlowScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MainFlowScreen(),
      transitionDuration: Duration.zero,       
      reverseTransitionDuration: Duration.zero,   
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;  
      },
    ),
  );
}

void openAuthScreen(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const AuthScreen(),
      transitionDuration: Duration.zero,       
      reverseTransitionDuration: Duration.zero,   
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;  
      },
    ),
  );
}

void openActivatedEsimScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const ActivatedEsimScreen(),
      transitionDuration: Duration.zero,       
      reverseTransitionDuration: Duration.zero,   
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;  
      },
    ),
  );
}

void openPurchaseScreen(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const PurchaseScreen(),
      transitionDuration: Duration.zero,       
      reverseTransitionDuration: Duration.zero,   
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;  
      },
    ),
  );
}

void openMyAccountScreen(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => const MyAccountScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}

void openGuidePage(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => const GuidePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}

void openTariffsAndCountriesPage(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => const TariffsAndCountriesScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}

void openSettingsScreen(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => const SettingsScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}