import 'package:vink_sim/features/tariffs_and_countries/domain/entities/tariff.dart';
import 'package:vink_sim/features/tariffs_and_countries/data/models/sort_type.dart';

abstract class TariffsState {
  const TariffsState();
}

class TariffsInitial extends TariffsState {
  const TariffsInitial();
}

class TariffsLoading extends TariffsState {
  const TariffsLoading();
}

class TariffsLoaded extends TariffsState {
  final List<Tariff> operators;
  final List<Tariff> filteredOperators;
  final Map<String, List<Tariff>> operatorsByCountry;
  final String? currentFilter;
  final String? searchQuery;
  final Map<String, double> pricePerGbByCountry;
  final Map<String, double> cheapestPricesByCountryOrdered;
  final CountrySortType currentSortType;

  const TariffsLoaded({
    required this.operators,
    required this.filteredOperators,
    required this.operatorsByCountry,
    this.currentFilter,
    this.searchQuery,
    this.pricePerGbByCountry = const {},
    this.cheapestPricesByCountryOrdered = const {},
    this.currentSortType = CountrySortType.byPopularity,
  });

  TariffsLoaded copyWith({
    List<Tariff>? operators,
    List<Tariff>? filteredOperators,
    Map<String, List<Tariff>>? operatorsByCountry,
    String? currentFilter,
    String? searchQuery,
    Map<String, double>? pricePerGbByCountry,
    Map<String, double>? cheapestPricesByCountryOrdered,
    CountrySortType? currentSortType,
  }) {
    return TariffsLoaded(
      operators: operators ?? this.operators,
      filteredOperators: filteredOperators ?? this.filteredOperators,
      operatorsByCountry: operatorsByCountry ?? this.operatorsByCountry,
      currentFilter: currentFilter ?? this.currentFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      pricePerGbByCountry: pricePerGbByCountry ?? this.pricePerGbByCountry,
      cheapestPricesByCountryOrdered:
          cheapestPricesByCountryOrdered ?? this.cheapestPricesByCountryOrdered,
      currentSortType: currentSortType ?? this.currentSortType,
    );
  }
}

class TariffsError extends TariffsState {
  final String message;

  const TariffsError(this.message);
}
