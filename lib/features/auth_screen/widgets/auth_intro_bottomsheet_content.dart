import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/main_flow_screen/bottom_sheet_content.dart';
import 'package:flex_travel_sim/features/main_flow_screen/widgets/expanded_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
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
          SizedBox(height: 20),
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
