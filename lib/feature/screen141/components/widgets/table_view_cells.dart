import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/screen141/components/widgets/custom_list_tile.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class TableViewCells extends StatelessWidget {
  const TableViewCells({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      CustomListTile(
        imagePath: 'assets/icons/figma141/table_view_icon1.svg',
        listText: AppLocalization.tariffsByCountries,
        onTap:() {
          openTariffsAndCountriesPage(context);
        },
      ),
      CustomListTile(
        imagePath: 'assets/icons/figma141/table_view_icon2.svg',
        listText: AppLocalization.guideForEsimSettings,
        onTap: () {
          openSettingsEsimPage(context);
        },
      ),
      CustomListTile(
        imagePath: 'assets/icons/figma141/table_view_icon3.svg',
        listText: AppLocalization.smthMore,
        onTap: () {
          // JUST FOR TESTING PAGE 112 !
          openEsimSetupPage(context);
        },        
      ),
      CustomListTile(
        imagePath: 'assets/icons/figma141/table_view_icon4.svg',
        listText: AppLocalization.supportChat2,
      ),
    ];

    final List<Widget> children = [];
    
    for (int i = 0; i < tiles.length; i++) {
      children.add(tiles[i]);
      children.add(const Divider(indent: 45, height: 1, thickness: 1));
    }   
    
    return Column(
      children: children,
    );

  }
}
