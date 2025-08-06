import 'package:flex_travel_sim/core/localization/app_localizations.dart';
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

  double _calculatePricePerGB(List<dynamic> operators) {
    if (operators.isEmpty) return 0.0;

    final avgRate =
        operators.map((e) => e.dataRate as double).reduce((a, b) => a + b) /
        operators.length;

    if (avgRate == 0) return 0.0;

    return avgRate * 1024;
  }

  Map<String, List<dynamic>> _groupOperatorsByCountry(List<dynamic> operators) {
    final Map<String, List<dynamic>> grouped = {};
    for (final operator in operators) {
      grouped.putIfAbsent(operator.countryName, () => []).add(operator);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    const paddingSettings = EdgeInsets.only(left: 20, right: 20, bottom: 50);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: LocalizedText(
          AppLocalizations.tariffsAndCountries,
          style: titleStyle,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
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
                  hintText: 'Search countries',
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
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TariffsError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
    AppNotifier.error(AppLocalizations.error).showAppToast(context);
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
                        final pricePerGB = _calculatePricePerGB(operators);

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

            widget.isAuthorized ? const SizedBox(height: 10) : const SizedBox.shrink(),

            Visibility(
              visible: widget.isAuthorized,
              child: StartRegistrationButton(),
            ),
          ],
        ),
      ),
    );
  }
}
