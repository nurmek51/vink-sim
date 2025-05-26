import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationContainer extends StatelessWidget {
  final String buttonText;
  final Color? color;
  final Color? iconColor;
  final String? iconPath;
  final BorderSide? borderLine;
  final Color? buttonTextColor;
  final VoidCallback? onTap;
  final bool textArrow;

  const RegistrationContainer({
    super.key,
    required this.buttonText,
    this.color,
    this.iconPath,
    this.borderLine,
    this.buttonTextColor,
    this.onTap,
    this.iconColor,
    this.textArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    print('RegistrationContainer build: buttonText=$buttonText, textArrow=$textArrow');
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56),
            color: color,
            border:
                borderLine != null
                    ? Border.all(
                      color: borderLine!.color,
                      width: borderLine!.width,
                    )
                    : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (iconPath != null) ...[
                SizedBox(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(
                    iconPath!,
                    colorFilter: iconColor != null ? ColorFilter.mode(iconColor!, BlendMode.srcIn) : null,
                  ),
                ),
                const SizedBox(width: 12),
              ],
      
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: buttonTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),


                    if (textArrow) ...[
                      const SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: AppColors.backgroundColorLight,
                      ),
                    ],

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
