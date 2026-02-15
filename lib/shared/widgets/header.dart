import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final VoidCallback? avatarOnTap;
  final bool profileIconVisibility;
  final VoidCallback? faqOnTap;
  final Color color;
  final VoidCallback? onBack;

  const Header({
    super.key,
    required this.color,
    this.avatarOnTap,
    this.faqOnTap,
    this.profileIconVisibility = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onBack != null) ...[
          GestureDetector(
            onTap: onBack,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
        ],
        Transform.translate(
          offset: const Offset(-10, 3),
          child: Assets.icons.mainIcon.image(
            color: color,
            package: AssetUtils.package,
            width: 60,
            height: 46,
            fit: BoxFit.contain,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: faqOnTap,
          child: SvgPicture.asset(
            Assets.icons.faqIcon.path,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            package: AssetUtils.package,
          ),
        ),
        profileIconVisibility ? SizedBox(width: 18) : SizedBox.shrink(),
        Visibility(
          visible: profileIconVisibility,
          child: GestureDetector(
            onTap: avatarOnTap,
            child: SvgPicture.asset(
              Assets.icons.avatarIcon.path,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              package: AssetUtils.package,
            ),
          ),
        ),
      ],
    );
  }
}
