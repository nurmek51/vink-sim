import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/services/tech_support_launcher.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/chat_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              ChatContainer(
                onTap: () => TechSupportLauncher.openTelegram('flexunion'),
                color: const Color.fromARGB(255, 56, 163, 212),
                title: AppLocalizations.telegramSupport,
                border: Border.all(
                  color: const Color.fromARGB(255, 56, 163, 212),
                  width: 0.5,
                ),
                icon: Assets.icons.telegramLogo.path,
              ),
              const SizedBox(height: 16),
              ChatContainer(
                onTap: () => TechSupportLauncher.openWhatsApp('971543119958'),
                color: const Color(0xFF25D366),
                title: AppLocalizations.whatsappSupport,
                border: Border.all(color: const Color(0xFF25D366), width: 0),
                icon: Assets.icons.whatsappIcon.path,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
