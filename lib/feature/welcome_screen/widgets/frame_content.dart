import 'package:flex_travel_sim/feature/welcome_screen/widgets/auth_intro.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/otp_tile.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/pulsing_circle.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/whatsapp_tile.dart';
import 'package:flutter/material.dart';

class FrameContent extends StatelessWidget {
  const FrameContent({
    super.key,
    required double circleSize,
    required this.mediaHeight,
    required Animation<double> scaleAnimation,
    required this.showAuthOptions,
    required this.onAuthTap,
  }) : _circleSize = circleSize,
       _scaleAnimation = scaleAnimation;

  final double _circleSize;
  final double mediaHeight;
  final Animation<double> _scaleAnimation;
  final bool showAuthOptions;
  final VoidCallback onAuthTap;

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
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child:
              showAuthOptions
                  // ? OtpTile(key: const ValueKey('otpTile'), onTap: onAuthTap)
                  ? WhatsappTile(key: const ValueKey('whatsappTile'))
                  : AuthIntro(
                    onAuthTap: onAuthTap,
                    key: const ValueKey('authIntro'),
                  ),
        ),
      ],
    );
  }
}
