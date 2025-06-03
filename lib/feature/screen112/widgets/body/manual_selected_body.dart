import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/screen112/widgets/body_container.dart';
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
                            child: Image.asset(
                              'assets/icons/figma112/another_step1_1.jpg',
                              width: 271.59,
                              height: 287.61,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          const SizedBox(width: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/icons/figma112/another_step1_2.jpg',
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
                              'assets/icons/figma112/another_step1_3.jpg',
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
                              'assets/icons/figma112/manual_step1_4.jpg',
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
                              'assets/icons/figma112/manual_step1_5.jpg',
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
                        child: Image.asset(
                          'assets/icons/figma112/another_step3_1.jpg',
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
                          'assets/icons/figma112/another_step3_2.jpg',
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
                    child: Image.asset(
                      'assets/icons/figma112/another_step_5.jpg',
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
                child: Image.asset(
                  'assets/icons/figma112/step4_jpg_112.jpg',
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
                child: Image.asset(
                  'assets/icons/figma112/step4_jpg_112.jpg',
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