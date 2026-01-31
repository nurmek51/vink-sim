import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/core/services/token_manager.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_event.dart';
import 'package:vink_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:vink_sim/shared/widgets/app_notifier.dart';
import 'package:vink_sim/shared/widgets/blue_gradient_button.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopUpBalanceWidget extends StatelessWidget {
  final String? imsi;
  final bool isNewEsim;
  const TopUpBalanceWidget({super.key, this.imsi, this.isNewEsim = false});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: _handlePaymentStateChange,
      builder: (context, paymentState) {
        final isLoading = paymentState is PaymentLoading;
        return BlueGradientButton(
          title:
              isLoading
                  ? SimLocalizations.of(context)!.loading
                  : SimLocalizations.of(context)!.top_up_balance,
          onTap: isLoading ? null : () => _handleTopUpTap(context),
        );
      },
    );
  }

  void _handlePaymentStateChange(BuildContext context, PaymentState state) {
    if (state is PaymentSuccess) {
      if (kDebugMode) {
        print('PaymentBloc: PaymentSuccess - Payment completed!');
      }

      // Show success message
      AppNotifier.info(
        SimLocalizations.of(context)!.success_message,
      ).showAppToast(context);

      // Trigger refresh
      _refreshSubscriberData();

      // Small delay before navigating to let the user see the success message
      // and allow the refresh event to be processed by the bloc
      Future.delayed(const Duration(milliseconds: 800), () {
        if (context.mounted) {
          if (imsi != null) {
            NavigationService.goToMainFlow(context);
          } else {
            NavigationService.openActivatedEsimScreen(context);
          }
        }
      });
    } else if (state is PaymentFailure) {
      AppNotifier.error(
        SimLocalizations.of(context)!.payment_fail,
      ).showAppToast(context);
    } else if (state is PaymentNotImplemented) {
      AppNotifier.info(state.message).showAppToast(context);
    }
  }

  void _refreshSubscriberData() async {
    try {
      // Use TokenManager which works in both shell and standalone modes
      final tokenManager = sl.get<TokenManager>();
      final isAuthenticated = await tokenManager.isTokenValid();

      if (isAuthenticated) {
        // Use LoadSubscriberInfoEvent which emits Loading state to ensure UI updates
        // and we use sl.get to be independent of BuildContext during navigation
        sl.get<SubscriberBloc>().add(const LoadSubscriberInfoEvent());

        if (kDebugMode) {
          print(
            'TopUpBalanceWidget: Subscriber info reload triggered after payment',
          );
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error refreshing subscriber data: $e');
    }
  }

  void _handleTopUpTap(BuildContext context) {
    final bloc = context.read<TopUpBalanceBloc>();
    final state = bloc.state;

    if (!_validateTopUpForm(context, state)) return;
    _processPayment(context, state);
  }

  bool _validateTopUpForm(BuildContext context, TopUpBalanceState state) {
    if (state.amount <= 0) {
      AppNotifier.info(
        SimLocalizations.of(context)!.enter_top_up_amount,
      ).showAppToast(context);
      return false;
    }

    final bool isTopUp = !isNewEsim;

    if (!isTopUp && state.amount < 5) {
      AppNotifier.info(
        "Minimum amount for new eSIM is \$5",
      ).showAppToast(context);
      return false;
    }

    if (isTopUp && state.amount < 1) {
      AppNotifier.info("Minimum top-up amount is \$1").showAppToast(context);
      return false;
    }

    if (state.selectedPaymentMethod.isEmpty) {
      AppNotifier.info("Please select a payment method").showAppToast(context);
      return false;
    }

    return true;
  }

  void _processPayment(BuildContext context, TopUpBalanceState state) {
    final bool isTopUp = !isNewEsim;
    final String? selectedImsi = state.selectedSimCard?.imsi ?? imsi;

    final operationType =
        isTopUp ? PaymentOperationType.addFunds : PaymentOperationType.newImsi;

    switch (state.selectedPaymentMethod) {
      case 'credit_card':
        context.read<PaymentBloc>().add(
          PaymentRequested(
            amount: state.amount,
            context: context,
            operationType: operationType,
            imsi: isTopUp ? selectedImsi : null,
          ),
        );
        break;
      case 'crypto':
        AppNotifier.info(
          SimLocalizations.of(context)!.not_available,
        ).showAppToast(context);
        break;
      case 'apple_pay':
        context.read<PaymentBloc>().add(
          ApplePayRequested(
            amount: state.amount,
            context: context,
            operationType: operationType,
            imsi: isTopUp ? selectedImsi : null,
          ),
        );
        break;
      case 'google_pay':
        context.read<PaymentBloc>().add(
          GooglePayRequested(
            amount: state.amount,
            context: context,
            operationType: operationType,
            imsi: isTopUp ? selectedImsi : null,
          ),
        );
        break;
      default:
        AppNotifier.info("Unknown payment method").showAppToast(context);
    }
  }
}
