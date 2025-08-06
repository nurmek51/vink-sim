import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';

class FastSelectedBody extends StatelessWidget {
  const FastSelectedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyContainer(
          description: AppLocalizations.fastDescriptionStep1,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              alignment: Alignment.center,
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.containerGradientPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const LocalizedText(
                AppLocalizations.download,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        BodyContainer(
          description: AppLocalizations.fastDescriptionStep2,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/icons/figma112/step2_112_1.jpg',
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/icons/figma112/step2_112_2.jpg',
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        BodyContainer(
          description: AppLocalizations.fastDescriptionStep3,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/icons/figma112/step3_jpg_112.jpg',
                      width: 313,
                      height: 292,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        BodyContainer(
          description: AppLocalizations.fastDescriptionStep4,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/icons/figma112/step4_jpg_112.jpg',
                  width: 274.8,
                  height: 291,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),
      ],
    );
  }
}
