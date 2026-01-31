import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/core/layout/screen_utils.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/features/dashboard/utils/progress_color_utils.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PercentageWidget extends StatelessWidget {
  const PercentageWidget({
    super.key,
    required this.progressValue,
    required this.color,
    required this.imsi,
    required this.backgroundColor,
    required this.balance,
    this.iccid,
    this.country,
    this.rate,
    this.isYellow = false,
  });

  final double progressValue;
  final Color color;
  final Color backgroundColor;
  final double balance;
  final String? iccid;
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
    final isSmallSize = isSmallScreen(context);
    final double circleSize = isSmallSize ? 281 : 292;
    final bool isActivationOnly = country == null || rate == null;

    if (isActivationOnly) {
      return Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: circleSize,
            height: circleSize,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 18,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.deepBlueGray),
            ),
          ),

          Transform.rotate(
            angle: -0.017,
            child: SizedBox(
              width: circleSize,
              height: circleSize,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 18,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.deepBlueGray,
                ),
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_formatBalance(balance)} \$',
                style: FlexTypography.label.xLarge.copyWith(
                  fontSize: 70,
                  color: AppColors.grayBlue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                SimLocalizations.of(context)!.esim_is_activating,
                style: FlexTypography.label.medium.copyWith(
                  color: AppColors.grayBlue,
                ),
              ),
            ],
          ),
        ],
      );
    }

    final double availableGB = progressValue;
    final Color circleColor = ProgressColorUtils.getProgressColor(
      progressValue,
    );
    final bool isRedCircle = circleColor == AppColors.redCircleColor;
    final bool isBlueCircle = circleColor == AppColors.blueCircleProgressColor;

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
                width: circleSize,
                height: circleSize,
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
                  decoration: BoxDecoration(
                    color:
                        isRedCircle
                            ? AppColors.redCircleColor
                            : AppColors.limeGreen,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      country ?? SimLocalizations.of(context)!.not_available,
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
                  '${_formatGB(availableGB)} ${SimLocalizations.of(context)!.gigabytes}',
                  style: FlexTypography.label.xLarge.copyWith(
                    fontSize: 60,
                    color: AppColors.grayBlue,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  '\$${_formatBalance(balance)} ${SimLocalizations.of(context)!.balance_prefix} ',
                  style: FlexTypography.label.small.copyWith(
                    color: AppColors.grayBlue.withValues(alpha: 0.5),
                  ),
                ),

                if (iccid != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'IMSI: $imsi',
                    style: FlexTypography.label.small.copyWith(
                      color: AppColors.grayBlue.withValues(alpha: 0.3),
                      fontSize: 10,
                    ),
                  ),
                ],

                const SizedBox(height: 13),

                !isBlueCircle
                    ? GestureDetector(
                      onTap: () {
                        // Pass subscriber data to TopUp screen to avoid re-fetching
                        final subscriberState =
                            context.read<SubscriberBloc>().state;
                        final subscriber =
                            subscriberState is SubscriberLoaded
                                ? subscriberState.subscriber
                                : null;

                        NavigationService.openTopUpBalanceScreen(
                          context,
                          imsi: imsi,
                          subscriber: subscriber,
                        );
                      },
                      child: Text(
                        SimLocalizations.of(context)!.top_up,
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
