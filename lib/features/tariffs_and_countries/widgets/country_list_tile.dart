import 'package:country_flags/country_flags.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';

class CountryListTile extends StatelessWidget {
  final String countryTitle;
  final String countrySubtitle;
  final VoidCallback? onTap;
  final String price;
  final String? countryCode;

  const CountryListTile({
    super.key,
    this.onTap,
    required this.countryTitle,
    required this.countrySubtitle,
    required this.price,
    this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      leading:
          countryCode != null
              ? SizedBox(
                width: 32,
                height: 32,
                child: CountryFlag.fromCountryCode(
                  countryCode!,
                  shape: const Circle(),
                ),
              )
              : const SizedBox(width: 32, height: 32),
      title: HelveticaneueFont(
        text: countryTitle,
        fontSize: 15,
        color: const Color(0xFF363C45),
      ),
      subtitle: HelveticaneueFont(
        text: countrySubtitle,
        fontSize: 15,
        color: Colors.grey,
      ),
      trailing: HelveticaneueFont(
        text: price,
        fontSize: 15,
        height: 0.22,
        color: Colors.grey,
      ),
    );
  }
}
