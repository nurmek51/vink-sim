import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/main_flow_screen/widgets/chat_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              ChatContainer(
                color: Color.fromARGB(255, 56, 163, 212),
                title: AppLocalization.telegramSupport,
                border: Border.all(
                  color: Color.fromARGB(255, 56, 163, 212),
                  width: 0.5,
                ),
                icon: Assets.icons.telegramLogo.path,
              ),
              SizedBox(height: 16),
              ChatContainer(
                color: Color(0xFF25D366),
                title: AppLocalization.whatsappSupport,
                border: Border.all(color: Color(0xFF25D366), width: 0),
                icon: Assets.icons.whatsappIcon.path,
              ),
              SizedBox(height: 16),
              ChatContainer(
                color: AppColors.backgroundColorLight,
                title: AppLocalization.emailSupport,
                titleColor: Colors.black,
                border: Border.all(color: Colors.black, width: 0),
                icon: Assets.icons.mailIcon.path,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
