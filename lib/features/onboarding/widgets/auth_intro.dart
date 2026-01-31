import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/features/onboarding/widgets/benefit_tile.dart';
import 'package:vink_sim/features/onboarding/widgets/auth_button.dart';
import 'package:vink_sim/features/onboarding/widgets/country_list_button.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/shared/widgets/header.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class AuthIntro extends StatelessWidget {
  const AuthIntro({super.key, required this.onAuthTap});

  final VoidCallback onAuthTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('authIntro'),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 50),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 45),
            Header(
              color: AppColors.textColorLight,
              profileIconVisibility: false,
              faqOnTap:
                  () => NavigationService.openGuidePage(
                    context,
                    isAuthorized: true,
                  ),
            ),
            const SizedBox(height: 30),
            LocalizedText(
              SimLocalizations.of(context)!.frame_title,
              style: FlexTypography.headline.large.copyWith(
                color: AppColors.backgroundColorLight,
              ),
            ),

            const SizedBox(height: 30),
            BenefitTile(
              icon: Assets.icons.globus.path,
              title: SimLocalizations.of(context)!.frame_globus_title,
            ),
            const SizedBox(height: 12),
            BenefitTile(
              icon: Assets.icons.check.path,
              title: SimLocalizations.of(context)!.frame_check_title,
            ),
            const SizedBox(height: 12),
            BenefitTile(
              icon: Assets.icons.infinity.path,
              title: SimLocalizations.of(context)!.infinity_title,
            ),
            const SizedBox(height: 12),
            BenefitTile(
              icon: Assets.icons.card.path,
              title: SimLocalizations.of(context)!.packages_from_1_dollar,
            ),
            const SizedBox(height: 30),
            WhatIsEsimButton(
              buttonTitle: SimLocalizations.of(context)!.tariffs_and_countries,
              onTap:
                  () => NavigationService.openTariffsAndCountriesPage(
                    context,
                    isAuthorized: true,
                  ),
            ),
            const Spacer(),
            AuthButton(onTap: onAuthTap),
          ],
        ),
      ),
    );
  }
}
