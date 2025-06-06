import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

/// Simple test widget to verify navigation is working
class NavigationTestWidget extends StatelessWidget {
  const NavigationTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Test'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () => NavigationService.goToWelcome(context),
            child: const Text('Go to Welcome'),
          ),
          ElevatedButton(
            onPressed: () => NavigationService.goToAuth(context),
            child: const Text('Go to Auth'),
          ),
          ElevatedButton(
            onPressed: () => NavigationService.goToMainFlow(context),
            child: const Text('Go to Main Flow'),
          ),
          ElevatedButton(
            onPressed: () => openEsimSetupPage(context),
            child: const Text('Open eSIM Setup'),
          ),
          ElevatedButton(
            onPressed: () => openTopUpBalanceScreen(context),
            child: const Text('Open Top Up Balance'),
          ),
          ElevatedButton(
            onPressed: () => openMyAccountScreen(context),
            child: const Text('Open My Account'),
          ),
          ElevatedButton(
            onPressed: () => openGuidePage(context),
            child: const Text('Open Guide'),
          ),
          ElevatedButton(
            onPressed: () => openTariffsAndCountriesPage(context),
            child: const Text('Open Tariffs & Countries'),
          ),
        ],
      ),
    );
  }
}
