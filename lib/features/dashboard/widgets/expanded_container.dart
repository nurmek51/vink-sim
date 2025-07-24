import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpandedContainer extends StatefulWidget {
  final String title;
  final String icon;
  final Function()? onTap;

  const ExpandedContainer({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  State<ExpandedContainer> createState() => _ExpandedContainerState();
}

class _ExpandedContainerState extends State<ExpandedContainer> {
  bool isSelected = false;

  void _handleTap() {
    setState(() {
      isSelected = true;
    });
    widget.onTap?.call();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          isSelected = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor =
        isSelected ? AppColors.splashColor : AppColors.containerGray;

    final gradientColors =
        isSelected
            ? AppColors.containerGradientSecondary
            : AppColors.containerGradientPrimary;

    final textColor =
        isSelected ? AppColors.textColorLight : AppColors.textColorDark;
    final iconColor =
        isSelected ? AppColors.splashColor : AppColors.textColorLight;

    return Expanded(
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: _handleTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: AppColors.splashColor,
          child: Container(
            padding: EdgeInsets.only(top: isDesktop(context) ? 8 : 12, left: 12),
            alignment: Alignment.centerLeft,
            height: isDesktop(context) ? 85 : 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: isDesktop(context) ? 28 : 37,
                  height:  isDesktop(context) ? 28 : 37,
                  decoration: BoxDecoration(
                    gradient: gradientColors,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      widget.icon,
                      width:  isDesktop(context) ? 16 : 18,
                      height: isDesktop(context) ? 16 : 18,
                      color: iconColor,
                    ),
                  ),
                ),
                SizedBox(height: isDesktop(context) ? 4 : 8),
                LocalizedText(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: textColor),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
