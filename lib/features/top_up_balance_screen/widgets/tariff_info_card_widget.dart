import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/tariff_scroll_view.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            SimLocalizations.of(context)!.flex_travel_esim_works_worldwide,
            style: FlexTypography.paragraph.medium.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
            builder: (context, state) {
              final amount = state.amount.toString();
              return LocalizedText(
                SimLocalizations.of(context)!.balance_15_description(amount),
                style: FlexTypography.paragraph.medium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          const TariffScrollView(),
          const SizedBox(height: 20), // Small space before the link пщпщ
          GestureDetector(
            onTap: () => openTariffsAndCountriesPage(context),
            child: LocalizedText(
              SimLocalizations.of(context)!.all_countries_and_tariffs,
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
