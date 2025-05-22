import 'dart:ui';

import 'package:flex_travel_sim/components/widgets/blue_button.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/screen149/widgets/custom_icon_container.dart';
import 'package:flex_travel_sim/feature/screen149/widgets/custom_list_tile.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          // Top Gradient
          Positioned(
            left: 273,
            top: -35,
            width: 190,
            height: 185,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.0981 * 2 - 1, 0.3264 * 2 - 1),
                  radius: 0.4,
                  colors: const [Color(0xFF6DC2FF), Color(0xFF0A5CFF)],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          // Bottom Gradient
          Positioned(
            left: -76,
            top: 307,
            width: 300,
            height: 230,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.0981 * 2 - 1, 0.3264 * 2 - 1),
                  radius: 0.4,
                  colors: const [Color(0xFF6DC2FF), Color(0xFF0A5CFF)],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 8),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/figma149/white_logo.svg',
                            width: 39.5,
                            height: 25.06,
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'assets/icons/figma149/money_icon.svg',
                            width: 28,
                            height: 30,
                          ),
                          SizedBox(width: 12),
                          SvgPicture.asset(
                            'assets/icons/figma149/profile_icon.svg',
                            width: 28,
                            height: 30,
                          ),                                
                                  
                        ],
                      ),
                                  
                      const SizedBox(height: 20),
                                  
                      HelveticaneueFont(
                        text: AppLocalization.frameTitle,
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                                  
                      const SizedBox(height: 20),
                                  
                      // body (2)
                      Column(
                        children: [
                          CustomListTile(
                            iconPath: 'assets/icons/figma149/column1.svg',
                            tileText: AppLocalization.countriesInOneEsim,
                          ),
                          CustomListTile(
                            iconPath: 'assets/icons/figma149/column2.svg',
                            tileText: AppLocalization.frameCheckTitle,
                          ),
                          CustomListTile(
                            iconPath: 'assets/icons/figma149/column3.svg',
                            tileText: AppLocalization.infinityTitle,
                          ),
                          CustomListTile(
                            iconPath: 'assets/icons/figma149/column4.svg',
                            tileText: AppLocalization.highSpeedLowCost,
                          ),                                                
                        ],
                      ),
                                  
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
          
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 60, 16, 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomIconContainer(
                              blueIconPath: 'assets/icons/figma149/blue_icon1.svg',
                              text: AppLocalization.howToInstallEsim2,
                            ),
                            SizedBox(width: 15),
                            CustomIconContainer(
                              blueIconPath: 'assets/icons/figma149/blue_icon2.svg',
                              text: AppLocalization.supportChat,
                            ),                        
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CustomIconContainer(
                              blueIconPath: 'assets/icons/figma149/blue_icon3.svg',
                              text: AppLocalization.howDoesItWork,
                              onTap:() => openGuidePage(context),
                            ),                        
                            SizedBox(width: 15),
                            CustomIconContainer(
                              blueIconPath: 'assets/icons/figma149/blue_icon4.svg',
                              text: AppLocalization.countriesAndRates,
                            ),                        
                          ],
                        ),
                          
                        Spacer(),
                
                        BlueButton(buttonText: AppLocalization.activateEsim)                
                        
                      ],
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
