import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ScrollContainer extends StatelessWidget {
  final double sum;
  final String country;
  const ScrollContainer({super.key, required this.sum, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 33,
      decoration: BoxDecoration(
        color: AppColors.backgroundColorLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFD4D4D4), width: 1),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: AppColors.grayBlue,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: '${sum}GB ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: country,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
