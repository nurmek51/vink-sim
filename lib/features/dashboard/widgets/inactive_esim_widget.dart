import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/core/layout/screen_utils.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';

class InactiveEsimWidget extends StatelessWidget {
  final String? imsi;
  final String? iccid;
  final String? activationCode;
  final VoidCallback? onActivate;

  const InactiveEsimWidget({
    super.key,
    this.imsi,
    this.iccid,
    this.activationCode,
    this.onActivate,
  });

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
            const SizedBox(height: 80),
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
            if (iccid != null) ...[
              const SizedBox(height: 8),
              Text(
                'IMSI: $imsi',
                style: FlexTypography.label.small.copyWith(
                  color: Colors.grey.shade400,
                  fontSize: 10,
                ),
              ),
            ],
            SizedBox(height: 12),
            if (onActivate != null && imsi != null)
              ElevatedButton(
                onPressed: onActivate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Activate',
                  style: FlexTypography.label.medium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
