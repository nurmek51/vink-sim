import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/auth_intro_bottomsheet_content.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/benefit_tile.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/auth_button.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/country_list_button.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/header.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
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
              faqOnTap: () => openGuidePage(context),
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalization.frameTitle,
              style: FlexTypography.headline.large.copyWith(
                color: AppColors.backgroundColorLight,
              ),
            ),
            const SizedBox(height: 30),
            BenefitTile(
              icon: Assets.icons.globus.path,
              title: AppLocalization.frameGlobusTitle,
            ),
            const SizedBox(height: 12),
            BenefitTile(
              icon: Assets.icons.check.path,
              title: AppLocalization.frameCheckTitle,
            ),
            const SizedBox(height: 12),
            BenefitTile(
              icon: Assets.icons.infinity.path,
              title: AppLocalization.infinityTitle,
            ),
            const SizedBox(height: 12),
            BenefitTile(icon: Assets.icons.card.path, title: 'Пакеты от 1\$'),
            const SizedBox(height: 30),
            WhatIsEsimButton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.5,
                      minChildSize: 0.3,
                      maxChildSize: 0.5,
                      expand: false,
                      builder: (context, scrollController) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: const AuthIntroBottomsheetContent(),
                        );
                      },
                    );
                  },
                );
              },
            ),
            const Spacer(),
            AuthButton(onTap: onAuthTap),
          ],
        ),
      ),
    );
  }
}
