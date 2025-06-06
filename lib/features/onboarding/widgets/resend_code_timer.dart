import 'dart:async';

import 'package:flutter/material.dart';

class ResendCodeTimer extends StatefulWidget {
  const ResendCodeTimer({super.key});

  @override
  State<ResendCodeTimer> createState() => _ResendCodeTimerState();
}

class _ResendCodeTimerState extends State<ResendCodeTimer> {
  static const int _startSeconds = 60;
  late int _secondsRemaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = _startSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Отправить код повторно ($_secondsRemaining)',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white.withOpacity(0.5),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
