import 'package:flutter/material.dart';

class WebScaffoldConfig {
  final Color backgroundColor;
  final Widget? leftSide;
  final Widget? rightSide;

  const WebScaffoldConfig({
    this.backgroundColor = Colors.white,
    this.leftSide,
    this.rightSide,
  });
} 