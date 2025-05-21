import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String buttonText;

  const BlueButton({
    super.key,
    required this.buttonText,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2875FF), Color(0xFF0059F9)],
        ),
      ),
      child: Center(
        child: HelveticaneueFont(
          text: buttonText,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.white,
          height: 1.3,
        ),
      ),
    );
  }
}
