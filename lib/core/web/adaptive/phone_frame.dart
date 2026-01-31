import 'package:vink_sim/core/layout/screen_utils.dart';
import 'package:flutter/material.dart';
import 'web_scaffold_config.dart';

class PhoneFrame extends StatelessWidget {
  final Widget child;
  final WebScaffoldConfig config;

  static const double phoneWidth = 390;
  static const double phoneHeight = 685;

  const PhoneFrame({
    super.key,
    required this.child,
    this.config = const WebScaffoldConfig(),
  });

  @override
  Widget build(BuildContext context) {
    if (!isDesktop(context)) return child;

    return Container(
      color: config.backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          if (config.leftSide != null)
            config.leftSide is Positioned
                ? config.leftSide!
                : Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionalTranslation(
                        translation: const Offset(-0.3, 0),
                        child: SizedBox(
                          width: 400,
                          height: 530,
                          child: config.leftSide,
                        ),
                      ),
                    ),
                  ),

          if (config.rightSide != null)
            config.rightSide is Positioned
                ? config.rightSide!
                : Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FractionalTranslation(
                        translation: const Offset(0.25, 0),
                        child: SizedBox(
                          width: 400,
                          height: 530,
                          child: config.rightSide,
                        ),
                      ),
                    ),
                  ),

          Center(
            child: SizedBox(
              width: phoneWidth,
              height: phoneHeight,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}