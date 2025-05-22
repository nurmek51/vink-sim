import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StepsContainer extends StatelessWidget {
  final String stepNum;
  final String description;
  final String iconPath;

  const StepsContainer({
    super.key,
    required this.stepNum,
    required this.description,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: ListTile(
          leading: SvgPicture.asset(
            iconPath,
            width: 50,
            height: 50,
        ),
          title: HelveticaneueFont(
            text: 'Шаг $stepNum', 
            fontSize: 15,
            height: 1.3,
            color: Color(0xFF363C45),
            fontWeight: FontWeight.bold,
          ),
          subtitle: HelveticaneueFont(
            text: description, 
            fontSize: 15,
            height: 1.3,
            color: Color(0xFF363C45)
          ),
        ),
      ),
    );
  }
}