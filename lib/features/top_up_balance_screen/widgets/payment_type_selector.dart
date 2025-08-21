import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/platform_device/platform_detector.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/coming_soon_modal.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentTypeSelector extends StatelessWidget {
  const PaymentTypeSelector({super.key});

  static List<Map<String, dynamic>> get paymentMethods {
    List<Map<String, dynamic>> methods = [
      {'logo': 'credCard', 'method': 'credit_card', 'enabled': true},
    ];

    if (PlatformDetector.isIos) {
      methods.insert(0, {
        'logo': 'apple_pay_logo',
        'method': 'apple_pay',
        'enabled': true,
      });
    } else if (PlatformDetector.isAndroid) {
      methods.insert(0, {
        'logo': 'google_pay_logo',
        'method': 'google_pay',
        'enabled': true,
      });
    }

    methods.add({'logo': 'crypto', 'method': 'crypto', 'enabled': false});

    return methods;
  }

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
              enabled: payment['enabled'] ?? true,
              onTap: () {
                if (payment['enabled'] == false) {
                  ComingSoonModal.show(context, payment['method']!);
                } else {
                  context.read<TopUpBalanceBloc>().add(
                    SelectPaymentMethod(payment['method']!),
                  );
                }
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
  final bool enabled;
  final VoidCallback onTap;

  const PaymentTypeWidget({
    super.key,
    required this.logo,
    required this.isSelected,
    required this.onTap,
    this.enabled = true,
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
                color: isSelected ? Colors.black : AppColors.containerGray,
                borderRadius: BorderRadius.circular(16),
                // border: Border.all(color: Color(0xFFD4D4D4), width: 1),
              ),
              child: _getSvgAsset(logo, isSelected),
            ),
            if (isSelected)
              Positioned(
                top: -6,
                right: -1,
                child: Assets.icons.selectedCardIcon.svg(),
              ),
            if (!enabled)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange.shade400, Colors.orange.shade600],
                    ),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.3),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    'SOON',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
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
                  : const ColorFilter.mode(
                    AppColors.lightSteelBlue,
                    BlendMode.srcIn,
                  ),
        );
      case 'google_pay_logo':
        return Assets.icons.googleLogo.svg(
          colorFilter:
              isSelected
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : const ColorFilter.mode(
                    AppColors.lightSteelBlue,
                    BlendMode.srcIn,
                  ),
        );
      case 'crypto':
        return Assets.icons.crypto.svg(
          colorFilter:
              isSelected
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : const ColorFilter.mode(
                    AppColors.lightSteelBlue,
                    BlendMode.srcIn,
                  ),
        );
      case 'credCard':
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : AppColors.lightSteelBlue,
            BlendMode.srcIn,
          ),
          child: Assets.icons.credCard.svg(),
        );
      default:
        return Container();
    }
  }
}
