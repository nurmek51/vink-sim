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