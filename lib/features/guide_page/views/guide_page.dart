import 'package:flex_travel_sim/components/widgets/go_back_arrow.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/guide_page/components/widgets/table_view_cells.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  final bool isAuthorized;
  const GuidePage({
    super.key,
    this.isAuthorized = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoBackArrow(
                width: 15,
                height: 19,
                onTap: () => NavigationService.pop(context),
              ),
        
              SizedBox(height: 20),
        
              HelveticaneueFont(
                text: AppLocalization.howDoesItWork,
                fontSize: 28,
                letterSpacing: -1,
                height: 1.1,
                fontWeight: FontWeight.bold,
                color: Color(0xFF363C45)
              ),
        
              SizedBox(height: 15),
        
              HelveticaneueFont(
                text: AppLocalization.esimDescription1,
                fontSize: 17,
                letterSpacing: -0.5,
                height: 1.3,
                color: Color(0xFF363C45)
              ),
        
              SizedBox(height: 12),
        
              HelveticaneueFont(
                text: AppLocalization.esimDescription2,
                fontSize: 17,
                letterSpacing: -0.5,
                height: 1.3,
                color: Color(0xFF363C45)
              ),
        
              SizedBox(height: 12), 
        
              Expanded(child: TableViewCells(isAuthorized: isAuthorized)), 
        
              GestureDetector(
                onTap: () => openTopUpBalanceScreen(context),
                child: Container(
                    alignment: Alignment.center,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: AppColors.containerGradientPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      AppLocalization.topUpBalance,
                      style: FlexTypography.label.medium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ),        
            ],
          ),
        ),
      ),
    );
  }
}