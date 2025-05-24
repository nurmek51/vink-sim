import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BlueGradientButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const BlueGradientButton({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        alignment: Alignment.center,
        height: 52,
        decoration: BoxDecoration(
          gradient: AppColors.containerGradientPrimary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
