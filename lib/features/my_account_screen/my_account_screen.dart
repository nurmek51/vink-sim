import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/my_account_screen/widgets/account_widget.dart';
import 'package:flex_travel_sim/features/my_account_screen/widgets/log_out_widget.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 20);

    return Scaffold(
      bottomNavigationBar: LogOutWidget(),
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: horizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LocalizedText(
                AppLocalizations.myAccount,
                style: FlexTypography.headline.large.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 35),
              //TODO: realize after backend

              // AccountWidget(
              //   title: AppLocalizations.purchaseHistory,
              //   icon: Assets.icons.purchaseHistory.path,
              //   onTap: () => NavigationService.openPurchaseScreen(context),
              // ),
              // const SizedBox(height: 12),
              // AccountWidget(
              //   title: AppLocalizations.trafficUsage,
              //   icon: Assets.icons.trafficUsage.path,
              //   onTap: () => NavigationService.openTrafficUsageScreen(context),
              // ),
              // const SizedBox(height: 12),
              AccountWidget(
                title: AppLocalizations.appLanguage,
                icon: Assets.icons.globusWithBackground.path,
                onTap: () => NavigationService.openLanguageScreen(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
