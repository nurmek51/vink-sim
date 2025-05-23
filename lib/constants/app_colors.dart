import 'package:flutter/material.dart';

class AppColors {
  static const backgroundColorDark = Color.fromARGB(0, 0, 0, 0);
  static const backgroundColorLight = Color(0xFFFFFFFF);
  static const primaryColor = Color(0xFF33899E);
  static const secondaryColor = Color(0xFFD54444);
  static const textColorDark = Color(0xFF000000);
  static const textColorLight = Color(0xFFFFFFFF);
  static const iconColor = Color(0xFF155A6A);
  static const activeTextColor = Color(0xFF388DA2);
  static const buttonColor = Color(0xFF388DA2);
  static const grayBlue = Color(0xFF363C45);
  static const containerGray = Color(0xFFE7EFF7);
  static const splashColor = Color((0xFF2875FF));
  static const whatsAppColor = Color((0xFF25D366));
  static const accentBlue = Color((0xFF1F6FFF));
  static const babyBlue = Color((0XFF1EA1F3));
  static const containerGradientPrimary = LinearGradient(
    colors: [Color(0xFF2875FF), Color(0xFF0059F9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const containerGradientSecondary = LinearGradient(
    colors: [Colors.lightGreenAccent, Colors.lightGreenAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
