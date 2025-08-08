import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/setting_esim_page/widgets/steps_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/shared/widgets/start_registration_button.dart';
import 'package:flutter/material.dart';

class SettingEsimPage extends StatelessWidget {
  final bool isAuthorized;

  const SettingEsimPage({super.key, this.isAuthorized = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColorLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: LocalizedText(
          AppLocalizations.guideForEsimSettings,
          style: FlexTypography.label.medium,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Center(
              child: Column(
                children: [
                  StepsContainer(
                    iconPath: Assets.icons.figma143.step1Icon.path,
                    args: ['1'],
                    description: AppLocalizations.balanceAndEsimActivation,
                  ),
                  SizedBox(height: 7),
                  StepsContainer(
                    iconPath: Assets.icons.figma143.step2Icon.path,
                    args: ['2'],
                    description: AppLocalizations.profileSetupGuide,
                  ),
                  SizedBox(height: 7),
                  StepsContainer(
                    iconPath: Assets.icons.figma143.step3Icon.path,
                    args: ['3'],
                    description: AppLocalizations.readyToTravelMessage,
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
            child: Visibility(
              visible: isAuthorized,
              child: StartRegistrationButton(),
            ),
          ),
        ],
      ),
    );
  }
}
