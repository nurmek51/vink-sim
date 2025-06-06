import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/features/main_flow_screen/bottom_sheet_content.dart';
import 'package:flex_travel_sim/shared/widgets/icon_container.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class AuthIntroBottomsheetContent extends StatelessWidget {
  const AuthIntroBottomsheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: IconContainer(
                  text: AppLocalization.howToInstallEsim2,
                  iconPath: 'assets/icons/figma149/blue_icon11.svg',
                  onTap: () => openEsimSetupPage(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: IconContainer(
                  text: AppLocalization.supportChat,
                  iconPath: 'assets/icons/figma149/blue_icon22.svg',
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
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: BottomSheetContent(),
                            ),
                          ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: IconContainer(
                  text: AppLocalization.howDoesItWork,
                  iconPath: 'assets/icons/figma149/blue_icon33.svg',
                  onTap: () => openGuidePage(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: IconContainer(
                  text: AppLocalization.countriesAndRates,
                  iconPath: 'assets/icons/figma149/blue_icon44.svg',
                  onTap: () => openTariffsAndCountriesPage(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => openTopUpBalanceScreen(context),
            child: Container(
              alignment: Alignment.center,
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.containerGradientPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                AppLocalization.activateEsim,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
