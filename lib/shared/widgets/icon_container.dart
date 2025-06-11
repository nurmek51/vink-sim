import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconContainer extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double width;
  final double iconSize;
  final double fontSize;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;

  const IconContainer({
    super.key,
    required this.text,
    required this.iconPath,
    this.onTap,
    this.backgroundColor = const Color(0xFFE7EFF7),
    this.textColor = Colors.black,
    this.height = 116,
    this.width = 171,
    this.iconSize = 37,
    this.fontSize = 14,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 4),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  gradient: AppColors.containerGradientPrimary,
                  shape: BoxShape.circle,
                ),
                child: Center(child: SvgPicture.asset(iconPath)),
              ),

              const SizedBox(height: 7),
              HelveticaneueFont(
                text: text,
                fontSize: fontSize,
                height: 1.3,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
