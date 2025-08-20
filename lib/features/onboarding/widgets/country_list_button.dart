import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WhatIsEsimButton extends StatelessWidget {
  final Function()? onTap;
  final String? buttonTitle;
  const WhatIsEsimButton({
    super.key,
    required this.onTap,
    this.buttonTitle = AppLocalizations.whatIsEsom,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 44,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.textColorLight, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.simIcon.svg(),
            const SizedBox(width: 12),
            Flexible(
              child: LocalizedText(
                buttonTitle!,
                style: FlexTypography.paragraph.xMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColorLight,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(
              Assets.icons.arrowRight.path,
              colorFilter: ColorFilter.mode(
                AppColors.textColorLight,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
