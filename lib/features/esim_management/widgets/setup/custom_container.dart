import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final double? height;
  final double? widgth;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomContainer({
    super.key,
    required this.text,
    this.height,
    this.widgth, 
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: widgth, 
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF363C45) : const Color(0xFFE7EFF7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Center(
            child: HelveticaneueFont(
              text: text,
              fontSize: 15,
              color: isSelected ? Colors.white : const Color(0xFF363C45),
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}
