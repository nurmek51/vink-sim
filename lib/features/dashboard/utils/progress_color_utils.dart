import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProgressColorUtils {
  static const double maxGB = 25.0;

  static Color getProgressColor(double value) {
    if (value == 0) return AppColors.redCircleColor;
    if (value > 0 && value <= 1.0) return AppColors.yellowCircleProgressColor;
    return const Color(0xFF73BAE7);
  }

  static Color getProgressBackgroundColor(double value) {
    if (value == 0) return const Color(0xFFFFCCCC);
    if (value > 0 && value <= 1.0) return AppColors.yellowCircleBackgroundColor;
    return AppColors.blueCircleBackgroundColor;
  }

  static double getProgressPercent(double value) {
    return (value / maxGB).clamp(0.0, 1.0);
  }
}
