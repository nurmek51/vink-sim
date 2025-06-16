import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Function()? onTap;
  const AuthButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Начать',
              style: FlexTypography.label.medium.copyWith(
                color: Colors.white,
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
