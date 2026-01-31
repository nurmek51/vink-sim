import 'dart:math';
import 'package:vink_sim/core/layout/screen_utils.dart';
import 'package:flutter/material.dart';

class PercentageShimmerWidget extends StatefulWidget {
  const PercentageShimmerWidget({super.key});

  @override
  State<PercentageShimmerWidget> createState() => _PercentageShimmerWidgetState();
}

class _PercentageShimmerWidgetState extends State<PercentageShimmerWidget>
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
    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
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
    final isSmallSize = isSmallScreen(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Circular progress shimmer
            Transform.rotate(
              angle: pi / 180,
              child: SizedBox(
                width: isSmallSize ? 281 : 292,
                height: isSmallSize ? 281 : 292,
                child: CircularProgressIndicator(
                  value: 0.3,
                  strokeWidth: 18,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation(Colors.grey[400]!),
                ),
              ),
            ),
            // Content shimmer
            Column(
              children: [
                const SizedBox(height: 80),
                // Country container shimmer
                _buildShimmerContainer(
                  width: 100,
                  height: 26,
                  borderRadius: 9,
                ),
                const SizedBox(height: 20),
                // Main GB text shimmer
                _buildShimmerContainer(
                  width: 140,
                  height: 60,
                  borderRadius: 8,
                ),
                const SizedBox(height: 8),
                // Available data text shimmer
                _buildShimmerContainer(
                  width: 120,
                  height: 16,
                  borderRadius: 4,
                ),
                const SizedBox(height: 8),
                // Balance text shimmer
                _buildShimmerContainer(
                  width: 100,
                  height: 14,
                  borderRadius: 4,
                ),
                const SizedBox(height: 20),
                // Top up button shimmer
                _buildShimmerContainer(
                  width: 80,
                  height: 16,
                  borderRadius: 4,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmerContainer({
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
            _animation.value - 1,
            _animation.value,
            _animation.value + 1,
          ],
          colors: [
            Colors.grey[300]!,
            Colors.grey[100]!,
            Colors.grey[300]!,
          ],
        ),
      ),
    );
  }
}