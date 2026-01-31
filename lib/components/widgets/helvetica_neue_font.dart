import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';

class HelveticaneueFont extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? letterSpacing;
  final Color color;
  final FontWeight? fontWeight;
  final double? height;
  final TextAlign? textAlign;
  final List<String>? args;

  const HelveticaneueFont({
    super.key,
    required this.text,
    required this.fontSize,
    this.letterSpacing,
    required this.color,
    this.fontWeight,
    this.height,
    this.textAlign,
    this.args,
  });

  @override
  Widget build(BuildContext context) {
    return LocalizedText(
      text,
      args: args,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'HelveticaNeue',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}
