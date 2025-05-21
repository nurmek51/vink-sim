import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomListTile extends StatelessWidget {
  final String imagePath;
  final String listText;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.listText,
    this.onTap,
    
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,  
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,          
      leading: SvgPicture.asset(
        imagePath,
        width: 30,
        height: 30,
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: SvgPicture.asset(
          'assets/icons/figma141/table_view_arrow.svg',
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
}
