import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/icon_container.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class AuthIntroBottomsheetContent extends StatelessWidget {
  const AuthIntroBottomsheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 45),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: IconContainer(
                  text: AppLocalizations.howToInstallEsim2,
                  iconPath: Assets.icons.figma149.blueIcon11.path,
                  onTap: () => openEsimSetupPage(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: IconContainer(
                  text: AppLocalizations.supportChat,
                  iconPath: Assets.icons.figma149.blueIcon22.path,
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
                  text: AppLocalizations.howDoesItWork,
                  iconPath: Assets.icons.figma149.blueIcon33.path,
                  onTap:
                      () => NavigationService.openGuidePage(
                        context,
                        isAuthorized: true,
                      ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: IconContainer(
                  text: AppLocalizations.countriesAndRates,
                  iconPath: Assets.icons.figma149.blueIcon44.path,
                  onTap:
                      () => NavigationService.openTariffsAndCountriesPage(
                        context,
                        isAuthorized: true,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              alignment: Alignment.center,
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.containerGradientPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const LocalizedText(
                AppLocalizations.activateEsim,
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
