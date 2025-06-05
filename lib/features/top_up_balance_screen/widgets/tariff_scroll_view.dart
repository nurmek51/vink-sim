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
          ScrollContainer(sum: 1, country: 'в Европе'),
          SizedBox(width: 8),
          ScrollContainer(sum: 2, country: 'в Дубаях'),
          SizedBox(width: 8),
          ScrollContainer(sum: 3, country: 'в Гдето там еще'),
          SizedBox(width: 8),
          ScrollContainer(sum: 4, country: 'ES'),
        ],
      ),
    );
  }
}
