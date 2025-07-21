import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:flex_travel_sim/features/guide_page/components/widgets/custom_list_tile.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class TableViewCells extends StatelessWidget {
  final bool isAuthorized;

  const TableViewCells({
    super.key,
    this.isAuthorized = false,

  });

  @override
  Widget build(BuildContext context) {
    final tiles = [
      CustomListTile(
        imagePath: 'guide_table_view1',
        containerColor: AppColors.guideTable1,
        listText: AppLocalization.tariffsByCountries,
        onTap: () {
          NavigationService.openTariffsAndCountriesPage(context, isAuthorized: isAuthorized);
        },
      ),
      CustomListTile(
        imagePath: 'guide_table_view2',
        containerColor: AppColors.guideTable2,
        listText: AppLocalization.guideForEsimSettings,
        onTap: () {
          NavigationService.openSettingsEsimPage(context, isAuthorized: isAuthorized);
        },
      ),
      CustomListTile(
        imagePath: 'guide_table_view3',
        containerColor: AppColors.guideTable3,
        listText: AppLocalization.smthMore,
        onTap: () {
          openEsimSetupPage(context);
        },
      ),
      CustomListTile(
        imagePath: 'guide_table_view4',
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
        },
      ),
    ];

    final List<Widget> children = [];

    for (int i = 0; i < tiles.length; i++) {
      children.add(tiles[i]);
      children.add(const Divider(indent: 45, height: 1, thickness: 1));
    }

    return Column(children: children);
  }
}
