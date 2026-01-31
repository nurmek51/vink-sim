import 'package:vink_sim/features/tariffs_and_countries/data/models/sort_type.dart';

abstract class TariffsEvent {
  const TariffsEvent();
}

class LoadTariffsEvent extends TariffsEvent {
  const LoadTariffsEvent();
}

class RefreshTariffsEvent extends TariffsEvent {
  const RefreshTariffsEvent();
}

class FilterTariffsByCountryEvent extends TariffsEvent {
  final String countryName;
  
  const FilterTariffsByCountryEvent(this.countryName);
}

class SearchTariffsEvent extends TariffsEvent {
  final String query;
  
  const SearchTariffsEvent(this.query);
}

class SortTariffsEvent extends TariffsEvent {
  final CountrySortType sortType;
  
  const SortTariffsEvent(this.sortType);
}