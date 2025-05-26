import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final VoidCallback? avatarOnTap;
  final VoidCallback? faqOnTap;
  final Color color;

  const Header({
    super.key,
    required this.color,
    this.avatarOnTap,
    this.faqOnTap
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
        SizedBox(width: 18),
        GestureDetector(
          onTap: avatarOnTap,
          child: SvgPicture.asset(
            Assets.icons.avatarIcon.path, 
            color: color,
          ),
        ),
      ],
    );
  }
}
