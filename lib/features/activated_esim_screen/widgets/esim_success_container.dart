import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/activated_esim_screen/widgets/download_button.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EsimSuccessContainer extends StatelessWidget {
  const EsimSuccessContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 271,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.containerGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/icons/figma112/success_icon.svg',
              height: 35,
              width: 35,
            ),
            const SizedBox(height: 10),

            HelveticaneueFont(
              text: AppLocalization.esimIsActivated,
              fontSize: 20,
              color: AppColors.grayBlue,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 10),

            HelveticaneueFont(
              text: AppLocalization.nowYouNeedToInstallEsim,
              fontSize: 17,
              color: AppColors.grayBlue,
            ),

            const SizedBox(height: 20),

            DownloadButton(
              text: AppLocalization.download,
              onTap: () => openEsimSetupPage(context),
            ),

          ],
        ),
      ),
    );
  }
}