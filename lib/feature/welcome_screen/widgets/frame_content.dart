import 'package:flex_travel_sim/feature/welcome_screen/widgets/auth_intro.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/otp_tile.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/pulsing_circle.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/whatsapp_tile.dart';
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

class _FrameContentState extends State<FrameContent> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void _goToWhatsappPage() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    widget.onContinueTap();
  }

  void _goToOtpPage() {
    _pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -widget.circleSize / 2,
          top: widget.mediaHeight / 2 - widget.circleSize / 2,
          child: PulsingCircle(
            animation: widget.scaleAnimation,
            size: widget.circleSize,
          ),
        ),
        Positioned(
          left: -widget.circleSize / 2,
          bottom: -widget.circleSize / 2,
          child: PulsingCircle(
            animation: widget.scaleAnimation,
            size: widget.circleSize,
          ),
        ),
        PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AuthIntro(onAuthTap: _goToWhatsappPage),
            WhatsappTile(onNext: _goToOtpPage, appBarPop: _goBackToIntro),
            OtpTile(onTap: _goToWhatsappPage, appBarPop: _goToWhatsappPage),
          ],
        ),
      ],
    );
  }
}
