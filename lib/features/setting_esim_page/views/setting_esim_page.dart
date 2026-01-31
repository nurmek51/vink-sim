import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/features/setting_esim_page/widgets/steps_container.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:vink_sim/shared/widgets/start_registration_button.dart';
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
          SimLocalizations.of(context)!.guide_for_esim_settings,
          style: FlexTypography.label.medium,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      bottomNavigationBar:
          isAuthorized
              ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ).copyWith(bottom: 30, top: 12),
                child: StartRegistrationButton(),
              )
              : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
            child: Center(
              child: Column(
                children: [
                  StepsContainer(
                    iconPath: Assets.icons.figma143.step1Icon.path,
                    args: ['1'],
                    description:
                        SimLocalizations.of(
                          context,
                        )!.balance_and_esim_activation,
                  ),
                  const SizedBox(height: 12),
                  StepsContainer(
                    iconPath: Assets.icons.figma143.step2Icon.path,
                    args: ['2'],
                    description:
                        SimLocalizations.of(context)!.profile_setup_guide,
                  ),
                  const SizedBox(height: 12),
                  StepsContainer(
                    iconPath: Assets.icons.figma143.step3Icon.path,
                    args: ['3'],
                    description:
                        SimLocalizations.of(context)!.ready_to_travel_message,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
