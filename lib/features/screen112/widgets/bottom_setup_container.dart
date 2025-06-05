import 'package:flex_travel_sim/components/widgets/blue_button.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/features/main_flow_screen/bottom_sheet_content.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomSetupContainer extends StatelessWidget {
  const BottomSetupContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),

      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 20),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/figma112/success_icon.svg',
              width: 45,
              height: 52,
            ),
            SizedBox(height: 15),
            HelveticaneueFont(
              text: AppLocalization.successMessage,
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20),
            HelveticaneueFont(
              text: AppLocalization.connectionWaitMessage,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20),
            HelveticaneueFont(
              text: AppLocalization.connectionRetryInstruction,
              textAlign: TextAlign.center,
              fontSize: 16,
              color: Color(0xFF7D7D7D),
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () => openMainFlowScreen(context),
              child: BlueButton(buttonText: AppLocalization.close),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder:
                      (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: BottomSheetContent(),
                        ),
                      ),
                );
              },
              child: Container(
                width: 126,
                height: 31,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFE7EFF7),
                ),
                child: Center(
                  child: HelveticaneueFont(
                    text: AppLocalization.supportChat2,
                    fontSize: 14,
                    color: Color(0xFF1F6FFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
