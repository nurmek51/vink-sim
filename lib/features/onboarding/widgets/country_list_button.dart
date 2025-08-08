import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WhatIsEsimButton extends StatelessWidget {
  final Function()? onTap;
  const WhatIsEsimButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: 227,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.textColorLight, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.simIcon.svg(),
            SizedBox(width: 12),
            LocalizedText(
              AppLocalizations.whatIsEsom,
              style: FlexTypography.paragraph.xMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textColorLight,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              Assets.icons.arrowRight.path,
              color: AppColors.textColorLight,
            ),
          ],
        ),
      ),
    );
  }
}
