import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/expanded_container.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/benefit_tile.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/pulsing_circle.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class EsimEntryScreen extends StatefulWidget {
  const EsimEntryScreen({super.key});

  @override
  State<EsimEntryScreen> createState() => _EsimEntryScreenState();
}

class _EsimEntryScreenState extends State<EsimEntryScreen>
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
                          Assets.icons.figma149.whiteLogo.svg(
                            width: 39.5,
                            height: 25.06,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => openTariffsAndCountriesPage(context),
                            child: Assets.icons.figma149.moneyIcon.svg(
                              width: 28,
                              height: 30,
                            ),
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                            onTap: () => openMyAccountScreen(context),
                            child: Assets.icons.figma149.profileIcon.svg(
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
                          text: AppLocalizations.frameTitle,
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),

                      BenefitTile(
                        icon: Assets.icons.figma149.column1.path,
                        title: AppLocalizations.countriesInOneEsim,
                      ),
                      SizedBox(height: 12),
                      BenefitTile(
                        icon: Assets.icons.figma149.column2.path,
                        title: AppLocalizations.frameCheckTitle,
                      ),
                      SizedBox(height: 12),
                      BenefitTile(
                        icon: Assets.icons.figma149.column3.path,
                        title: AppLocalizations.infinityTitle,
                      ),
                      SizedBox(height: 12),
                      BenefitTile(
                        icon: Assets.icons.figma149.column4.path,
                        title: AppLocalizations.highSpeedLowCost,
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
                              title: AppLocalizations.howToInstallEsim2,
                              icon: Assets.icons.figma149.blueIcon11.path,
                              onTap: () => openEsimSetupPage(context),
                            ),
                            const SizedBox(width: 16),
                            ExpandedContainer(
                              title: AppLocalizations.supportChat,
                              icon: Assets.icons.figma149.blueIcon22.path,
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
                              title: AppLocalizations.howDoesItWork,
                              icon: Assets.icons.figma149.blueIcon33.path,
                              onTap: () => openGuidePage(context),
                            ),
                            const SizedBox(width: 16),
                            ExpandedContainer(
                              title: AppLocalizations.countriesAndRates,
                              icon: Assets.icons.figma149.blueIcon44.path,
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
                            child: const LocalizedText(
                              AppLocalizations.activateEsim,
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
