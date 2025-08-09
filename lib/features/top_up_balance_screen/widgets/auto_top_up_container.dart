import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutoTopUpContainer extends StatelessWidget {
  const AutoTopUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.containerGray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LocalizedText(
                  AppLocalizations.autoTopUp,
                  style: FlexTypography.paragraph.medium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                LocalizedText(
                  AppLocalizations.autoTopUpDescription,
                  style: FlexTypography.paragraph.small,
                ),
              ],
            ),
          ),
          BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
            builder: (context, state) {
              return CupertinoSwitch(
                value: state.autoTopUpEnabled,
                onChanged:
                    (value) => context.read<TopUpBalanceBloc>().add(
                      ToggleAutoTopUp(value),
                    ),
                activeTrackColor: CupertinoColors.systemBlue,
              );
            },
          ),
        ],
      ),
    );
  }
}
