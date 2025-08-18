import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/core/utils/country_code_utils.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/data/data_sources/tariffs_remote_data_source.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_bloc.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_event.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_state.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/widgets/country_list_tile.dart';
import 'package:flex_travel_sim/shared/widgets/app_notifier.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/shared/widgets/start_registration_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TariffsAndCountriesScreen extends StatelessWidget {
  final bool isAuthorized;

  const TariffsAndCountriesScreen({super.key, this.isAuthorized = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              TariffsBloc(dataSource: TariffsRemoteDataSourceImpl())
                ..add(const LoadTariffsEvent()),
      child: _TariffsAndCountriesView(isAuthorized: isAuthorized),
    );
  }
}

class _TariffsAndCountriesView extends StatefulWidget {
  final bool isAuthorized;

  const _TariffsAndCountriesView({required this.isAuthorized});

  @override
  State<_TariffsAndCountriesView> createState() =>
      _TariffsAndCountriesViewState();
}

class _TariffsAndCountriesViewState extends State<_TariffsAndCountriesView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Map<String, List<dynamic>> _groupOperatorsByCountry(List<dynamic> operators) {
    final Map<String, List<dynamic>> grouped = {};
    for (final operator in operators) {
      grouped.putIfAbsent(operator.countryName, () => []).add(operator);
    }
    
    // Sort countries by number of operators (descending)
    final sortedEntries = grouped.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length));
    
    return Map.fromEntries(sortedEntries);
  }

  @override
  Widget build(BuildContext context) {
    const paddingSettings = EdgeInsets.only(left: 20, right: 20);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: LocalizedText(
          AppLocalizations.tariffsAndCountries,
          style: FlexTypography.label.medium,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      bottomNavigationBar: widget.isAuthorized
          ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ).copyWith(bottom: 30, top: 12),
                child: StartRegistrationButton(),
              )
              : null,
      body: Padding(
        padding: paddingSettings,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onChanged: (value) {
                  context.read<TariffsBloc>().add(SearchTariffsEvent(value));
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<TariffsBloc, TariffsState>(
                builder: (context, state) {
                  if (state is TariffsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        value: 0.3,
                        strokeWidth: 18,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation(Colors.grey[400]!),
                      ),
                    );
                  }

                  if (state is TariffsError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      AppNotifier.error(
                        AppLocalizations.error,
                      ).showAppToast(context);
                    });
                    return Center(
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

                  if (state is TariffsLoaded) {
                    final operatorsToShow =
                        state.searchQuery?.isNotEmpty == true
                            ? _groupOperatorsByCountry(state.filteredOperators)
                            : state.operatorsByCountry;

                    final countries = operatorsToShow.keys.toList();

                    return ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        final operators = operatorsToShow[country]!;
                        final pricePerGB =
                            state.pricePerGbByCountry[country] ?? 0.0;

                        // Use PLMN code from first operator for more accurate country mapping
                        final firstOperator = operators.first;
                        final countryCode =
                            CountryCodeUtils.getCountryCodeEnhanced(
                              country,
                              plmnCode: firstOperator.plmn,
                            );

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CountryListTile(
                            countryTitle: country,
                            countrySubtitle:
                                '${operators.length} operators available',
                            price: '\$${pricePerGB.toStringAsFixed(2)} / 1GB',
                            countryCode: countryCode,
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  }

                  return const Center(child: Text('No data available'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
