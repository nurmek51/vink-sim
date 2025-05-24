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

  const RegistrationContainer({
    super.key,
    required this.buttonText,
    this.color,
    this.iconPath,
    this.borderLine,
    this.buttonTextColor,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: buttonTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
