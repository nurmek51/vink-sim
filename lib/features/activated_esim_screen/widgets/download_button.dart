import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const DownloadButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.grayBlue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: HelveticaneueFont(
              text: text,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColors.textColorLight,
            ),
          ),
        ),
      ),
    );
  }
}