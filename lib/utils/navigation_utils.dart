import 'package:flex_travel_sim/feature/auth_screen/auth_screen.dart';
import 'package:flex_travel_sim/feature/main_flow_screen/main_flow_screen.dart';
import 'package:flex_travel_sim/feature/my_account_screen/my_account_screen.dart';
import 'package:flex_travel_sim/feature/screen112/views/esim_setup_page.dart';
import 'package:flex_travel_sim/feature/screen141/views/guide_page.dart';
import 'package:flex_travel_sim/feature/screen142/views/tariffs_and_countries_page.dart';
import 'package:flex_travel_sim/feature/screen143/views/setting_esim_page.dart';
import 'package:flex_travel_sim/feature/screen145/views/activated_esim_screen.dart';
import 'package:flex_travel_sim/feature/screen149/views/initial_page.dart';
import 'package:flex_travel_sim/feature/top_up_balance_screen/top_up_balance_screen.dart';
import 'package:flutter/material.dart';

void openTariffsAndCountriesPage(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const TariffsAndCountriesScreen(),
      transitionDuration: Duration.zero,       
      reverseTransitionDuration: Duration.zero,   
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;  
      },
    ),
  );
}

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

void openGuidePage(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const GuidePage(),
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

void openMyAccountScreen(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MyAccountScreen(),
      transitionDuration: Duration.zero,       
      reverseTransitionDuration: Duration.zero,   
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;  
      },
    ),
  );
}
