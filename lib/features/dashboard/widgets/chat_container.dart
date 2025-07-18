import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatContainer extends StatelessWidget {
  final Color color;
  final String title;
  final Border border;
  final Color titleColor;
  final String icon;
  const ChatContainer({
    super.key,
    required this.color,
    required this.title,
    required this.border,
    this.titleColor = Colors.white,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
        border: border,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              icon,
              width: 25,
              height: 25,
              color: titleColor,
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
    );
  }
}
