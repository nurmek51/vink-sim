import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/presentation/screens/auth_by_email.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/auth_intro.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/otp_tile.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/pulsing_circle.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/whatsapp_tile.dart';
import 'package:flutter/material.dart';

class FrameContent extends StatefulWidget {
  const FrameContent({
    super.key,
    required this.circleSize,
    required this.mediaHeight,
    required this.scaleAnimation,
    required this.onContinueTap,
    required this.onBackTap,
  });

  final double circleSize;
  final double mediaHeight;
  final Animation<double> scaleAnimation;
  final VoidCallback onContinueTap;
  final VoidCallback onBackTap;

  @override
  State<FrameContent> createState() => _FrameContentState();
}

class _FrameContentState extends State<FrameContent>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _moveController;
  late final Animation<Offset> _verticalAnimation;
  late final Animation<Offset> _horizontalAnimation;

  String _phoneForOtp = '';
  ConfirmMethod _confirmMethod = ConfirmMethod.byPhone; // значение по умолчанию

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _verticalAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -20),
    ).animate(
      CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
    );

    _horizontalAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(20, 0),
    ).animate(
      CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _moveController.dispose();
    super.dispose();
  }

  void _goToWhatsappPage() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    widget.onContinueTap();
  }

  void _goToOtpPage(String formattedPhone, ConfirmMethod method) {
    setState(() => _phoneForOtp = formattedPhone);
    setState(() {
      _phoneForOtp = formattedPhone;
      _confirmMethod = method;
    });
    _pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _goToEmailPage() {
    // Переходим к странице ввода email в PageView
    _pageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _goToEmailAuth(
    String email,
    ConfirmMethod method,
    BuildContext context,
  ) {
    // Email уже обрабатывается в AuthByEmail, ничего не делаем
  }

  void _goBackToIntro() {
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    widget.onBackTap();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _verticalAnimation,
          builder: (_, __) {
            return Positioned(
              right: -widget.circleSize / 2,
              top:
                  widget.mediaHeight / 2 -
                  widget.circleSize / 2 +
                  _verticalAnimation.value.dy,
              child: PulsingCircle(
                animation: widget.scaleAnimation,
                size: widget.circleSize,
              ),
            );
          },
        ),

        AnimatedBuilder(
          animation: _horizontalAnimation,
          builder: (_, __) {
            return Positioned(
              left: -widget.circleSize / 2 + _horizontalAnimation.value.dx,
              bottom: -widget.circleSize / 2,
              child: PulsingCircle(
                animation: widget.scaleAnimation,
                size: widget.circleSize,
              ),
            );
          },
        ),

        PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AuthIntro(onAuthTap: _goToWhatsappPage),
            WhatsappTile(
              onNext: _goToOtpPage,
              appBarPop: _goBackToIntro,
              onEmailTap: _goToEmailPage,
            ),
            OtpTile(
              phoneNumber: _phoneForOtp,
              method: _confirmMethod,
              onTap: _goToWhatsappPage,
              appBarPop: _goToWhatsappPage,
            ),
            AuthByEmail(
              onNext: (email, method) => _goToEmailAuth(email, method, context),
              appBarPop: _goToWhatsappPage,
            ),
          ],
        ),
      ],
    );
  }
}
