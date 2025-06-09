import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/main_flow_screen/bottom_sheet_content.dart';
import 'package:flex_travel_sim/features/guide_page/components/widgets/custom_list_tile.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class TableViewCells extends StatelessWidget {
  const TableViewCells({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      CustomListTile(
        imagePath: Assets.icons.GuideTableView1.path,
        containerColor: AppColors.guideTable1,
        listText: AppLocalization.tariffsByCountries,
        onTap:() {
          openTariffsAndCountriesPage(context);
        },
      ),
      CustomListTile(
        imagePath: Assets.icons.GuideTableView2.path,
        containerColor: AppColors.guideTable2,
        listText: AppLocalization.guideForEsimSettings,
        onTap: () {
          openSettingsEsimPage(context);
        },
      ),
      CustomListTile(
        imagePath: Assets.icons.GuideTableView3.path,
        containerColor: AppColors.guideTable3,
        listText: AppLocalization.smthMore,
        onTap: () {
          // JUST FOR TESTING PAGE 112 !
          openEsimSetupPage(context);
        },        
      ),
      CustomListTile(
        imagePath: Assets.icons.GuideTableView4.path,
        containerColor: AppColors.guideTable4,
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
