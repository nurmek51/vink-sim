import 'package:flutter/material.dart';

class HelveticaneueFont extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? letterSpacing;
  final Color color;
  final FontWeight? fontWeight;
  final double? height;
  final TextAlign? textAlign;

  const HelveticaneueFont({
    super.key,
    required this.text,
    required this.fontSize,
    this.letterSpacing,
    required this.color,
    this.fontWeight,
    this.height,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'HelveticaNeue',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
      )
    );
  }
}