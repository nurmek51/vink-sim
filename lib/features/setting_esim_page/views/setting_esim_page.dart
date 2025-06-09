import 'package:flex_travel_sim/components/widgets/go_back_arrow.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/setting_esim_page/widgets/steps_container.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class SettingEsimPage extends StatelessWidget {
  const SettingEsimPage({super.key});

  @override
  Widget build(BuildContext context) {
    // FIGMA NUMBER - 143
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
              child: Row(
                children: [
                  GoBackArrow(
                    onTap: () => NavigationService.pop(context),
                    width: 10,
                    height: 14,
                  ),
                    
                  Expanded(
                    child: Center(
                      child: HelveticaneueFont(
                        text: AppLocalization.guideForEsimSettings,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        color: Color(0xFF363C45),
                      ),
                    ),
                  ),                
                ],
              ),
            ),
        
            const Divider(thickness: 0),
        
            // body
        
            SizedBox(height:10),
        
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Center(
                child: Column(
                  children: [
                    StepsContainer(
                      iconPath: 'assets/icons/figma143/step1_icon.svg',
                      stepNum: '1',
                      description: AppLocalization.balanceAndEsimActivation,
                    ),
                        
                    SizedBox(height: 7),
                        
                    StepsContainer(
                      iconPath: 'assets/icons/figma143/step2_icon.svg',
                      stepNum: '2',
                      description: AppLocalization.profileSetupGuide,
                    ),
                        
                    SizedBox(height: 7),
                        
                    StepsContainer(
                      iconPath: 'assets/icons/figma143/step3_icon.svg',
                      stepNum: '3',
                      description: AppLocalization.readyToTravelMessage,
                    ),                                
                  ],
                ),
              ),
            ),
        
            Spacer(),
        
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40.0),
              child: Container(
                alignment: Alignment.center,
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppColors.containerGradientPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  AppLocalization.startRegistration,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),  
        
        
          ],
        ),
      ),
    );
  }
}