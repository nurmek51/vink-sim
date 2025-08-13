import 'package:easy_localization/easy_localization.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_event.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/scroll_container_shimmer.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/scroll_container.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_bloc.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_state.dart';
import 'package:flex_travel_sim/shared/widgets/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TariffScrollView extends StatelessWidget {
  const TariffScrollView({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
      builder: (context, topUpState) {
        final amount = topUpState.amount.toDouble();

        return BlocBuilder<TariffsBloc, TariffsState>(
          builder: (context, tariffsState) {
            if (tariffsState is TariffsLoaded) {
              // Берем первые 10 стран
              final entries = tariffsState.pricePerGbByCountry.entries.take(10).toList();

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < entries.length; i++) ...[
                      ScrollContainer(
                        sum: double.parse(
                          (entries[i].value > 0 ? amount / entries[i].value : 0)
                              .toStringAsFixed(1),
                        ),
                        country: '${AppLocalizations.inCountry.tr()} ${entries[i].key}',
                      ),
                      if (i != entries.length - 1)
                        const SizedBox(width: 8), 
                    ],
                  ],
                ),
              );
            }

            if (tariffsState is TariffsLoading) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: List.generate(
                    6,
                    (index) => const ScrollContainerShimmer(),
                  ),
                ),
              );
            }

            if (tariffsState is TariffsError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppNotifier.error(AppLocalizations.error).showAppToast(context);
              });
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<TariffsBloc>().add(
                      const RefreshTariffsEvent(),
                    );
                  },
                  child: const Text('Retry'),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
