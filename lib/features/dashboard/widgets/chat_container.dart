import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatContainer extends StatelessWidget {
  final Color color;
  final String title;
  final Color titleColor;
  final String icon;
  final VoidCallback? onTap;
  const ChatContainer({
    super.key,
    required this.color,
    required this.title,
    this.titleColor = Colors.white,
    required this.icon,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                icon,
                package: AssetUtils.package,
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(titleColor, BlendMode.srcIn),
              ),
            ),
            Center(
              child: LocalizedText(
                title,
                style: FlexTypography.label.medium.copyWith(color: titleColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
