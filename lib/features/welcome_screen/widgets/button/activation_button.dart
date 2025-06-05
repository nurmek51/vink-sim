import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flutter/material.dart';

class ActivationButton extends StatelessWidget {
  final Function()? onTap;
  const ActivationButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF3761DF), Color(0xFF25ABFF)],
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.activationButtonTitle,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
