import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconContainer extends StatelessWidget {
  final String text;
  final String blueIconPath;
  final VoidCallback? onTap;

  const CustomIconContainer({
    super.key,
    required this.text,
    required this.blueIconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 116,
        width: 171,
        decoration: BoxDecoration(
          color: Color(0xFFE7EFF7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                blueIconPath,
                height: 37,
                width: 37,
              ),
              SizedBox(height: 7),
              HelveticaneueFont(
                text: text,
                fontSize: 14,
                height: 1.3,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}