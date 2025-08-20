import 'package:flutter/material.dart';

class SimCardShimmerWidget extends StatefulWidget {
  const SimCardShimmerWidget({super.key});

  @override
  State<SimCardShimmerWidget> createState() => _SimCardShimmerWidgetState();
}

class _SimCardShimmerWidgetState extends State<SimCardShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFullShimmerContainer(width: 120, height: 16, borderRadius: 4),
            const SizedBox(height: 16),

            _buildFullShimmerContainer(
              width: double.infinity,
              height: 52,
              borderRadius: 8,
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }

  Widget _buildFullShimmerContainer({
    required double width,
    required double height,
    required double borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [
            (_animation.value - 1).clamp(0.0, 1.0),
            _animation.value.clamp(0.0, 1.0),
            (_animation.value + 1).clamp(0.0, 1.0),
          ],
          colors: [Colors.grey[300]!, Colors.grey[100]!, Colors.grey[300]!],
        ),
      ),
    );
  }
}
