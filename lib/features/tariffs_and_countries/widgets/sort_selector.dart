import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/data/models/sort_type.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_bloc.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_event.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_state.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';

class SortSelector extends StatelessWidget {
  const SortSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TariffsBloc, TariffsState>(
      builder: (context, state) {
        if (state is! TariffsLoaded) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  CountrySortType.values.map((sortType) {
                    final isSelected = state.currentSortType == sortType;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          context.read<TariffsBloc>().add(
                            SortTariffsEvent(sortType),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Colors.black
                                    : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? Colors.black
                                      : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            sortType.displayName,
                            style: FlexTypography.paragraph.small.copyWith(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }
}
