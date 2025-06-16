import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {
  final String? stepNum;
  final String? stepTitle;
  final String description;
  final double? height;
  final double? widgth;
  final Widget? child;

  const BodyContainer({
    super.key,
    this.stepNum,
    this.stepTitle,
    this.widgth,
    this.height,
    required this.description,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final String headerText = stepTitle ?? 'Шаг $stepNum';
    return Container(
      width: widgth,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE7EFF7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 24,
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF363C45),
              ),
              child: HelveticaneueFont(
                text: headerText,
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: HelveticaneueFont(
                text: description,
                fontSize: 16,
                color: const Color(0xFF363C45),
              ),
            ),  
          
            if (child != null) Center(child: child!),           
          ],
        ),
      ),
    );
  }
}
