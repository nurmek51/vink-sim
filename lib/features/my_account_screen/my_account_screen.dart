import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/my_account_screen/widgets/account_widget.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text(
                AppLocalization.myAccount, 
                style: FlexTypography.headline.large.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              AccountWidget(
                title: AppLocalization.accountSettings,
                icon: Assets.icons.accountSettings.path,
                onTap: () => openSettingsScreen(context),
              ),
              const SizedBox(height: 12),
              AccountWidget(
                title: AppLocalization.purchaseHistory,
                icon: Assets.icons.purchaseHistory.path,
                onTap: () => NavigationService.openPurchaseScreen(context),
              ),
              const SizedBox(height: 12),
              AccountWidget(
                title: AppLocalization.trafficUsage,
                icon: Assets.icons.trafficUsage.path,
                onTap: () => NavigationService.openTrafficUsageScreen(context),
              ),
              const SizedBox(height: 12),
              AccountWidget(
                title: AppLocalization.appLanguage,
                icon: Assets.icons.appLanguage.path,
                onTap: () => NavigationService.openLanguageScreen(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
