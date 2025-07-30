import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/features/dashboard/bloc/main_flow_bloc.dart';
import 'package:flex_travel_sim/features/stripe_payment/presentation/bloc/stripe_bloc.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/features/stripe_payment/utils/stripe_web.dart';

class StripeWebCheckout extends StatelessWidget {
  final String clientSecret;
  final int amount;
  final int? circleIndex;
  const StripeWebCheckout({
    super.key,
    required this.clientSecret,
    this.circleIndex,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColorLight,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: PaymentElement(
              clientSecret: clientSecret,
              enablePostalCode: true,
              autofocus: true,
              onCardChanged: (_) {},
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 12,              
              left: 40,
              right: 40,
            ),
            child: BlocConsumer<StripeBloc, StripeState>(
              listener: (contenxt, state) {
                if (state is StripeSuccess) {
                  if (circleIndex != null) {
                    context.read<MainFlowBloc>().add(
                      UpdateCircleBalanceEvent(
                        circleIndex: circleIndex!,
                        addedAmount: amount.toDouble(),
                      ),
                    );
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  } else {
                    NavigationService.openActivatedEsimScreen(context);
                  }
                }
                if (state is StripeCancelled) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Пользователь отменил')),
                  );
                }
                if (state is StripeFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ошибка оплаты: ${state.error}')),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is StripeLoading;
                final returnUrl = 'http://localhost:62204/#/main-flow';
                return BlueGradientButton(
                  title: isLoading ? 'Проверка...' : 'Оплатить $amount\$',
                  onTap:
                      isLoading
                          ? null
                          : () {
                            context.read<StripeBloc>().add(
                              WebPaymentConfirmed(
                                clientSecret: clientSecret,
                                returnUrl: returnUrl,
                              ),
                            );
                          },
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}