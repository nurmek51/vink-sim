import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:vink_sim/core/layout/screen_utils.dart';

class AddEsimCircle extends StatelessWidget {
  final bool canAdd;
  final VoidCallback onAddButtonPressed;

  const AddEsimCircle({
    super.key,
    required this.canAdd,
    required this.onAddButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallSize = isSmallScreen(context);
    final double circleSize = isSmallSize ? 281 : 292;
    return Container(
      width: circleSize,
      height: circleSize,
      padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.backgroundColorLight,
        border: Border.all(color: AppColors.circleBorder, width: 20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LocalizedText(
            SimLocalizations.of(context)!.add_esim,
            style: FlexTypography.headline.medium.copyWith(
              color: AppColors.grayBlue,
              letterSpacing: -0.17,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),
          LocalizedText(
            SimLocalizations.of(context)!.manage_more_esims,
            style: FlexTypography.paragraph.medium.copyWith(
              color: AppColors.grayBlue,
              letterSpacing: -0.15,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),

          GestureDetector(
            onTap: canAdd ? onAddButtonPressed : null,
            child: Container(
              decoration: BoxDecoration(
                gradient: canAdd ? AppColors.containerGradientPrimary : null,
                color: canAdd ? null : AppColors.containerGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                child: LocalizedText(
                  SimLocalizations.of(context)!.to_add,
                  style: FlexTypography.headline.xSmall.copyWith(
                    color: AppColors.textColorLight,
                    letterSpacing: -0.15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
