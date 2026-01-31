import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
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
  final bool arrowForward;

  const RegistrationContainer({
    super.key,
    required this.buttonText,
    this.color,
    this.iconPath,
    this.borderLine,
    this.buttonTextColor,
    this.onTap,
    this.iconColor,
    this.arrowForward = false,
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LocalizedText(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: FlexTypography.label.medium.copyWith(
                      color: buttonTextColor,
                    ),
                  ),
                  if (arrowForward) ...[
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: AppColors.backgroundColorLight,
                    ),
                  ],
                ],
              ),

              if (iconPath != null)
                Positioned(
                  left: 0,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: SvgPicture.asset(
                          iconPath!,
                          package: AssetUtils.package,
                          colorFilter:
                              iconColor != null
                                  ? ColorFilter.mode(
                                    iconColor!,
                                    BlendMode.srcIn,
                                  )
                                  : null,
                        ),
                      ),
                      const SizedBox(width: 12),
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
