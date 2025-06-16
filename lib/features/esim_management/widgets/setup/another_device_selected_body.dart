import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AnotherDeviceSelectedBody extends StatelessWidget {
  const AnotherDeviceSelectedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 251,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFE7EFF7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 52,
                  width: 45,
                  child: Assets.icons.attentionCircle.svg(),
                ),
                SizedBox(height: 10),
                HelveticaneueFont(
                  text: AppLocalization.attention,
                  fontSize: 18,
                  color: AppColors.textColorDark,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                HelveticaneueFont(
                  text: AppLocalization.anotherDeviceDescriptionWarning,
                  fontSize: 16,
                  color: AppColors.textColorDark,
                  textAlign: TextAlign.center,
                ),                

              ],
            ),
          ),
        ),

        SizedBox(height: 15),

        BodyContainer(
          stepNum: '1', 
          description: AppLocalization.anotherDeviceDescription1,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.icons.figma112.mobileCommunication.image(
                          width: 271.59,
                          height: 287.61,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.icons.figma112.addEsim.image(
                          width: 271.59,
                          height: 287.61,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.icons.figma112.settingsByQr.image(
                          width: 271.59,
                          height: 287.61,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.icons.figma112.qrMobileTariff.image(
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
          stepNum: '2', 
          description: AppLocalization.anotherDeviceDescription2,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.icons.figma112.qrImageForManual.image(
                          width: 228,
                          height: 228,
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
          stepNum: '3', 
          description: AppLocalization.anotherDeviceDescription3,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.icons.figma112.forTravels.image(
                          width: 271.59,
                          height: 287.61,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.icons.figma112.flexPlan.image(
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
          stepNum: '4', 
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
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.icons.figma112.faceTimeAndImessage.image(
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
          stepNum: '5', 
          description: AppLocalization.anotherDeviceDescription5,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Assets.icons.figma112.chooseMobileData.image(
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
          stepNum: '6', 
          description: AppLocalization.fastDescriptionStep4,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.icons.figma112.dataRouming.image(
                  width: 313,
                  height: 292,
                  fit: BoxFit.cover,
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
                  height: 292,
                  fit: BoxFit.cover,
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
