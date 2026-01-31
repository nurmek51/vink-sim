import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String imagePath;
  final String listText;
  final VoidCallback? onTap;
  final Color containerColor;

  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.listText,
    this.onTap,
    required this.containerColor,
    
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,  
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,          
      leading: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: containerColor,
        ),
        child: Center(
          child: _getIconByPath(imagePath),
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Assets.icons.figma141.tableViewArrow.svg(
          width: 7.16,
          height: 12.3,
        ),
      ),      
      title: HelveticaneueFont(
        text: listText,
        fontSize: 16,
        color: Color(0xFF363C45),
      ),
    );
  }

  Widget _getIconByPath(String path) {
    switch (path) {
      case 'guide_table_view1':
        return Assets.icons.guideTableView1.svg(
          width: 20,
          height: 20,
          fit: BoxFit.contain,
        );
      case 'guide_table_view2':
        return Assets.icons.guideTableView2.svg(
          width: 20,
          height: 20,
          fit: BoxFit.contain,
        );
      case 'guide_table_view3':
        return Assets.icons.guideTableView3.svg(
          width: 20,
          height: 20,
          fit: BoxFit.contain,
        );
      case 'guide_table_view4':
        return Assets.icons.guideTableView4.svg(
          width: 20,
          height: 20,
          fit: BoxFit.contain,
        );
      default:
        return Assets.icons.guideTableView1.svg(
          width: 20,
          height: 20,
          fit: BoxFit.contain,
        );
    }
  }
}
