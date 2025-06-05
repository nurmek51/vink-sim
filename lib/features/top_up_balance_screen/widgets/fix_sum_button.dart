import 'package:flex_travel_sim/constants/app_colors.dart';
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Color(0xFFD4D4D4), width: 1),
          ),
          child: Text(
            '$sum\$',
            style: TextStyle(
              color: AppColors.grayBlue,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
