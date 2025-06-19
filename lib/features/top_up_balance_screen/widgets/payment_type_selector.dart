import 'package:flex_travel_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentTypeSelector extends StatelessWidget {
  const PaymentTypeSelector({super.key});

  static const List<Map<String, String>> paymentMethods = [
    {'logo': 'apple_pay_logo', 'method': 'apple_pay'},
    {'logo': 'crypto', 'method': 'crypto'},
    {'logo': 'credCard', 'method': 'credit_card'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
      builder: (context, state) {
        return Row(
          children: List.generate(paymentMethods.length, (index) {
            final payment = paymentMethods[index];
            final isSelected =
                state.selectedPaymentMethod == payment['method'] ||
                (state.selectedPaymentMethod.isEmpty && index == 0);

            return PaymentTypeWidget(
              logo: payment['logo']!,
              isSelected: isSelected,
              onTap: () {
                context.read<TopUpBalanceBloc>().add(
                  SelectPaymentMethod(payment['method']!),
                );
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
              child: _getSvgAsset(logo, isSelected),
            ),
            if (isSelected)
              Positioned(
                top: -6,
                right: -1,
                child: Assets.icons.selectedCardIcon.svg(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _getSvgAsset(String assetName, bool isSelected) {
    switch (assetName) {
      case 'apple_pay_logo':
        return Assets.icons.applePayLogo.svg(
          colorFilter:
              isSelected
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        );
      case 'crypto':
        return Assets.icons.crypto.svg(
          colorFilter:
              isSelected
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        );
      case 'credCard':
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : Colors.black54,
            BlendMode.srcIn,
          ),
          child: Assets.icons.credCard.svg(),
        );
      default:
        return Container();
    }
  }
}
