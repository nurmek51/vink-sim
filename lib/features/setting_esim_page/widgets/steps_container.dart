import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StepsContainer extends StatelessWidget {
  final String description;
  final String iconPath;
  final List<String>? args;

  const StepsContainer({
    super.key,
    required this.description,
    required this.iconPath,
    this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: ListTile(
            leading: SvgPicture.asset(
              iconPath,
              package: AssetUtils.package,
              width: 50,
              height: 50,
            ),
            title: HelveticaneueFont(
              text: SimLocalizations.of(context)!.step_number(args![0]),
              fontSize: 15,
              height: 1.3,
              color: Color(0xFF363C45),
              fontWeight: FontWeight.bold,
            ),
            subtitle: HelveticaneueFont(
              text: description,
              fontSize: 15,
              height: 1.3,
              color: Color(0xFF363C45),
            ),
          ),
        ),
      ),
    );
  }
}
