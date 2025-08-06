import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/firebase_login_use_case.dart';
import 'package:flex_travel_sim/core/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await _showLogoutConfirmationDialog(context);
    if (!shouldLogout) return;

    try {
      final firebaseLoginUseCase = sl.get<FirebaseLoginUseCase>();
      await firebaseLoginUseCase.signOut();

      if (context.mounted) {
        context.go(AppRoutes.welcome);
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
                AppLocalizations.logoutConfirmationTitle,
                style: FlexTypography.headline.small.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: LocalizedText(
                AppLocalizations.logoutConfirmationMessage,
                style: FlexTypography.label.medium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: LocalizedText(
                    AppLocalizations.cancel,
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
                    AppLocalizations.logout,
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
          AppLocalizations.accountSettings,
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
                        AppLocalizations.logout,
                        style: FlexTypography.label.medium.copyWith(
                          color: Colors.red.shade700,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
