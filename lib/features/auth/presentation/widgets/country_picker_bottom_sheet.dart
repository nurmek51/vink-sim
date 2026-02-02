import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/features/auth/domain/entities/country.dart';
import 'package:vink_sim/features/auth/data/country_data.dart';

class CountryPickerBottomSheet extends StatefulWidget {
  final Country selectedCountry;
  final Function(Country) onCountrySelected;

  const CountryPickerBottomSheet({
    super.key,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  State<CountryPickerBottomSheet> createState() =>
      _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<CountryPickerBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Country> _filteredCountries = CountryData.countries;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCountries);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    setState(() {
      _filteredCountries = CountryData.searchCountries(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: AppColors.backgroundColorDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocalizedText(
                  SimLocalizations.of(context)!.select_country,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.backgroundColorLight,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.backgroundColorLight,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x1AFFFFFF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x66FFFFFF), width: 1),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  color: AppColors.backgroundColorLight,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: SimLocalizations.of(context)!.search_countries,
                  hintStyle: TextStyle(color: Color(0x4DFFFFFF), fontSize: 16),
                  prefixIcon: Icon(Icons.search, color: Color(0x4DFFFFFF)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                cursorColor: AppColors.backgroundColorLight,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final isSelected = country == widget.selectedCountry;

                return ListTile(
                  leading: SizedBox(
                    width: 32,
                    height: 24,
                    child: CountryFlag.fromCountryCode(
                      country.code,
                      shape: const RoundedRectangle(4),
                    ),
                  ),
                  title: LocalizedText(
                    country.name,
                    style: TextStyle(
                      color: AppColors.backgroundColorLight,
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        country.dialCode,
                        style: TextStyle(
                          color: AppColors.backgroundColorLight,
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                      if (isSelected) const SizedBox(width: 8),
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          color: AppColors.accentBlue,
                          size: 20,
                        ),
                    ],
                  ),
                  onTap: () {
                    widget.onCountrySelected(country);
                    Navigator.of(context).pop();
                  },
                  tileColor: isSelected ? const Color(0x1A4CAF50) : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
