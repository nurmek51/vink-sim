import 'package:vink_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';

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
      child: Assets.icons.arrowComeback.svg(
        width: width,
        height: height,
      ),
    );
  }
}
