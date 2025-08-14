import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/animated_page_stack.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/auth_intro.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/otp_tile.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/pulsing_circle.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/whatsapp_tile.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/country.dart';
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
  String _savedPhoneDigits = '';
  Country? _savedCountry;

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
      end: const Offset(0, -50),
    ).animate(
      CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
    );

    _horizontalAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(50, 0),
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

  void _goToOtpPage(
    String formattedPhone,
    ConfirmMethod method, [
    String? phoneDigits,
    Country? country,
  ]) {
    setState(() {
      _phoneForOtp = formattedPhone;
      if (phoneDigits != null) {
        _savedPhoneDigits = phoneDigits;
      }
      if (country != null) {
        _savedCountry = country;
      }
      _currentPage = 2;
    });
  }

  void _goToEmailPage() {
    setState(() => _currentPage = 3);
  }

  void _goBackToIntro() {
    setState(() => _currentPage = 0);
    widget.onBackTap();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isDesktop(context)) ...[
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
        ],

        AnimatedPageStack(
          index: _currentPage,
          pageBuilders: [
            (context) => AuthIntro(onAuthTap: _goToWhatsappPage),
            (context) => WhatsappTile(
              key: ValueKey(
                'whatsapp_${_savedPhoneDigits}_${_savedCountry?.dialCode}',
              ),
              onNext: _goToOtpPage,
              appBarPop: _goBackToIntro,
              onEmailTap: _goToEmailPage,
              initialPhoneDigits: _savedPhoneDigits,
              initialCountry: _savedCountry,
            ),
            (context) => OtpTile(
              key: ValueKey('otp_$_phoneForOtp'),
              phoneNumber: _phoneForOtp,
              onTap: _goToWhatsappPage,
              appBarPop: _goToWhatsappPage,
            ),
            (context) => Container(), // Placeholder for removed email auth
          ],
        ),
      ],
    );
  }
}
