import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/language_screen/language_screen.dart';
import 'package:flex_travel_sim/feature/my_account_screen/widgets/account_widget.dart';
import 'package:flex_travel_sim/feature/purchase_history_screen.dart/purchase_history_screen.dart';
import 'package:flex_travel_sim/feature/traffic_usage_screen/traffic_usage_screen.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 20);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: horizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalization.myAccount, style: titleStyle),
              const SizedBox(height: 12),
              AccountWidget(
                title: AppLocalization.accountSettings,
                icon: Assets.icons.accountSettings.path,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              AccountWidget(
                title: AppLocalization.purchaseHistory,
                icon: Assets.icons.purchaseHistory.path,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PurchaseScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              AccountWidget(
                title: AppLocalization.trafficUsage,
                icon: Assets.icons.trafficUsage.path,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrafficUsageScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              AccountWidget(
                title: AppLocalization.appLanguage,
                icon: Assets.icons.appLanguage.path,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
