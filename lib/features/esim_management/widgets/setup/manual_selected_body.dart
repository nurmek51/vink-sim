import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ManualSelectedBody extends StatelessWidget {
  const ManualSelectedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyContainer(
          stepNum: '1', 
          description: AppLocalization.manualDescription1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
              
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.textColorLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HelveticaneueFont(
                              text: AppLocalization.adressSmDp,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 3),
                            HelveticaneueFont(
                              text: 'server.com',
                              fontSize: 16,
                              color: AppColors.textColorDark,
                            ),                              
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 7),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.textColorLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HelveticaneueFont(
                              text: AppLocalization.activationCode,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 3),
                            HelveticaneueFont(
                              text: 'P4-DPFOTM-ERLKBG',
                              fontSize: 16,
                              color: AppColors.textColorDark,
                            ),                              
                          ],
                        ),
                      ),
                    ),                    

                    const SizedBox(height: 15),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
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
                          const SizedBox(width: 10),
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
                            child: Assets.icons.figma112.scanQr.image(
                              width: 271.59,
                              height: 287.61,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          SizedBox(width: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Assets.icons.figma112.activationCode.image(
                              width: 271.59,
                              height: 287.61,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),                                                                                     
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),
    
        SizedBox(height: 15),
    
        BodyContainer(
          stepNum: '2', 
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
          stepNum: '3', 
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
          stepNum: '4', 
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
          stepNum: '5', 
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
