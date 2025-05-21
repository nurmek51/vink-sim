import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoBackArrow extends StatelessWidget {
  final VoidCallback? onTap;
  final double width;
  final double height;

  const GoBackArrow({
    super.key,
    this.onTap,
    required this.width,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/icons/arrow_comeback.svg',
        width: width,
        height: height,
      ),
    );
  }
}
