import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/expanded_container.dart';
import 'package:flex_travel_sim/features/activated_esim_screen/widgets/esim_success_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';
import 'package:flex_travel_sim/shared/widgets/header.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class ActivatedEsimScreen extends StatelessWidget {
  const ActivatedEsimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 45, 16, 40),
          child: Column(
            children: [
              Header(
                color: AppColors.textColorDark,
                faqOnTap: () => openGuidePage(context),
                avatarOnTap: () => openMyAccountScreen(context),
              ),
              const SizedBox(height: 20),
              const EsimSuccessContainer(),
              const SizedBox(height: 20),

              Row(
                children: [
                  ExpandedContainer(
                    title: AppLocalization.howToInstallEsim2,
                    icon: Assets.icons.figma149.blueIcon11.path,
                    onTap: () => openEsimSetupPage(context),
                  ),
                  const SizedBox(width: 16),
                  ExpandedContainer(
                    title: AppLocalization.supportChat,
                    icon: Assets.icons.figma149.blueIcon22.path,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder:
                            (context) => Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: BottomSheetContent(),
                              ),
                            ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ExpandedContainer(
                    title: AppLocalization.howDoesItWork,
                    icon: Assets.icons.figma149.blueIcon33.path,
                    onTap: () => openGuidePage(context),
                  ),
                  const SizedBox(width: 16),
                  ExpandedContainer(
                    title: AppLocalization.countriesAndRates,
                    icon: Assets.icons.figma149.blueIcon44.path,
                    onTap: () => openTariffsAndCountriesPage(context),
                  ),
                ],
              ),

              Spacer(),
              BlueGradientButton(
                onTap: () => openTopUpBalanceScreen(context),
                title: AppLocalization.topUpBalance,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
