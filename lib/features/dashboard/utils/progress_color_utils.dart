import 'package:flutter/material.dart';

class ProgressColorUtils {
  static Color getProgressColor(double value) {
    if (value < 0.1) return Colors.red;
    if (value < 0.5) return const Color(0xFF73BAE7);
    if (value < 0.7) return const Color(0xFF73BAE7);
    return Colors.green;
  }

  static Color getProgressBackgroundColor(double value) {
    if (value < 0.1) return Colors.red;
    if (value < 0.5) return const Color(0xFF1F6FFF);
    if (value < 0.7) return const Color(0xFF1F6FFF);
    return Colors.green;
  }
}
