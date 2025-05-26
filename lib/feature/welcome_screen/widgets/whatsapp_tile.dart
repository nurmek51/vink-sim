import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/auth_screen/widgets/mobile_number_field.dart.dart';
import 'package:flex_travel_sim/feature/auth_screen/widgets/registration_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WhatsappTile extends StatelessWidget {
  const WhatsappTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            AppLocalization.authWithTheHelpOf,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: AppColors.backgroundColorLight,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              const Text(
                AppLocalization.whatsApp,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whatsAppColor,
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                Assets.icons.whatsappIcon.path,
                colorFilter: ColorFilter.mode(
                  AppColors.whatsAppColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          const Text(
            AppLocalization.mobileNumWhatsAppDescription,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.backgroundColorLight,
            ),
          ),
          const SizedBox(height: 20),
          MobileNumberField(),
          const SizedBox(height: 20),
          RegistrationContainer(
            onTap: () => openMainFlowScreen(context),
            buttonText: AppLocalization.authAndRegistration,
            buttonTextColor: AppColors.backgroundColorLight,
            color: AppColors.accentBlue,
            arrowForward: true,
          ),
          Spacer(),
          RegistrationContainer(
            onTap: () => openInitialPage(context),
            buttonText: AppLocalization.continueWithApple,
            buttonTextColor: AppColors.textColorLight,
            color: AppColors.textColorDark,
            borderLine: BorderSide(color: AppColors.textColorLight),
            iconPath: Assets.icons.appleLogo.path,
          ),
          const SizedBox(height: 12),
          RegistrationContainer(
            onTap: () => openInitialPage(context),
            buttonText: AppLocalization.continueWithGoogle,
            buttonTextColor: AppColors.textColorDark,
            color: AppColors.textColorLight,
            borderLine: BorderSide(color: AppColors.textColorDark),
            iconPath: Assets.icons.googleLogo.path,
          ),
          const SizedBox(height: 12),
          RegistrationContainer(
            onTap: () => openInitialPage(context),
            buttonText: AppLocalization.continueWithEmail,
            buttonTextColor: AppColors.textColorLight,
            color: AppColors.babyBlue,
            iconPath: Assets.icons.emailLogo.path,
          ),
        ],
      ),
    );
  }
}
