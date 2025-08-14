import 'package:flex_travel_sim/features/tariffs_and_countries/data/models/network_operator_model.dart';

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
  final List<NetworkOperatorModel> operators;
  final List<NetworkOperatorModel> filteredOperators;
  final Map<String, List<NetworkOperatorModel>> operatorsByCountry;
  final String? currentFilter;
  final String? searchQuery;
  final Map<String, double> pricePerGbByCountry;
  final Map<String, double> cheapestPricesByCountryOrdered;

  const TariffsLoaded({
    required this.operators,
    required this.filteredOperators,
    required this.operatorsByCountry,
    this.currentFilter,
    this.searchQuery,
    this.pricePerGbByCountry = const {},
    this.cheapestPricesByCountryOrdered = const {},
  });

  TariffsLoaded copyWith({
    List<NetworkOperatorModel>? operators,
    List<NetworkOperatorModel>? filteredOperators,
    Map<String, List<NetworkOperatorModel>>? operatorsByCountry,
    String? currentFilter,
    String? searchQuery,
    Map<String, double>? pricePerGbByCountry,
    Map<String, double>? cheapestPricesByCountryOrdered,
  }) {
    return TariffsLoaded(
      operators: operators ?? this.operators,
      filteredOperators: filteredOperators ?? this.filteredOperators,
      operatorsByCountry: operatorsByCountry ?? this.operatorsByCountry,
      currentFilter: currentFilter ?? this.currentFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      pricePerGbByCountry: pricePerGbByCountry ?? this.pricePerGbByCountry,
      cheapestPricesByCountryOrdered: cheapestPricesByCountryOrdered ?? this.cheapestPricesByCountryOrdered,
    );
  }
}

class TariffsError extends TariffsState {
  final String message;

  const TariffsError(this.message);
} 