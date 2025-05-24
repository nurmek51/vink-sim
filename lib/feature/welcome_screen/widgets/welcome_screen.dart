import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/benefit_tile.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/button/auth_button.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/button/country_list_button.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/pulsing_circle.dart';
import 'package:flex_travel_sim/shared/widgets/header.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
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
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FrameContent(
          circleSize: _circleSize,
          mediaHeight: mediaHeight,
          scaleAnimation: _scaleAnimation,
        ),
      ),
    );
  }
}

class FrameContent extends StatelessWidget {
  const FrameContent({
    super.key,
    required double circleSize,
    required this.mediaHeight,
    required Animation<double> scaleAnimation,
  }) : _circleSize = circleSize,
       _scaleAnimation = scaleAnimation;

  final double _circleSize;
  final double mediaHeight;
  final Animation<double> _scaleAnimation;

  get balance => 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -_circleSize / 2,
          top: mediaHeight / 2 - _circleSize / 2,
          child: PulsingCircle(animation: _scaleAnimation, size: _circleSize),
        ),

        Positioned(
          left: -_circleSize / 2,
          bottom: -_circleSize / 2,
          child: PulsingCircle(animation: _scaleAnimation, size: _circleSize),
        ),

        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,

            top: 5,
            bottom: 8,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),
                Header(color: AppColors.textColorLight),
                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.topLeft,
                  child: const HelveticaneueFont(
                    text: AppLocalization.frameTitle,
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 30),
                BenefitTile(
                  icon: Assets.icons.globus.path,
                  title: AppLocalization.frameGlobusTitle,
                ),
                SizedBox(height: 12),
                BenefitTile(
                  icon: Assets.icons.check.path,
                  title: AppLocalization.frameCheckTitle,
                ),
                SizedBox(height: 12),
                BenefitTile(
                  icon: Assets.icons.infinity.path,
                  title: AppLocalization.infinityTitle,
                ),
                SizedBox(height: 12),
                BenefitTile(icon: Assets.icons.card.path, title: 'Пакеты от 1\$'),
                const SizedBox(height: 30),
                WhatIsEsimButton(ontap: () => openInitialPage(context)),
                Spacer(),
            
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AuthButton(
                    onTap: () => openAuthScreen(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
