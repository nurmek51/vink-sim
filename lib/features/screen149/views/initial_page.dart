import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/main_flow_screen/bottom_sheet_content.dart';
import 'package:flex_travel_sim/features/main_flow_screen/widgets/expanded_container.dart';
import 'package:flex_travel_sim/features/welcome_screen/widgets/benefit_tile.dart';
import 'package:flex_travel_sim/features/welcome_screen/widgets/pulsing_circle.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  static const Duration _animationDuration = Duration(seconds: 3);
  static const double _circleSize = 600;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _animationDuration)
      ..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            right: -_circleSize / 2,
            top:
                MediaQuery.of(context).size.height * 0.25 / 2 - _circleSize / 2,
            child: PulsingCircle(animation: _scaleAnimation, size: _circleSize),
          ),
          Positioned(
            left: -_circleSize / 2,
            top: MediaQuery.of(context).size.height * 0.43 - _circleSize / 2,
            child: PulsingCircle(animation: _scaleAnimation, size: _circleSize),
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
                          GestureDetector(
                            onTap: () => openTariffsAndCountriesPage(context),
                            child: SvgPicture.asset(
                              'assets/icons/figma149/money_icon.svg',
                              width: 28,
                              height: 30,
                            ),
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                            onTap: () => openMyAccountScreen(context),
                            child: SvgPicture.asset(
                              'assets/icons/figma149/profile_icon.svg',
                              width: 28,
                              height: 30,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.topLeft,
                        child: HelveticaneueFont(
                          text: AppLocalization.frameTitle,
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),

                      BenefitTile(
                        icon: 'assets/icons/figma149/column1.svg',
                        title: AppLocalization.countriesInOneEsim,
                      ),
                      SizedBox(height: 12),
                      BenefitTile(
                        icon: 'assets/icons/figma149/column2.svg',
                        title: AppLocalization.frameCheckTitle,
                      ),
                      SizedBox(height: 12),
                      BenefitTile(
                        icon: 'assets/icons/figma149/column3.svg',
                        title: AppLocalization.infinityTitle,
                      ),
                      SizedBox(height: 12),
                      BenefitTile(
                        icon: 'assets/icons/figma149/column4.svg',
                        title: AppLocalization.highSpeedLowCost,
                      ),

                      const SizedBox(height: 15),
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
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 25),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ExpandedContainer(
                              title: AppLocalization.howToInstallEsim2,
                              icon: 'assets/icons/figma149/blue_icon11.svg',
                              onTap: () => openEsimSetupPage(context),
                            ),
                            const SizedBox(width: 16),
                            ExpandedContainer(
                              title: AppLocalization.supportChat,
                              icon: 'assets/icons/figma149/blue_icon22.svg',
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  builder:
                                      (context) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              MediaQuery.of(
                                                context,
                                              ).viewInsets.bottom,
                                        ),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: BottomSheetContent(),
                                        ),
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            ExpandedContainer(
                              title: AppLocalization.howDoesItWork,
                              icon: 'assets/icons/figma149/blue_icon33.svg',
                              onTap: () => openGuidePage(context),
                            ),
                            const SizedBox(width: 16),
                            ExpandedContainer(
                              title: AppLocalization.countriesAndRates,
                              icon: 'assets/icons/figma149/blue_icon44.svg',
                              onTap: () => openTariffsAndCountriesPage(context),
                            ),
                          ],
                        ),

                        Spacer(),

                        GestureDetector(
                          onTap: () => openTopUpBalanceScreen(context),
                          child: Container(
                            alignment: Alignment.center,
                            height: 52,
                            decoration: BoxDecoration(
                              gradient: AppColors.containerGradientPrimary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              AppLocalization.activateEsim,
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
