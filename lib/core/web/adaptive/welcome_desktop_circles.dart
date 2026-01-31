import 'package:vink_sim/features/onboarding/widgets/pulsing_circle.dart';
import 'package:flutter/material.dart';

class WelcomeCircles extends StatefulWidget {
  const WelcomeCircles({super.key});

  @override
  State<WelcomeCircles> createState() => _WelcomeCirclesState();
}

class _WelcomeCirclesState extends State<WelcomeCircles>
    with TickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  late final AnimationController _horizontalController;
  late final Animation<Offset> _horizontalAnimation;

  late final AnimationController _verticalController;
  late final Animation<Offset> _verticalAnimation;

  static const double circleSize = 1000;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );

    _horizontalController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _verticalController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _horizontalAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(30, 0),
    ).animate(CurvedAnimation(
      parent: _horizontalController,
      curve: Curves.easeInOut,
    ));

    _verticalAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 30),
    ).animate(CurvedAnimation(
      parent: _verticalController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _verticalAnimation,
          builder: (_, __) {
            return Positioned(
              left: -circleSize / 2 + _verticalAnimation.value.dy,
              top: -circleSize / 2 + 100,
              child: PulsingCircle(
                animation: _scaleAnimation,
                size: circleSize,
              ),
            );
          },
        ),

        AnimatedBuilder(
          animation: _horizontalAnimation,
          builder: (_, __) {
            return Positioned(
              right: -circleSize / 2 + 100 + _horizontalAnimation.value.dx,
              top: mediaHeight / 2 - circleSize / 2,
              child: PulsingCircle(
                animation: _scaleAnimation,
                size: circleSize,
              ),
            );
          },
        ),
      ],
    );
  }
}
