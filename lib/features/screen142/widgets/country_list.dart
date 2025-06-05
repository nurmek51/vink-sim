import 'package:flex_travel_sim/features/screen142/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      CustomListTile(
        imagePath: 'assets/icons/figma142/japan.svg',
        countryTitle: 'Japan',
        countrySubtitle: 'Vodafone LTE, Optus 5G',
        price: '\$3 / 1GB'
      ),
    ];

    final List<Widget> children = [];
    
    for (int i = 0; i < 10; i++) {
      children.add(tiles[0]);
      children.add(const Divider(indent: 45, height: 1, thickness: 1));
    }   
    
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      children: children,
    );

  }
}
