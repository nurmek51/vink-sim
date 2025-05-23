import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/main_flow_screen/bottom_sheet_content.dart';
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
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder:
                (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: BottomSheetContent(),
                  ),
                ),
          );
        }
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
