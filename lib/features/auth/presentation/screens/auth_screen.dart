import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/core/router/app_router.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/registration_container.dart';
import 'package:go_router/go_router.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/mobile_number_field.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/pulsing_circle.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FrameContent(
        circleSize: _circleSize,
        mediaHeight: mediaHeight,
        scaleAnimation: _scaleAnimation,
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
            top: 10,
            bottom: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              LocalizedText(
                AppLocalizations.authWithTheHelpOf,
                style: FlexTypography.headline.large.copyWith(
                  color: AppColors.backgroundColorLight,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    AppLocalizations.whatsApp,
                    style: FlexTypography.headline.large.copyWith(
                      color: AppColors.whatsAppColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    Assets.icons.whatsappIcon.path,
                    colorFilter: const ColorFilter.mode(
                      AppColors.whatsAppColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LocalizedText(
                AppLocalizations.mobileNumWhatsAppDescription,
                style: FlexTypography.paragraph.medium.copyWith(
                  color: AppColors.backgroundColorLight,
                ),
              ),

              const SizedBox(height: 20),

              const MobileNumberField(),

              const SizedBox(height: 20),

              RegistrationContainer(
                onTap: () => openMainFlowScreen(context),
                buttonText: AppLocalizations.authAndRegistration,
                buttonTextColor: AppColors.backgroundColorLight,
                color: AppColors.accentBlue,
                arrowForward: true,
              ),

              const Spacer(),

              RegistrationContainer(
                onTap: () => openInitialPage(context),
                buttonText: AppLocalizations.continueWithApple,
                buttonTextColor: AppColors.textColorLight,
                color: AppColors.textColorDark,
                borderLine: const BorderSide(color: AppColors.textColorLight),
                iconPath: Assets.icons.appleLogo.path,
              ),

              const SizedBox(height: 16),

              RegistrationContainer(
                onTap: () => openInitialPage(context),
                buttonText: AppLocalizations.continueWithGoogle,
                buttonTextColor: AppColors.textColorDark,
                color: AppColors.textColorLight,
                borderLine: const BorderSide(color: AppColors.textColorDark),
                iconPath: Assets.icons.googleLogo.path,
              ),

              const SizedBox(height: 16),

              RegistrationContainer(
                onTap: () => context.push(AppRoutes.auth),
                buttonText: AppLocalizations.continueWithEmail,
                buttonTextColor: AppColors.textColorLight,
                color: AppColors.babyBlue,
                iconPath: Assets.icons.emailLogo.path,
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
