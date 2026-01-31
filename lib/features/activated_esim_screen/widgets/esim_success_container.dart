import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/features/activated_esim_screen/widgets/download_button.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

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
            Assets.icons.figma112.successIcon.svg(height: 35, width: 35),
            const SizedBox(height: 10),

            HelveticaneueFont(
              text: SimLocalizations.of(context)!.esim_is_activated,
              fontSize: 20,
              color: AppColors.grayBlue,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 10),

            HelveticaneueFont(
              text: SimLocalizations.of(context)!.now_you_need_to_install_esim,
              fontSize: 17,
              color: AppColors.grayBlue,
            ),

            const SizedBox(height: 20),

            DownloadButton(
              text: SimLocalizations.of(context)!.download,
              onTap:
                  () => NavigationService.openEsimSetupPage(
                    context,
                    isActivatedEsimScreen: true,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
