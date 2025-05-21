import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomListTile extends StatelessWidget {
  final String imagePath;
  final String countryTitle;
  final String countrySubtitle;
  final VoidCallback? onTap;
  final String price;

  const CustomListTile({
    super.key,
    required this.imagePath,
    this.onTap,
    required this.countryTitle,
    required this.countrySubtitle,
    required this.price,
    
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
        width: 32,
        height: 32,
      ),     
      title: HelveticaneueFont(
        text: countryTitle,
        fontSize: 15,
        color: Color(0xFF363C45),
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
