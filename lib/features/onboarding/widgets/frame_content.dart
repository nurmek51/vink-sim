import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/presentation/screens/auth_by_email.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/animated_page_stack.dart';
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
    this.initialIndex = 0,
  });

  final int initialIndex;
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
  late final AnimationController _moveController;
  late final Animation<Offset> _verticalAnimation;
  late final Animation<Offset> _horizontalAnimation;

  int _currentPage = 0;
  String _phoneForOtp = '';
  ConfirmMethod _confirmMethod = ConfirmMethod.byPhone;

  @override
  void initState() {
    super.initState();

    _currentPage = widget.initialIndex;

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
    _moveController.dispose();
    super.dispose();
  }

void _goToWhatsappPage() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    setState(() => _currentPage = 1);
  });
  widget.onContinueTap();
}


  void _goToOtpPage(String formattedPhone, ConfirmMethod method) {
    setState(() {
      _phoneForOtp = formattedPhone;
      _confirmMethod = method;
      _currentPage = 2;
    });
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
    setState(() => _currentPage = 0);
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
              top: widget.mediaHeight / 2 -
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
        
        AnimatedPageStack(
          index: _currentPage,
          pageBuilders: [
            (context) => AuthIntro(onAuthTap: _goToWhatsappPage),
            (context) => WhatsappTile(
              onNext: _goToOtpPage,
              appBarPop: _goBackToIntro,
              onEmailTap: _goToEmailPage,
            ),
            (context) => OtpTile(
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
