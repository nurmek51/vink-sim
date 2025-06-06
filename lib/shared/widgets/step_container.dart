import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Общий виджет для отображения шагов инструкций
class StepContainer extends StatelessWidget {
  final String iconPath;
  final String stepNum;
  final String description;
  final Color backgroundColor;
  final Color textColor;

  const StepContainer({
    super.key,
    required this.iconPath,
    required this.stepNum,
    required this.description,
    this.backgroundColor = const Color(0xFFE7EFF7),
    this.textColor = const Color(0xFF363C45),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HelveticaneueFont(
                  text: 'Шаг $stepNum',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                const SizedBox(height: 4),
                HelveticaneueFont(
                  text: description,
                  fontSize: 14,
                  height: 1.3,
                  color: textColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
