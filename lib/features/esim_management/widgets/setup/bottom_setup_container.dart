import 'package:flex_travel_sim/components/widgets/blue_button.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

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
            Assets.icons.figma112.successIcon.svg(width: 45, height: 52),
            SizedBox(height: 15),
            HelveticaneueFont(
              text: AppLocalizations.successMessage,
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20),
            HelveticaneueFont(
              text: AppLocalizations.connectionWaitMessage,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20),
            HelveticaneueFont(
              text: AppLocalizations.connectionRetryInstruction,
              textAlign: TextAlign.center,
              fontSize: 16,
              color: Color(0xFF7D7D7D),
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () => NavigationService.pop(context),
              child: BlueButton(buttonText: AppLocalizations.close),
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
                    text: AppLocalizations.supportChat2,
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
