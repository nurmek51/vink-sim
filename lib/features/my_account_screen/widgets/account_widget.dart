import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountWidget extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onTap;
  const AccountWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,      
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontSize: 20)),
                    // const Spacer(),
                    const Icon(Icons.arrow_forward_ios, color: Colors.black26),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.black26),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
