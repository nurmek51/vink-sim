import 'package:flex_travel_sim/features/top_up_balance_screen/cubit/top_up_balance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PaymentTypeSelector extends StatelessWidget {
  const PaymentTypeSelector({super.key});

  static const List<Map<String, String>> paymentMethods = [
    {'logo': 'assets/icons/apple_pay_logo.svg', 'method': 'apple_pay'},
    {'logo': 'assets/icons/crypto.svg', 'method': 'crypto'},
    {'logo': 'assets/icons/cred_card.svg', 'method': 'credit_card'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpBalanceCubit, TopUpBalanceState>(
      builder: (context, state) {
        return Row(
          children: List.generate(paymentMethods.length, (index) {
            final payment = paymentMethods[index];
            final isSelected = state.selectedPaymentMethod == payment['method'] ||
                (state.selectedPaymentMethod.isEmpty && index == 0);
            
            return PaymentTypeWidget(
              logo: payment['logo']!,
              isSelected: isSelected,
              onTap: () {
                context.read<TopUpBalanceCubit>().selectPaymentMethod(payment['method']!);
              },
            );
          }),
        );
      },
    );
  }
}

class PaymentTypeWidget extends StatelessWidget {
  final String logo;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentTypeWidget({
    super.key,
    required this.logo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              alignment: Alignment.center,
              height: 66,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFD4D4D4), width: 1),
              ),
              child: SvgPicture.asset(
                logo,
                color: isSelected ? Colors.white : Colors.black45,
              ),
            ),
            if (isSelected)
              Positioned(
                top: -6,
                right: -6,
                child: SvgPicture.asset('assets/icons/selected_card_icon.svg'),
              ),
          ],
        ),
      ),
    );
  }
}
