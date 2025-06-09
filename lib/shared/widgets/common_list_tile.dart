import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonListTile extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String? subtitle;
  final String? trailingText;
  final Widget? trailingWidget;
  final VoidCallback? onTap;
  final Color titleColor;
  final Color? subtitleColor;
  final Color? trailingColor;
  final double titleFontSize;
  final double? subtitleFontSize;
  final double? trailingFontSize;
  final EdgeInsetsGeometry contentPadding;
  final double? imageWidth;
  final double? imageHeight;
  final VisualDensity? visualDensity;

  const CommonListTile({
    super.key,
    this.imagePath,
    required this.title,
    this.subtitle,
    this.trailingText,
    this.trailingWidget,
    this.onTap,
    this.titleColor = const Color(0xFF363C45),
    this.subtitleColor = Colors.grey,
    this.trailingColor = Colors.grey,
    this.titleFontSize = 15,
    this.subtitleFontSize = 15,
    this.trailingFontSize = 15,
    this.contentPadding = EdgeInsets.zero,
    this.imageWidth = 32,
    this.imageHeight = 32,
    this.visualDensity,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: contentPadding,
      visualDensity: visualDensity,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      leading: imagePath != null
          ? _buildLeadingIcon()
          : null,
      title: HelveticaneueFont(
        text: title,
        fontSize: titleFontSize,
        color: titleColor,
      ),
      subtitle: subtitle != null
          ? HelveticaneueFont(
              text: subtitle!,
              fontSize: subtitleFontSize ?? 15,
              color: subtitleColor ?? Colors.grey,
            )
          : null,
      trailing: _buildTrailing(),
    );
  }

  Widget? _buildLeadingIcon() {
    if (imagePath == null) return null;
    
    return SvgPicture.asset(
      imagePath!,
      width: imageWidth,
      height: imageHeight,
      fit: BoxFit.contain,
    );
  }

  Widget? _buildTrailing() {
    if (trailingWidget != null) return trailingWidget;
    if (trailingText != null) {
      return HelveticaneueFont(
        text: trailingText!,
        fontSize: trailingFontSize ?? 15,
        height: 0.22,
        color: trailingColor ?? Colors.grey,
      );
    }
    return null;
  }
}
