import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';

class InactiveEsimWidget extends StatelessWidget {
  const InactiveEsimWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallSize = isSmallScreen(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: pi / 180,
          child: SizedBox(
            width: isSmallSize ? 281 : 292,
            height: isSmallSize ? 281 : 292,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 18,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(Colors.grey.shade400),
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 120),
            Icon(Icons.credit_card_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'eSIM Inactive',
              style: FlexTypography.label.large.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Activate to start using',
              style: FlexTypography.paragraph.medium.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
