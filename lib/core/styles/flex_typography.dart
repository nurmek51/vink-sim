import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';

class FlexTypography {
  FlexTypography._();

  static $FlexTypographyHeadline get headline => $FlexTypographyHeadline();
  static $FlexTypographyLabel get label => $FlexTypographyLabel();
  static $FlexTypographyParagraph get paragraph => $FlexTypographyParagraph();
}

abstract interface class $FlexTypographyBase {
  List<String> get names;
  List<TextStyle> get values;
}

class $FlexTypographyHeadline implements $FlexTypographyBase {
  $FlexTypographyHeadline();

  final _baseStyle = const TextStyle(
    fontFamily: FontFamily.helveticaNeue,
    fontWeight: FontWeight.w700,
  );

  TextStyle get xLarge =>
      _baseStyle.copyWith(fontSize: 32, height: 37 / 32, letterSpacing: -0.13);

  TextStyle get large =>
      _baseStyle.copyWith(fontSize: 28, height: 31 / 26, letterSpacing: -0.05);

  TextStyle get xMedium => _baseStyle.copyWith(fontSize: 22, height: 27 / 22);

  TextStyle get medium => _baseStyle.copyWith(fontSize: 18, height: 22 / 18);

  TextStyle get small => _baseStyle.copyWith(fontSize: 16, height: 21 / 16);

  TextStyle get xSmall => _baseStyle.copyWith(fontSize: 14, height: 18 / 14);

  @override
  List<String> get names => [
    r'xLarge',
    r'large',
    r'xMedium',
    r'medium',
    r'small',
    r'xSmall',
  ];

  @override
  List<TextStyle> get values => [xLarge, large, xMedium, medium, small, xSmall];
}

class $FlexTypographyLabel implements $FlexTypographyBase {
  $FlexTypographyLabel();

  final _baseStyle = const TextStyle(
    fontFamily: FontFamily.helveticaNeue,
    fontWeight: FontWeight.w500,
  );

  TextStyle get xLarge =>
      _baseStyle.copyWith(fontSize: 32, height: 37 / 32, letterSpacing: -0.55);

  TextStyle get large => _baseStyle.copyWith(fontSize: 18, height: 24 / 18);

  TextStyle get medium => _baseStyle.copyWith(fontSize: 16, height: 22 / 16);

  TextStyle get small => _baseStyle.copyWith(fontSize: 14, height: 18 / 14);

  @override
  List<String> get names => [r'large', r'medium', r'small'];

  @override
  List<TextStyle> get values => [large, medium, small];
}

class $FlexTypographyParagraph implements $FlexTypographyBase {
  $FlexTypographyParagraph();

  final _baseStyle = const TextStyle(
    fontFamily: FontFamily.helveticaNeue,
    fontWeight: FontWeight.w400,
  );

  TextStyle get large => _baseStyle.copyWith(fontSize: 18, height: 26 / 18);

  TextStyle get xMedium => _baseStyle.copyWith(fontSize: 16, height: 22 / 16);

  TextStyle get medium => _baseStyle.copyWith(fontSize: 14, height: 18 / 14);

  TextStyle get small => _baseStyle.copyWith(fontSize: 12, height: 15 / 12);

  @override
  List<String> get names => [r'large', r'xMedium', r'medium', r'small'];

  @override
  List<TextStyle> get values => [large, xMedium, medium, small];
}
