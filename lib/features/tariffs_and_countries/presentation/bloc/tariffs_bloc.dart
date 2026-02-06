import 'package:bloc/bloc.dart';
import 'package:vink_sim/features/tariffs_and_countries/data/data_sources/tariffs_remote_data_source.dart';
import 'package:vink_sim/features/tariffs_and_countries/domain/entities/tariff.dart';
import 'package:vink_sim/features/tariffs_and_countries/data/models/sort_type.dart';
import 'package:vink_sim/features/tariffs_and_countries/presentation/bloc/tariffs_event.dart';
import 'package:vink_sim/features/tariffs_and_countries/presentation/bloc/tariffs_state.dart';
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
    on<SortTariffsEvent>(_onSortTariffs);
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

      final operators = await _dataSource.getTariffs();

      if (kDebugMode) {
        print('TariffsBloc: Loaded ${operators.length} operators');
      }

      final cheapestPricesByCountry = _getCheapestPricesByCountryOrdered(
        operators,
      );

      final operatorsByCountry = <String, List<Tariff>>{};
      for (final operator in operators) {
        operatorsByCountry
            .putIfAbsent(operator.countryName, () => [])
            .add(operator);
      }

      final sortedOperatorsByCountry = _sortOperatorsByCountry(
        operatorsByCountry,
        CountrySortType.byPopularity,
        cheapestPricesByCountry,
      );

      final Map<String, double> pricePerGbByCountry = {};
      for (final country in sortedOperatorsByCountry.keys) {
        final countryOperators = sortedOperatorsByCountry[country]!;

        final avgDataRate = countryOperators
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
          cheapestPricesByCountryOrdered: cheapestPricesByCountry,
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
      final filtered = currentState.operators
          .where((op) => op.countryName == event.countryName)
          .toList();

      final grouped = <String, List<Tariff>>{};
      for (final op in filtered) {
        grouped.putIfAbsent(op.countryName, () => []).add(op);
      }

      final sortedGrouped = _sortOperatorsByCountry(
        grouped,
        currentState.currentSortType,
        currentState.cheapestPricesByCountryOrdered,
      );

      emit(
        currentState.copyWith(
          filteredOperators: filtered,
          operatorsByCountry: sortedGrouped,
          currentFilter: event.countryName,
        ),
      );
    }
  }

  void _onSearchTariffs(SearchTariffsEvent event, Emitter<TariffsState> emit) {
    if (state is TariffsLoaded) {
      final currentState = state as TariffsLoaded;
      final query = event.query.toLowerCase();

      final filtered = currentState.operators
          .where(
            (op) =>
                op.countryName.toLowerCase().contains(query) ||
                op.networkName.toLowerCase().contains(query),
          )
          .toList();

      final grouped = <String, List<Tariff>>{};
      for (final op in filtered) {
        grouped.putIfAbsent(op.countryName, () => []).add(op);
      }

      final sortedGrouped = _sortOperatorsByCountry(
        grouped,
        currentState.currentSortType,
        currentState.cheapestPricesByCountryOrdered,
      );

      emit(
        currentState.copyWith(
          filteredOperators: filtered,
          operatorsByCountry: sortedGrouped,
          searchQuery: event.query,
          currentFilter: null,
        ),
      );
    }
  }

  Map<String, double> _getCheapestPricesByCountryOrdered(
    List<Tariff> operators,
  ) {
    final Map<String, double> cheapestByCountry = {};
    for (final operator in operators) {
      final country = operator.countryName;
      final currentCheapest = cheapestByCountry[country];
      if (currentCheapest == null || operator.dataRate < currentCheapest) {
        cheapestByCountry[country] = operator.dataRate;
      }
    }

    return cheapestByCountry.map(
      (key, value) => MapEntry(key, value * 1024),
    );
  }

  void _onSortTariffs(SortTariffsEvent event, Emitter<TariffsState> emit) {
    if (state is TariffsLoaded) {
      final currentState = state as TariffsLoaded;

      final sortedOperatorsByCountry = _sortOperatorsByCountry(
        currentState.operatorsByCountry,
        event.sortType,
        currentState.cheapestPricesByCountryOrdered,
      );

      emit(
        currentState.copyWith(
          operatorsByCountry: sortedOperatorsByCountry,
          currentSortType: event.sortType,
        ),
      );
    }
  }

  Map<String, List<Tariff>> _sortOperatorsByCountry(
    Map<String, List<Tariff>> operatorsByCountry,
    CountrySortType sortType,
    Map<String, double> cheapestPrices,
  ) {
    final countries = operatorsByCountry.keys.toList();

    switch (sortType) {
      case CountrySortType.byOperatorCount:
        countries.sort(
          (a, b) => operatorsByCountry[b]!.length.compareTo(
                operatorsByCountry[a]!.length,
              ),
        );
        break;

      case CountrySortType.byPopularity:
        final popularOrder = CountrySortTypeExtension.popularCountries;

        countries.sort((a, b) {
          final indexA = popularOrder.indexOf(a);
          final indexB = popularOrder.indexOf(b);

          if (indexA == -1 && indexB == -1) {
            return operatorsByCountry[b]!.length.compareTo(
                  operatorsByCountry[a]!.length,
                );
          }
          if (indexA == -1) return 1;
          if (indexB == -1) return -1;
          return indexA.compareTo(indexB);
        });
        break;

      case CountrySortType.byMinPrice:
        countries.sort((a, b) {
          final priceA = cheapestPrices[a] ?? double.infinity;
          final priceB = cheapestPrices[b] ?? double.infinity;
          return priceA.compareTo(priceB);
        });
        break;

      case CountrySortType.byAlphabetical:
        countries.sort();
        break;
    }

    final sortedMap = <String, List<Tariff>>{};
    for (final country in countries) {
      sortedMap[country] = operatorsByCountry[country]!;
    }

    return sortedMap;
  }
}
