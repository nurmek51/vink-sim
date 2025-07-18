import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BenefitTile extends StatelessWidget {
  final String icon;
  final String title;
  const BenefitTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(height: 24, width: 24, child: SvgPicture.asset(icon)),
        const SizedBox(width: 10),
        LocalizedText(
          title,
          style: FlexTypography.paragraph.medium.copyWith(
            color: AppColors.textColorLight,
          ),
        ),
      ],
    );
  }
}
