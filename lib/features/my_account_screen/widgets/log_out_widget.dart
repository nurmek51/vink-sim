import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/features/auth/domain/repo/auth_repository.dart';
import 'package:vink_sim/config/feature_config.dart';
import 'package:vink_sim/core/router/app_router.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key});

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
              SimLocalizations.of(context)!.logout,
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
                  SimLocalizations.of(context)!.logout_confirmation_title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                LocalizedText(
                  SimLocalizations.of(context)!.logout_confirmation_message,
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
                            SimLocalizations.of(context)!.cancel,
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
                            SimLocalizations.of(context)!.logout,
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
    try {
      final authRepository = sl.get<AuthRepository>();
      final config =
          sl.isRegistered<FeatureConfig>() ? sl.get<FeatureConfig>() : null;

      // Perform logout (clears token and calls onLogout if in shell mode)
      await authRepository.logout();

      if (context.mounted) {
        if (config?.isShellMode == true) {
          // If in shell mode, the shell app's onLogout callback handles global state
          // and should handle navigation.
          debugPrint('LogOutWidget: Shell mode logout triggered');
        } else {
          // Standalone mode: Force redirect within vink_sim
          GoRouter.of(context).go(AppRoutes.welcome);
        }
      }
    } catch (e) {
      debugPrint('LogOutWidget: Logout error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Log Out Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
