import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class FastSelectedBody extends StatelessWidget {
  const FastSelectedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyContainer(
          stepNum: '1', 
          description: AppLocalization.fastDescriptionStep1,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              alignment: Alignment.center,
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.containerGradientPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                AppLocalization.download,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
    
        const SizedBox(height: 15),
    
        BodyContainer(
          stepNum: '2', 
          description: AppLocalization.fastDescriptionStep2,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.icons.figma112.defaultNumber.image(
                          width: 271.59,
                          height: 287.61,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.icons.figma112.faceTimeAndImessage.image(
                          width: 271.59,
                          height: 287.61,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),                      
                    ],
                  ),
                ),
              ),
            ),
        ),
    
        const SizedBox(height: 15),
    
        BodyContainer(
          stepNum: '3', 
          description: AppLocalization.fastDescriptionStep3,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.icons.figma112.chooseMobileData.image(
                  width: 313,
                  height: 292,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),
    
        const SizedBox(height: 15),
    
        BodyContainer(
          stepNum: '4', 
          description: AppLocalization.fastDescriptionStep4,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.icons.figma112.dataRouming.image(
                  width: 274.8,
                  height: 291,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        BodyContainer(
          stepTitle: AppLocalization.important, 
          description: AppLocalization.anotherDeviceDescriptionImportant,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.icons.figma112.importantStepTodo.image(
                  width: 313,
                  height: 240,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),          
                 
      ],
    );
  }
}
