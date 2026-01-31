import 'package:vink_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/fix_sum_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FixSumButtonWidget extends StatelessWidget {
  const FixSumButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
      builder: (context, state) {
        return Row(
          children:
              [5, 10, 15, 50, 100]
                  .map(
                    (sum) => FixSumButton(
                      sum: sum,
                      isSelected: state.amount == sum,
                      onTap:
                          (value) => context.read<TopUpBalanceBloc>().add(
                            SetAmount(value),
                          ),
                    ),
                  )
                  .toList(),
        );
      },
    );
  }
}
