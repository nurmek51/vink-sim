import 'dart:math';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PercentageWidget extends StatelessWidget {
  const PercentageWidget({
    super.key,
    required this.progressValue,
    required this.color,
    required this.backgroundColor,
  });

  final double progressValue;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
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
                width: 292,
                height: 292,
                child: CircularProgressIndicator(
                  value: 1.0 - value,
                  strokeWidth: 18,
                  backgroundColor: backgroundColor,
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  width: 73,
                  height: 26,
                  child: Text(
                    'Монако',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                Text(
                  '${(value * 100).round()} GB',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grayBlue,
                  ),
                ),
                Text(
                  '${value.round()} \$ на счету',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.backgroundColorDark.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
