import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:flutter/material.dart';

class ManualSelectedBody extends StatelessWidget {
  const ManualSelectedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyContainer(
          stepNum: '1',
          description: AppLocalization.manualDescription1,
          child: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text('Manual setup content'),
          ),
        ),
      ],
    );
  }
}
