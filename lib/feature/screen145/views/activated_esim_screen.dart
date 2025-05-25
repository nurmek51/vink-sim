import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/main_flow_screen/bottom_sheet_content.dart';
import 'package:flex_travel_sim/feature/main_flow_screen/widgets/expanded_container.dart';
import 'package:flex_travel_sim/feature/screen145/widgets/esim_success_container.dart';
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
              const Header(color: AppColors.textColorDark),
              const SizedBox(height: 20),
              const EsimSuccessContainer(),
              const SizedBox(height: 20),

              Row(
                children: [
                  ExpandedContainer(
                    title: AppLocalization.howToInstallEsim2,
                    icon: 'assets/icons/figma149/blue_icon11.svg',
                    onTap: () => openEsimSetupPage(context),
                  ),
                  const SizedBox(width: 16),
                  ExpandedContainer(
                    title: AppLocalization.supportChat,
                    icon: 'assets/icons/figma149/blue_icon22.svg',
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
                    icon: 'assets/icons/figma149/blue_icon33.svg',
                    onTap: () => openGuidePage(context),
                  ),
                  const SizedBox(width: 16),
                  ExpandedContainer(
                    title: AppLocalization.countriesAndRates,
                    icon: 'assets/icons/figma149/blue_icon44.svg',
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
