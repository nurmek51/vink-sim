import 'package:flutter/material.dart';

class PulsingCircle extends StatelessWidget {
  final Animation<double> animation;
  final double size;

  const PulsingCircle({super.key, required this.animation, this.size = 400});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Transform.scale(scale: animation.value, child: child);
      },
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.5,
            colors: [
              Color.fromRGBO(255, 255, 255, 0.9),
              Color.fromRGBO(22, 150, 255, 0.302),
              Color.fromRGBO(8, 112, 248, 0.012),
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
      ),
    );
  }
}
