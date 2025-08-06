import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/scroll_container.dart';
import 'package:flutter/material.dart';

class TariffScrollView extends StatelessWidget {
  const TariffScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ScrollContainer(sum: 10.7, country: AppLocalizations.inEurope),
          SizedBox(width: 8),
          ScrollContainer(sum: 12.6, country: AppLocalizations.inDubai),
          SizedBox(width: 8),
          ScrollContainer(sum: 7.6, country: AppLocalizations.inAsia),
        ],
      ),
    );
  }
}
