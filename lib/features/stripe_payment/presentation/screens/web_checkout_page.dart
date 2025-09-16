import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/stripe_payment/presentation/bloc/stripe_bloc.dart';
import 'package:flex_travel_sim/features/stripe_payment/services/stripe_service.dart';
import 'package:flex_travel_sim/shared/widgets/app_notifier.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/features/stripe_payment/utils/stripe_web.dart';

class StripeWebCheckout extends StatelessWidget {
  final String clientSecret;
  final int amount;
  final StripeOperationType operationType;
  final String? imsi;

  const StripeWebCheckout({
    super.key,
    required this.clientSecret,
    required this.amount,
    required this.operationType,
    this.imsi,
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
              listener: (context, state) {
                if (state is StripeSuccess) {
                  if (imsi != null) {
                    NavigationService.goToMainFlow(context);
                  } else {
                    NavigationService.openActivatedEsimScreen(context);
                  }
                }
                if (state is StripeFailure) {
                  AppNotifier.error(AppLocalizations.paymentFail).showAppToast(context);
                }
              },
              builder: (context, state) {
                final isLoading = state is StripeLoading;
                final returnUrl = 'http://localhost:62204/#/main-flow';
                return BlueGradientButton(
                  title: isLoading ? AppLocalizations.loading : AppLocalizations.payMoney,
                  args: isLoading ? null : [amount.toString()],
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