import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/guide_page/components/widgets/table_view_cells.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  final bool isAuthorized;
  const GuidePage({super.key, this.isAuthorized = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColorLight,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: isSmallScreen(context) ? 0 : 10,
          bottom: 50,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HelveticaneueFont(
              text: AppLocalizations.howDoesItWork,
              fontSize: 28,
              letterSpacing: -1,
              height: 1.1,
              fontWeight: FontWeight.bold,
              color: Color(0xFF363C45),
            ),
      
            SizedBox(height: 15),
      
            HelveticaneueFont(
              text: AppLocalizations.esimDescription1,
              fontSize: 17,
              letterSpacing: -0.5,
              height: 1.3,
              color: Color(0xFF363C45),
            ),
      
            SizedBox(height: 12),
      
            HelveticaneueFont(
              text: AppLocalizations.esimDescription2,
              fontSize: 17,
              letterSpacing: -0.5,
              height: 1.3,
              color: Color(0xFF363C45),
            ),
      
            SizedBox(height: isSmallScreen(context) ? 3 : 12),
      
            TableViewCells(isAuthorized: isAuthorized),

            Spacer(),
      
            GestureDetector(
              onTap: () => openTopUpBalanceScreen(context),
              child: Container(
                alignment: Alignment.center,
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppColors.containerGradientPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: LocalizedText(
                  AppLocalizations.topUpBalance,
                  style: FlexTypography.label.medium.copyWith(
                    color: Colors.white,
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