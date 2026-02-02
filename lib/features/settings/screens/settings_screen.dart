import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:vink_sim/config/feature_config.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/features/auth/domain/repo/auth_repository.dart';
import 'package:vink_sim/core/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await _showLogoutConfirmationDialog(context);
    if (!shouldLogout) return;

    try {
      final authRepository = sl.get<AuthRepository>();
      final config =
          sl.isRegistered<FeatureConfig>() ? sl.get<FeatureConfig>() : null;

      // Perform logout (this will clear tokens and call onLogout if in shell mode)
      await authRepository.logout();

      if (context.mounted) {
        if (config?.isShellMode == true) {
          // If in shell mode, the shell app's onLogout callback handles global state
          // and should handle navigation. We don't need to do internal redirect
          // as the shell will likely unmount this feature module.
          print('SettingsScreen: Shell mode logout triggered');
        } else {
          // Standalone mode: Redirect within vink_sim
          context.go(AppRoutes.welcome);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Log Out Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: LocalizedText(
                SimLocalizations.of(context)!.logout_confirmation_title,
                style: FlexTypography.headline.small.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: LocalizedText(
                SimLocalizations.of(context)!.logout_confirmation_message,
                style: FlexTypography.label.medium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: LocalizedText(
                    SimLocalizations.of(context)!.cancel,
                    style: FlexTypography.label.medium.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: LocalizedText(
                    SimLocalizations.of(context)!.logout,
                    style: FlexTypography.label.medium.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 20);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: LocalizedText(
          SimLocalizations.of(context)!.account_settings,
          style: FlexTypography.headline.small.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: horizontalPadding,
          child: Column(
            children: [
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => _handleLogout(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  height: 61,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red.shade700, size: 20),
                      const SizedBox(width: 12),
                      LocalizedText(
                        SimLocalizations.of(context)!.logout,
                        style: FlexTypography.label.medium.copyWith(
                          color: Colors.red.shade700,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
