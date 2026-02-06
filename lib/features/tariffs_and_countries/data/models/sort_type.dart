enum CountrySortType {
  byOperatorCount,
  byPopularity,
  byMinPrice,
  byAlphabetical,
}

extension CountrySortTypeExtension on CountrySortType {
  static const popularCountries = [
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

  String get displayName {
    switch (this) {
      case CountrySortType.byOperatorCount:
        return 'By operators count';
      case CountrySortType.byPopularity:
        return 'Popular destinations';
      case CountrySortType.byMinPrice:
        return 'By price (low to high)';
      case CountrySortType.byAlphabetical:
        return 'Alphabetical';
    }
  }
}
