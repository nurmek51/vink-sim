import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomListTile extends StatelessWidget {
  final String tileText;
  final String iconPath;

  const CustomListTile({
    super.key,
    required this.tileText,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(vertical: -4),
      leading: SizedBox(
        width: 20,
        child: Align(
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: HelveticaneueFont(
        text: tileText,
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }
}