import 'dart:math';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/dashboard/utils/progress_color_utils.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class PercentageWidget extends StatelessWidget {
  const PercentageWidget({
    super.key,
    required this.progressValue,
    required this.color,
    required this.backgroundColor,
    this.isYellow = false,
  });

  final double progressValue;
  final Color color;
  final Color backgroundColor;
  final bool isYellow;
  
  String _formatGB(double value) {
    String formatted =
        value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
    return formatted.replaceAll('.', ',');
  }

  @override
  Widget build(BuildContext context) {
    final Color circleColor = ProgressColorUtils.getProgressColor(progressValue);
    final bool isRedCircle = circleColor == AppColors.redCircleColor;
    final bool isBlueCircle = circleColor == AppColors.blueCircleProgressColor;

    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0.0,
        end: progressValue,
      ),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: pi / 180,
              child: SizedBox(
                width: 292,
                height: 292,
                child: CircularProgressIndicator(
                  value: 1.0 - (value / (isYellow ? 1.0 : 25.0)).clamp(0.0, 1.0),
                  strokeWidth: 18,
                  backgroundColor: backgroundColor,
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 80),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isRedCircle ? AppColors.redCircleColor : AppColors.limeGreen,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  width: 73,
                  height: 26,
                  child: Text(
                    'Монако',
                    style: FlexTypography.paragraph.medium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isRedCircle ? AppColors.backgroundColorLight : AppColors.grayBlue,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${_formatGB(value)} GB',
                  style: FlexTypography.label.xLarge.copyWith(
                    fontSize: 60,
                    color: AppColors.grayBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '0\$ на счету',
                  style: FlexTypography.label.medium.copyWith(
                    color: AppColors.grayBlue.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 13),

                !isBlueCircle
                    ? GestureDetector(
                      onTap:() => NavigationService.openTopUpBalanceScreen(context),
                      child: Text(
                        AppLocalization.topUp,
                        textAlign: TextAlign.center,
                        style: FlexTypography.label.medium.copyWith(
                          color: AppColors.accentBlue,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor: AppColors.accentBlue,
                        ),
                      ),
                    )
                    : SizedBox.shrink(),

              ],
            ),
          ],
        );
      },
    );
  }
}
