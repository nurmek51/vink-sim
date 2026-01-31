import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WhatIsEsimButton extends StatelessWidget {
  final Function()? onTap;
  final String? buttonTitle;
  const WhatIsEsimButton({super.key, required this.onTap, this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    final title = buttonTitle ?? SimLocalizations.of(context)!.what_is_esom;
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
                title,
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
              package: AssetUtils.package,
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
