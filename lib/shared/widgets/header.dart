import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final VoidCallback? avatarOnTap;
  final bool profileIconVisibility;
  final VoidCallback? faqOnTap;
  final Color color;

  const Header({
    super.key,
    required this.color,
    this.avatarOnTap,
    this.faqOnTap,
    this.profileIconVisibility = true,
    
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.icons.mainIcon.path, color: color),
        Spacer(),
        GestureDetector(
          onTap: faqOnTap,
          child: SvgPicture.asset(
            Assets.icons.faqIcon.path, 
            color: color,
          ),
        ),
        profileIconVisibility ? SizedBox(width: 18) : SizedBox.shrink(),
        Visibility(
          visible: profileIconVisibility,
          child: GestureDetector(
            onTap: avatarOnTap,
            child: SvgPicture.asset(
              Assets.icons.avatarIcon.path, 
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
