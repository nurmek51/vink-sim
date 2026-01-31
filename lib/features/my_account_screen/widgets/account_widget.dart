import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountWidget extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onTap;
  const AccountWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon, package: AssetUtils.package),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocalizedText(
                      title,
                      style: FlexTypography.paragraph.xMedium,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFFDFDFDF),
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: Color(0xFFDFDFDF)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
