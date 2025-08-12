import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/stripe_payment/presentation/bloc/stripe_bloc.dart';
import 'package:flex_travel_sim/features/stripe_payment/services/stripe_service.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:flex_travel_sim/shared/widgets/app_notifier.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopUpBalanceWidget extends StatelessWidget {
  final String? imsi;
  const TopUpBalanceWidget({super.key, this.imsi});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StripeBloc, StripeState>(
      listener: _handleStripeStateChange,
      builder: (context, stripeState) {
        final isLoading = stripeState is StripeLoading;
        return BlueGradientButton(
          title:
              isLoading
                  ? AppLocalizations.loading
                  : AppLocalizations.topUpBalance,
          onTap: isLoading ? null : () => _handleTopUpTap(context),
        );
      },
    );
  }

  void _handleStripeStateChange(BuildContext context, StripeState state) {
    if (state is StripeSuccess) {
      if (kDebugMode) print('StripeService: StripeSuccess - ОПЛАТА ПРОШЛА УСПЕШНО !');

      if (imsi != null) {
        NavigationService.goToMainFlow(context);
      } else {
        NavigationService.openActivatedEsimScreen(context);
      }
    } else if (state is StripeFailure) {
      AppNotifier.error(AppLocalizations.paymentFail).showAppToast(context);
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
      AppNotifier.info(AppLocalizations.enterTopUpAmount).showAppToast(context);
      return false;
    }

    if (state.selectedPaymentMethod.isEmpty) {
      AppNotifier.info("Выберите способ оплаты!").showAppToast(context);
      return false;
    }

    return true;
  }

  void _processPayment(BuildContext context, TopUpBalanceState state) {
    final isTopUp = (imsi?.isNotEmpty ?? false);
    final operationType =
        isTopUp
            ? StripeOperationType.addFunds
            : StripeOperationType.newImsi;    
    switch (state.selectedPaymentMethod) {
      case 'credit_card':
        context.read<StripeBloc>().add(
          StripePaymentRequested(
            amount: state.amount,
            context: context,
            operationType: operationType,
            imsi: isTopUp ? imsi : null,
          ),
        );
        break;
      case 'crypto':
        AppNotifier.info(AppLocalizations.notAvailable).showAppToast(context);
        break;
      case 'apple_pay':
        context.read<StripeBloc>().add(
          GooglePayPaymentRequested(
            amount: state.amount,
            context: context,
            operationType: operationType,
            imsi: isTopUp ? imsi : null,
          ),
        );

        break;
      default:
        AppNotifier.info("Неизвестный способ оплаты").showAppToast(context);
    }    
  }
}