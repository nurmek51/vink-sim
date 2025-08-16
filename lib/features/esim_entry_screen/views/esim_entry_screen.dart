import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/auth_intro_bottomsheet_content.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/benefit_tile.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/country_list_button.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/pulsing_circle.dart';
import 'package:flex_travel_sim/features/subscriber/services/subscriber_local_service.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
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

     SubscriberLocalService.resetImsiList(screenRoute: 'Esim Entry Screen');
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

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 8),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
          
                  const SizedBox(height: 30),
          
                  WhatIsEsimButton(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: AuthIntroBottomsheetContent(
                                onActivateTap: () {
                                  NavigationService.openTopUpBalanceScreen(context);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
