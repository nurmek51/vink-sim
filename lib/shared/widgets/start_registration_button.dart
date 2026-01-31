import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartRegistrationButton extends StatelessWidget {
  const StartRegistrationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushReplacement('/?index=1'),
      child: Container(
        alignment: Alignment.center,
        height: 52,
        decoration: BoxDecoration(
          gradient: AppColors.containerGradientPrimary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: LocalizedText(
          SimLocalizations.of(context)!.start_registration,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
