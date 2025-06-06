import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/auth_screen/widgets/mobile_number_field.dart.dart';
import 'package:flex_travel_sim/features/auth_screen/widgets/registration_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WhatsappTile extends StatefulWidget {
  final ValueChanged<String> onNext;
  final VoidCallback appBarPop;
  const WhatsappTile({
    super.key,
    required this.onNext,
    required this.appBarPop,
  });

  @override
  State<WhatsappTile> createState() => _WhatsappTileState();
}

class _WhatsappTileState extends State<WhatsappTile> {
  String _phoneDigits = '';
  String _formatted = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColorDark,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.backgroundColorLight),
          onPressed: widget.appBarPop,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
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
            MobileNumberField(
              onChanged: (digits, formatted) {
                setState(() {
                  _phoneDigits = digits;
                  _formatted = formatted;
                });
              },
            ),
            const SizedBox(height: 20),
            RegistrationContainer(
              onTap: _phoneDigits.length >= 7 ? () => widget.onNext(_formatted) : null,
              buttonText: AppLocalization.authAndRegistration,
              buttonTextColor: _phoneDigits.length >= 7 ? AppColors.backgroundColorLight : Color(0x4DFFFFFF),
              color: _phoneDigits.length >= 7 ? AppColors.accentBlue : Color(0x4D808080),
              arrowForward: _phoneDigits.length >= 7 ? true : false,
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
      ),
    );
  }
}
