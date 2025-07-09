import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flutter/material.dart';

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
    return Container(
      width: 300,
      height: 300,
      padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.backgroundColorLight,
        border: Border.all(color: AppColors.circleBorder, width: 20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalization.addEsim,
            style: FlexTypography.headline.medium.copyWith(
              color: AppColors.grayBlue,
              letterSpacing: -0.17,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),
          Text(
            AppLocalization.manageMoreEsims,
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
                child: Text(
                  AppLocalization.toAdd,
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
