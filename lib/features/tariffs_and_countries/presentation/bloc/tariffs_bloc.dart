import 'package:bloc/bloc.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/data/data_sources/tariffs_remote_data_source.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/data/models/network_operator_model.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_event.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_state.dart';
import 'package:flutter/foundation.dart';

class TariffsBloc extends Bloc<TariffsEvent, TariffsState> {
  final TariffsRemoteDataSource _dataSource;

  TariffsBloc({required TariffsRemoteDataSource dataSource})
    : _dataSource = dataSource,
      super(const TariffsInitial()) {
    on<LoadTariffsEvent>(_onLoadTariffs);
    on<RefreshTariffsEvent>(_onRefreshTariffs);
    on<FilterTariffsByCountryEvent>(_onFilterByCountry);
    on<SearchTariffsEvent>(_onSearchTariffs);
  }

  Future<void> _onLoadTariffs(
    LoadTariffsEvent event,
    Emitter<TariffsState> emit,
  ) async {
    emit(const TariffsLoading());
    await _loadOperators(emit);
  }

  Future<void> _onRefreshTariffs(
    RefreshTariffsEvent event,
    Emitter<TariffsState> emit,
  ) async {
    await _loadOperators(emit);
  }

  Future<void> _loadOperators(Emitter<TariffsState> emit) async {
    try {
      if (kDebugMode) {
        print('TariffsBloc: Loading network operators');
      }

      final operators = await _dataSource.getNetworkOperators();

      if (kDebugMode) {
        print('TariffsBloc: Loaded ${operators.length} operators');
      }

      final operatorsByCountry = <String, List<NetworkOperatorModel>>{};
      for (final operator in operators) {
        operatorsByCountry
            .putIfAbsent(operator.countryName, () => [])
            .add(operator);
      }

      final sortedCountries = operatorsByCountry.keys.toList()
        ..sort((a, b) => operatorsByCountry[b]!.length.compareTo(operatorsByCountry[a]!.length));
      final sortedOperatorsByCountry = <String, List<NetworkOperatorModel>>{};
      for (final country in sortedCountries) {
        sortedOperatorsByCountry[country] = operatorsByCountry[country]!;
      }

      final Map<String, double> pricePerGbByCountry = {};
      for (final country in sortedOperatorsByCountry.keys) {
        final countryOperators = sortedOperatorsByCountry[country]!;

        final avgDataRate =
            countryOperators
                .map((e) => e.dataRate)
                .fold<double>(0, (sum, rate) => sum + rate) /
            countryOperators.length;

        pricePerGbByCountry[country] = avgDataRate * 1024;
      }

      if (kDebugMode) {
        print(
          'TariffsBloc: Grouped operators by ${sortedOperatorsByCountry.length} countries',
        );
      }

      emit(
        TariffsLoaded(
          operators: operators,
          filteredOperators: operators,
          operatorsByCountry: sortedOperatorsByCountry,
          pricePerGbByCountry: pricePerGbByCountry,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('TariffsBloc: Error loading operators - $e');
      }
      emit(TariffsError('Failed to load tariffs: $e'));
    }
  }

  void _onFilterByCountry(
    FilterTariffsByCountryEvent event,
    Emitter<TariffsState> emit,
  ) {
    if (state is TariffsLoaded) {
      final currentState = state as TariffsLoaded;
      final filtered =
          currentState.operators
              .where((op) => op.countryName == event.countryName)
              .toList();

      emit(
        currentState.copyWith(
          filteredOperators: filtered,
          currentFilter: event.countryName,
          pricePerGbByCountry: currentState.pricePerGbByCountry,
        ),
      );
    }
  }

  void _onSearchTariffs(SearchTariffsEvent event, Emitter<TariffsState> emit) {
    if (state is TariffsLoaded) {
      final currentState = state as TariffsLoaded;
      final query = event.query.toLowerCase();

      final filtered =
          currentState.operators
              .where(
                (op) =>
                    op.countryName.toLowerCase().contains(query) ||
                    op.networkName.toLowerCase().contains(query),
              )
              .toList();

      emit(
        currentState.copyWith(
          filteredOperators: filtered,
          searchQuery: event.query,
          currentFilter: null,
          pricePerGbByCountry: currentState.pricePerGbByCountry,
        ),
      );
    }
  }
}
