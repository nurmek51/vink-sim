import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/benefit_tile.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/button/auth_button.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/button/country_list_button.dart';
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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 8),
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
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
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
            WhatIsEsimButton(onTap: () => openInitialPage(context)),
            const Spacer(),
            AuthButton(onTap: onAuthTap),
          ],
        ),
      ),
    );
  }
}
