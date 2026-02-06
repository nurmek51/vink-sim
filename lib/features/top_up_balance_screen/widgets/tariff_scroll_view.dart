import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/features/tariffs_and_countries/data/models/sort_type.dart';
import 'package:vink_sim/features/tariffs_and_countries/presentation/bloc/tariffs_event.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/scroll_container_shimmer.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/scroll_container.dart';
import 'package:vink_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:vink_sim/features/tariffs_and_countries/presentation/bloc/tariffs_bloc.dart';
import 'package:vink_sim/features/tariffs_and_countries/presentation/bloc/tariffs_state.dart';
import 'package:vink_sim/shared/widgets/app_notifier.dart';
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
              final entries = tariffsState.pricePerGbByCountry.entries.toList();

              // Sort by popularity
              entries.sort((a, b) {
                final popularOrder = CountrySortTypeExtension.popularCountries;
                final indexA = popularOrder.indexOf(a.key);
                final indexB = popularOrder.indexOf(b.key);

                if (indexA == -1 && indexB == -1) {
                  // Fallback to operator count if available, otherwise alphabetical
                  final countA =
                      tariffsState.operatorsByCountry[a.key]?.length ?? 0;
                  final countB =
                      tariffsState.operatorsByCountry[b.key]?.length ?? 0;
                  if (countA != countB) return countB.compareTo(countA);
                  return a.key.compareTo(b.key);
                }
                if (indexA == -1) return 1;
                if (indexB == -1) return -1;
                return indexA.compareTo(indexB);
              });

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
                        country:
                            '${SimLocalizations.of(context)!.in_country} ${entries[i].key}',
                      ),
                      if (i != entries.length - 1) const SizedBox(width: 8),
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
                AppNotifier.error(
                  SimLocalizations.of(context)!.error,
                ).showAppToast(context);
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
