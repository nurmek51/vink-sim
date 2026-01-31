import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:flutter/material.dart';

class FixSumButton extends StatelessWidget {
  final int sum;
  final bool isSelected;
  final ValueChanged<int> onTap;

  const FixSumButton({
    required this.sum,
    this.isSelected = false,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(sum),
        child: Container(
          alignment: Alignment.center,
          height: 33,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFF363C45) : const Color(0xFFE7EFF7),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            '$sum\$',
            style: FlexTypography.paragraph.medium.copyWith(
              color: isSelected ? Colors.white : AppColors.grayBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
