import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/services/tech_support_launcher.dart';
import 'package:vink_sim/features/dashboard/widgets/chat_container.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  final String tegreamContact = 'flexunion';
  final String whatsappContact = '971543119958';

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
                onTap: () => TechSupportLauncher.openTelegram(tegreamContact),
                color: const Color.fromARGB(255, 56, 163, 212),
                title: SimLocalizations.of(context)!.telegram_support,

                icon: Assets.icons.telegramLogo.path,
              ),
              const SizedBox(height: 16),
              ChatContainer(
                onTap: () => TechSupportLauncher.openWhatsApp(whatsappContact),
                color: AppColors.whatsAppColor,
                title: SimLocalizations.of(context)!.whatsapp_support,
                icon: Assets.icons.whatsappIcon.path,
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
