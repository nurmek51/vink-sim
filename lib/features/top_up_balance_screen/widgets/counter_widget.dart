import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterWidget({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.grayBlue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.containerGradientPrimary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.remove, color: Colors.white),
            ),
          ),
          Text(
            '$value\$', 
            style: FlexTypography.headline.xMedium.copyWith(
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.containerGradientPrimary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
