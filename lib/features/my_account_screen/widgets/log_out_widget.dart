import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/services/auth_service.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flutter/material.dart';

class LogOutWidget extends StatelessWidget {
  final AuthService? authService;
  
  const LogOutWidget({
    super.key,
    this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ).copyWith(bottom: 30, top: 12),
      child: InkWell(
        onTap: () => showLogoutDialog(context),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.redCircleColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: LocalizedText(
              AppLocalizations.logout,
              style: FlexTypography.paragraph.xMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LocalizedText(
                  AppLocalizations.logoutConfirmationTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                LocalizedText(
                  AppLocalizations.logoutConfirmationMessage,

                  style: FlexTypography.label.medium,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: Container(
                          height: 52,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: LocalizedText(
                            AppLocalizations.cancel,
                            style: FlexTypography.headline.medium,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                          _logout(dialogContext);
                        },
                        child: Container(
                          height: 52,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: AppColors.redCircleColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: LocalizedText(
                            AppLocalizations.logout,
                            style: FlexTypography.headline.medium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final authService = this.authService ?? sl<AuthService>();
    await authService.logout();
    if (context.mounted) {
      NavigationService.goToWelcome(context);
    }
  }
}
