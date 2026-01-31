import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:vink_sim/features/dashboard/widgets/expanded_container.dart';
import 'package:vink_sim/features/activated_esim_screen/widgets/esim_success_container.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/shared/widgets/blue_gradient_button.dart';
import 'package:vink_sim/shared/widgets/header.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class ActivatedEsimScreen extends StatelessWidget {
  const ActivatedEsimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 50,
            left: 20,
            right: 20,
          ),
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
                    title: SimLocalizations.of(context)!.how_to_install_esim2,
                    icon: Assets.icons.figma149.blueIcon11.path,
                    onTap: () => openEsimSetupPage(context),
                  ),
                  const SizedBox(width: 16),
                  ExpandedContainer(
                    title: SimLocalizations.of(context)!.support_chat,
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
              const SizedBox(height: 12),
              Row(
                children: [
                  ExpandedContainer(
                    title: SimLocalizations.of(context)!.how_does_it_work,
                    icon: Assets.icons.figma149.blueIcon33.path,
                    onTap: () => openGuidePage(context),
                  ),
                  const SizedBox(width: 16),
                  ExpandedContainer(
                    title: SimLocalizations.of(context)!.countries_and_rates,
                    icon: Assets.icons.figma149.blueIcon44.path,
                    onTap: () => openTariffsAndCountriesPage(context),
                  ),
                ],
              ),

              Spacer(),

              BlueGradientButton(
                onTap: () => NavigationService.openMainFlowScreen(context),
                title: SimLocalizations.of(context)!.my_esims,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
