import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
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
        SizedBox(
          height: 24,
          width: 24,
          child: SvgPicture.asset(icon, package: AssetUtils.package),
        ),
        const SizedBox(width: 10),
        LocalizedText(
          title,
          style: FlexTypography.paragraph.xMedium.copyWith(
            color: AppColors.textColorLight,
          ),
        ),
      ],
    );
  }
}
