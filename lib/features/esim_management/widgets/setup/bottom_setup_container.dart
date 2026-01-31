import 'package:vink_sim/components/widgets/blue_button.dart';
import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class BottomSetupContainer extends StatelessWidget {
  final bool isActivatedEsimScreen;
  const BottomSetupContainer({super.key, this.isActivatedEsimScreen = false});

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
              text: SimLocalizations.of(context)!.success_message,
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20),
            HelveticaneueFont(
              text: SimLocalizations.of(context)!.connection_wait_message,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20),
            HelveticaneueFont(
              text: SimLocalizations.of(context)!.connection_retry_instruction,
              textAlign: TextAlign.center,
              fontSize: 16,
              color: Color(0xFF7D7D7D),
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                if (isActivatedEsimScreen) {
                  NavigationService.openMainFlowScreen(context);
                } else {
                  NavigationService.pop(context);
                }
              },
              child: BlueButton(
                buttonText: SimLocalizations.of(context)!.close,
              ),
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
                    text: SimLocalizations.of(context)!.support_chat2,
                    fontSize: 14,
                    color: Color(0xFF1F6FFF),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
