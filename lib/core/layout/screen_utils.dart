import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

bool isDesktop(BuildContext context) {
  return kIsWeb && screenWidth(context) > 900;
}

bool isSmallScreen(BuildContext context) {
  return screenWidth(context) < 380;
}

bool isTopUpScreenScrollable(BuildContext context) {
  return screenHeight(context) < 850;
}