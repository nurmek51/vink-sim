import 'package:flex_travel_sim/components/widgets/blue_button.dart';
import 'package:flex_travel_sim/components/widgets/go_back_arrow.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/feature/screen141/components/widgets/table_view_cells.dart';
import 'package:flex_travel_sim/feature/screen141/utils/constants.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    // FIGMA NUMBER - 141
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 70, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoBackArrow(
              width: 15,
              height: 19,
              onTap: () => Navigator.pop(context),
            ),

            SizedBox(height: 20),

            HelveticaneueFont(
              text: 'Как это работает?',
              fontSize: 28,
              letterSpacing: -1,
              height: 1.1,
              fontWeight: FontWeight.bold,
              color: Color(0xFF363C45)
            ),

            SizedBox(height: 15),

            HelveticaneueFont(
              text: esimDescription1,
              fontSize: 17,
              letterSpacing: -0.5,
              height: 1.3,
              color: Color(0xFF363C45)
            ),

            SizedBox(height: 12),

            HelveticaneueFont(
              text: esimDescription2,
              fontSize: 17,
              letterSpacing: -0.5,
              height: 1.3,
              color: Color(0xFF363C45)
            ),

            SizedBox(height: 12), 

            Expanded(child: TableViewCells()), 

            BlueButton(buttonText: 'Пополнить баланс'),         

          ],
        ),
      ),
    );
  }
}