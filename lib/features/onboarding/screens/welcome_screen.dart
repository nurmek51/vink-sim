import 'package:flex_travel_sim/features/onboarding/bloc/welcome_bloc.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/frame_content.dart';
import 'package:flex_travel_sim/features/subscriber/services/subscriber_local_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  final int initialIndex;
  const WelcomeScreen({super.key, this.initialIndex = 0});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  static const Duration _animationDuration = Duration(seconds: 3);
  static const double _circleSize = 600;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _animationDuration)
      ..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    SubscriberLocalService.resetImsiList(screenRoute: 'WelcomeScreen');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onContinue() {
    context.read<WelcomeBloc>().add(const StopAnimation());
  }

  void _onBack() {
    context.read<WelcomeBloc>().add(const StartAnimation());
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<WelcomeBloc, WelcomeState>(
      builder: (context, state) {
        if (state.isAnimating) {
          _controller.repeat(reverse: true);
        } else {
          _controller.stop();
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: FrameContent(
            initialIndex: widget.initialIndex,
            circleSize: _circleSize,
            mediaHeight: mediaHeight,
            scaleAnimation: _scaleAnimation,
            onContinueTap: _onContinue,
            onBackTap: _onBack,
          ),
        );
      },
    );
  }
}
