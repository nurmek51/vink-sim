import 'dart:ui';

import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/screen112/widgets/body_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QrCodeSelectedBody extends StatefulWidget {
  const QrCodeSelectedBody({super.key});

  @override
  State<QrCodeSelectedBody> createState() => _QrCodeSelectedBodyState();
}

class _QrCodeSelectedBodyState extends State<QrCodeSelectedBody> {
  bool _isQrVisible = false;
  
  void _toggleQrVisibility() {
    if (!_isQrVisible) {
      setState(() {
        _isQrVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [  
        BodyContainer(
          stepNum: '1',
          description: AppLocalization.qrCodeDescription,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/icons/figma112/another_step_2.jpg',
                            width: 228,
                            height: 228,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                          Positioned.fill(
                            child: AnimatedOpacity(
                              opacity: _isQrVisible ? 0.0 : 1.0,
                              duration: const Duration(milliseconds: 500),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                child: Container(
                                  color: Color.fromRGBO(255, 255, 255, 0.8),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 7,
                                          ),
                                          child: SizedBox(
                                            height: 43,
                                            width: 43,
                                            child: SvgPicture.asset(
                                              Assets.icons.infoQrCircle.path,
                                            ),
                                          ),
                                        ),
                                
                                        HelveticaneueFont(
                                          text: AppLocalization.attention,
                                          fontSize: 16,
                                          color: AppColors.textColorDark,
                                          fontWeight: FontWeight.bold,
                                        ),
                                
                                        const SizedBox(height: 7),
                                
                                        HelveticaneueFont(
                                          text: AppLocalization.youCanActivateEsimOnlyOnce,
                                          fontSize: 16,
                                          color: AppColors.textColorDark,
                                          textAlign: TextAlign.center,
                                          
                                        ),
                                
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: _toggleQrVisibility,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient:
                            _isQrVisible
                                ? AppColors.containerGradientPrimary
                                : null,
                        color: !_isQrVisible ? AppColors.grayBlue : null,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _isQrVisible ? AppLocalization.sendQR : AppLocalization.showQR,
                        style: const TextStyle(
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
          ),
        ),

    
        SizedBox(height: 15),
    
        BodyContainer(
          stepNum: '2', 
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
                        child: Image.asset(
                          'assets/icons/figma112/another_step1_1.jpg',
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
                          'assets/icons/figma112/another_step1_4.jpg',
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
          stepNum: '6', 
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
                  'assets/icons/figma112/important_step.jpg',
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

