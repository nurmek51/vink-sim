import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/tariff_scroll_view.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class TariffInfoCardWidget extends StatelessWidget {
  const TariffInfoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 183,
      decoration: BoxDecoration(
        color: AppColors.backgroundColorLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4D4D4), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocalizedText(
            AppLocalizations.flexTravelEsimWorksWorldwide,
            style: FlexTypography.paragraph.medium.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          LocalizedText(
            AppLocalizations.balance15Description,
            style: FlexTypography.paragraph.medium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const TariffScrollView(),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => openTariffsAndCountriesPage(context),
            child: LocalizedText(
              AppLocalizations.allCountriesAndTariffs,
              style: FlexTypography.paragraph.medium.copyWith(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
