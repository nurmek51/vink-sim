import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/screen149/widgets/custom_icon_container.dart';
import 'package:flex_travel_sim/feature/top_up_balance_screen/top_up_balance_screen.dart';
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
            left: 30,
            right: 30,

            top: 20,
            bottom: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(color: AppColors.textColorLight),
              const SizedBox(height: 30),
              const Text(
                AppLocalization.frameTitle,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: AppColors.backgroundColorLight,
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
              AuthButton(
                onTap: () => openAuthScreen(context),
                // onTap: () {
                //   showModalBottomSheet(
                //     context: context,
                //     shape: const RoundedRectangleBorder(
                //       borderRadius: BorderRadius.vertical(
                //         top: Radius.circular(16),
                //       ),
                //     ),
                //     builder:
                //         (context) => Padding(
                //           padding: EdgeInsets.only(
                //             bottom: MediaQuery.of(context).viewInsets.bottom,
                //           ),
                //           child: SizedBox(
                //             width: double.infinity,
                //             child: Container(
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.only(
                //                   topLeft: Radius.circular(24),
                //                   topRight: Radius.circular(24),
                //                 ),
                //                 color: Colors.white,
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.fromLTRB(
                //                   16,
                //                   60,
                //                   16,
                //                   5,
                //                 ),
                //                 child: Column(
                //                   children: [
                //                     Row(
                //                       children: [
                //                         CustomIconContainer(
                //                           blueIconPath:
                //                               'assets/icons/figma149/blue_icon1.svg',
                //                           text: 'Как установить\neSIM?',
                //                         ),
                //                         SizedBox(width: 15),
                //                         CustomIconContainer(
                //                           blueIconPath:
                //                               'assets/icons/figma149/blue_icon2.svg',
                //                           text: 'Чат\nподдержки',
                //                         ),
                //                       ],
                //                     ),
                //                     SizedBox(height: 20),
                //                     Row(
                //                       children: [
                //                         CustomIconContainer(
                //                           blueIconPath:
                //                               'assets/icons/figma149/blue_icon3.svg',
                //                           text: 'Как это\nработает?',
                //                           onTap: () => openGuidePage(context),
                //                         ),
                //                         SizedBox(width: 15),
                //                         CustomIconContainer(
                //                           blueIconPath:
                //                               'assets/icons/figma149/blue_icon4.svg',
                //                           text: 'Страны\nи тарифы',
                //                         ),
                //                       ],
                //                     ),
                //                     SizedBox(height: 20),
                //                     GestureDetector(
                //                       onTap: () {
                //                         Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                             builder:
                //                                 (context) =>
                //                                     const TopUpBalanceScreen(),
                //                           ),
                //                         );
                //                       },
                //                       child: Container(
                //                         alignment: Alignment.center,
                //                         height: 52,
                //                         decoration: BoxDecoration(
                //                           gradient:
                //                               AppColors
                //                                   .containerGradientPrimary,
                //                           borderRadius: BorderRadius.circular(
                //                             16,
                //                           ),
                //                         ),
                //                         child: const Text(
                //                           'Активировать eSIM',
                //                           style: TextStyle(
                //                             color: Colors.white,
                //                             fontSize: 16,
                //                             fontWeight: FontWeight.w500,
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //   );
                // },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
