import 'package:flutter/material.dart';

class ScrollContainerShimmer extends StatefulWidget {
  const ScrollContainerShimmer({super.key});

  @override
  State<ScrollContainerShimmer> createState() => _ScrollContainerShimmerState();
}

class _ScrollContainerShimmerState extends State<ScrollContainerShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 80,
          height: 33,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFD4D4D4), width: 1),
            gradient: LinearGradient(
              begin: Alignment(-1.0, 0),
              end: Alignment(1.0, 0),
              stops: [
                (_animation.value - 1).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 1).clamp(0.0, 1.0),
              ],
              colors: const [
                Color(0xFFD4D4D4), 
                Color(0xFFF0F0F0),
                Color(0xFFD4D4D4),
              ],
            ),
          ),
        );
      },
    );
  }
}
