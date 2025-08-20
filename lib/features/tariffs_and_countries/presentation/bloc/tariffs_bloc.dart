import 'package:bloc/bloc.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/data/data_sources/tariffs_remote_data_source.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/data/models/network_operator_model.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/data/models/sort_type.dart';
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

      final sortedOperatorsByCountry = _sortOperatorsByCountry(
        operatorsByCountry,
        CountrySortType.byPopularity,
        {},
      );

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

      final cheapestPricesByCountry = _getCheapestPricesByCountryOrdered(
        operators,
      );

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
      final filtered =
          currentState.operators
              .where((op) => op.countryName == event.countryName)
              .toList();

      emit(
        currentState.copyWith(
          filteredOperators: filtered,
          currentFilter: event.countryName,
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
        ),
      );
    }
  }

  Map<String, double> _getCheapestPricesByCountryOrdered(
    List<NetworkOperatorModel> operators,
  ) {
    final countryOrder = [
      'Turkey',
      'United Arab Emirates',
      'France',
      'Armenia',
      'Thailand',
      'Georgia',
      'United States',
      'Egypt',
      'Kazakhstan',
      'Cyprus',
    ];

    final Map<String, double> cheapestByCountry = {};
    for (final operator in operators) {
      final country = operator.countryName;
      final currentCheapest = cheapestByCountry[country];
      if (currentCheapest == null || operator.dataRate < currentCheapest) {
        cheapestByCountry[country] = operator.dataRate;
      }
    }

    final Map<String, double> orderedCheapest = {};
    for (final country in countryOrder) {
      if (cheapestByCountry.containsKey(country)) {
        orderedCheapest[country] = cheapestByCountry[country]! * 1024;
      }
    }

    return orderedCheapest;
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

  Map<String, List<NetworkOperatorModel>> _sortOperatorsByCountry(
    Map<String, List<NetworkOperatorModel>> operatorsByCountry,
    CountrySortType sortType,
    Map<String, double> cheapestPrices,
  ) {
    final countries = operatorsByCountry.keys.toList();

    switch (sortType) {
      case CountrySortType.byOperatorCount:
        countries.sort((a, b) => 
          operatorsByCountry[b]!.length.compareTo(operatorsByCountry[a]!.length));
        break;

      case CountrySortType.byPopularity:
        final popularOrder = [
          'Turkey',
          'United Arab Emirates', 
          'France',
          'Armenia',
          'Thailand',
          'Georgia',
          'United States',
          'Egypt',
          'Kazakhstan',
          'Cyprus',
        ];
        
        countries.sort((a, b) {
          final indexA = popularOrder.indexOf(a);
          final indexB = popularOrder.indexOf(b);
          
          if (indexA == -1 && indexB == -1) {
            return operatorsByCountry[b]!.length.compareTo(operatorsByCountry[a]!.length);
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

    final sortedMap = <String, List<NetworkOperatorModel>>{};
    for (final country in countries) {
      sortedMap[country] = operatorsByCountry[country]!;
    }

    return sortedMap;
  }
}
