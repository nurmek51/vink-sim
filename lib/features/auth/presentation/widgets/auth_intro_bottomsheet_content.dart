import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/shared/widgets/icon_container.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class AuthIntroBottomsheetContent extends StatelessWidget {
  final VoidCallback? onActivateTap;

  const AuthIntroBottomsheetContent({super.key, this.onActivateTap});

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
                  text: SimLocalizations.of(context)!.how_to_install_esim2,
                  iconPath: Assets.icons.figma149.blueIcon11.path,
                  onTap: () => openEsimSetupPage(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: IconContainer(
                  text: SimLocalizations.of(context)!.support_chat,
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
                  text: SimLocalizations.of(context)!.how_does_it_work,
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
                  text: SimLocalizations.of(context)!.countries_and_rates,
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
            onTap: onActivateTap ?? () => Navigator.pop(context),
            child: Container(
              alignment: Alignment.center,
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.containerGradientPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: LocalizedText(
                SimLocalizations.of(context)!.activate_esim,
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
