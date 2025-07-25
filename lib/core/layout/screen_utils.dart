import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool isDesktop(BuildContext context) {
  return kIsWeb && MediaQuery.of(context).size.width > 900;
}

bool isSmallScreen(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width < 380;
}