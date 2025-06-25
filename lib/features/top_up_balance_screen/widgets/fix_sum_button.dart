import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flutter/material.dart';

class FixSumButton extends StatelessWidget {
  final int sum;
  final ValueChanged<int> onTap;

  const FixSumButton({required this.sum, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(sum),
        child: Container(
          alignment: Alignment.center,
          height: 33,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Color(0xFFE7EFF7),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            '$sum\$',
            style: FlexTypography.paragraph.medium.copyWith(
              color: AppColors.grayBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
