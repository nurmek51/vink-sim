import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/dashboard/utils/progress_color_utils.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class PercentageWidget extends StatelessWidget {
  const PercentageWidget({
    super.key,
    required this.progressValue,
    required this.color,
    required this.imsi,
    required this.backgroundColor,
    required this.balance,
    this.country,
    this.rate,
    this.isYellow = false,
  });

  final double progressValue;
  final Color color;
  final Color backgroundColor;
  final double balance;
  final String? country;
  final double? rate;
  final bool isYellow;
  final String imsi;

  String _formatBalance(double value) {
    String formatted =
        value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
    return formatted.replaceAll('.', ',');
  }

  String _formatGB(double value) {
    String formatted =
        value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
    return formatted.replaceAll('.', ',');
  }

  @override
  Widget build(BuildContext context) {
    final double availableGB = progressValue;

    final Color circleColor = ProgressColorUtils.getProgressColor(
      progressValue,
    );
    final bool isRedCircle = circleColor == AppColors.redCircleColor;
    final bool isBlueCircle = circleColor == AppColors.blueCircleProgressColor;
    final isSmallSize = isSmallScreen(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: progressValue),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: pi / 180,
              child: SizedBox(
                width: isSmallSize ? 281 : 292,
                height: isSmallSize ? 281 : 292,
                child: CircularProgressIndicator(
                  value:
                      1.0 - (value / (isYellow ? 1.0 : 25.0)).clamp(0.0, 1.0),
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
                    color:
                        isRedCircle
                            ? AppColors.redCircleColor
                            : AppColors.limeGreen,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 100,
                    maxWidth: 180,
                    minHeight: 26,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      country ?? AppLocalizations.notAvailable.tr(),
                      style: FlexTypography.paragraph.medium.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            isRedCircle
                                ? AppColors.backgroundColorLight
                                : AppColors.grayBlue,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${_formatGB(availableGB)} ${AppLocalizations.gigabytes.tr()}',
                  style: FlexTypography.label.xLarge.copyWith(
                    fontSize: 60,
                    color: AppColors.grayBlue,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  '\$${_formatBalance(balance)} ${AppLocalizations.balancePrefix.tr()} ',
                  style: FlexTypography.label.small.copyWith(
                    color: AppColors.grayBlue.withOpacity(0.5),
                  ),
                ),

                const SizedBox(height: 13),

                !isBlueCircle
                    ? GestureDetector(
                      onTap:
                          () => NavigationService.openTopUpBalanceScreen(
                            context,
                            imsi: imsi,
                          ),
                      child: LocalizedText(
                        AppLocalizations.topUp,
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
