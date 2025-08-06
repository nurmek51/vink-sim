import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/dashboard/bloc/main_flow_bloc.dart';
import 'package:flex_travel_sim/features/stripe_payment/presentation/bloc/stripe_bloc.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:flex_travel_sim/shared/widgets/app_notifier.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/counter_widget.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/fix_sum_button.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/payment_type_selector.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/tariff_scroll_view.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';

class TopUpBalanceScreen extends StatelessWidget {
  final int? circleIndex;
  const TopUpBalanceScreen({
    super.key,
    this.circleIndex,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TopUpBalanceBloc()),
        BlocProvider(create: (_) => StripeBloc()),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: _TopUpBalanceView(circleIndex: circleIndex)),
    );
  }
}

class _TopUpBalanceView extends StatelessWidget {
  final int? circleIndex;
  const _TopUpBalanceView({this.circleIndex});

  @override
  Widget build(BuildContext context) {
    final isScrollable = isTopUpScreenScrollable(context);
    final content = _buildContent(context, isScrollable);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColorLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: isScrollable ? 0 : 50,
        ),
        child: isScrollable ? SingleChildScrollView(child: content) : content,
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isScrollable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 16),
        _buildSubtitle(),
        const SizedBox(height: 16),
        BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
          builder: (context, state) {
            return CounterWidget(
              value: state.amount,
              onIncrement:
                  () => context.read<TopUpBalanceBloc>().add(
                    const IncrementAmount(),
                  ),
              onDecrement:
                  () => context.read<TopUpBalanceBloc>().add(
                    const DecrementAmount(),
                  ),
              onAmountChanged:
                  (newAmount) => context.read<TopUpBalanceBloc>().add(
                    SetAmount(newAmount),
                  ),     
            );
          },
        ),
        const SizedBox(height: 16),
        _buildFixSumButtons(),
        const SizedBox(height: 16),
        _buildTariffInfoCard(context),
        const SizedBox(height: 30),
        _buildPaymentTitle(),
        const SizedBox(height: 16),
        const PaymentTypeSelector(),
        const SizedBox(height: 16),
        _buildAutoTopUpCard(),
        isScrollable ? const SizedBox(height: 15) : const Spacer(),

              BlocConsumer<StripeBloc, StripeState>(
                listener: (context, state) {
                  if (state is StripeSuccess) { 
                    if (kDebugMode) print('ОПЛАТА ПРОШЛА УСПЕШНО !');

                    if (circleIndex != null) {
                      context.read<MainFlowBloc>().add(
                        UpdateCircleBalanceEvent(
                          circleIndex: circleIndex!,
                          addedAmount:
                              context
                                  .read<TopUpBalanceBloc>()
                                  .state
                                  .amount
                                  .toDouble(), 
                        ),
                      );

                      Navigator.of(context).pop();
                    } else {
                      NavigationService.openActivatedEsimScreen(context);
                    }
                  } else if (state is StripeFailure) {
                    AppNotifier.error(AppLocalizations.paymentFail).showAppToast(context);
                  }
                },
                builder: (context, stripeState) {
                  final isLoading = stripeState is StripeLoading;
                  return BlueGradientButton(
                    title:
                        isLoading
                            ? AppLocalizations.loading
                            : AppLocalizations.topUpBalance,
                    onTap:
                        isLoading
                            ? null
                            : () {
                              final bloc = context.read<TopUpBalanceBloc>();
                              final state = bloc.state;

                              if (state.amount <= 0) {
                                AppNotifier.info(AppLocalizations.enterTopUpAmount).showAppToast(context);
                                return;
                              }

                              if (state.selectedPaymentMethod.isEmpty) {
                                AppNotifier.info("Выберите способ оплаты!").showAppToast(context);
                                return;
                              }

                              switch (state.selectedPaymentMethod) {
                                case 'credit_card':
                                  context.read<StripeBloc>().add(
                                    StripePaymentRequested(
                                      amount: state.amount,
                                      context: context,
                                      circleIndex: circleIndex,
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
                                      currency: 'usd',
                                    ),
                                  );

                                  break;
                                default:
                                  AppNotifier.info("Неизвестный способ оплаты").showAppToast(context);
                              }
                            },
                  );
                },
              ),

              isScrollable ? const SizedBox(height: 50) : const SizedBox.shrink()
      ],
    );
  }

  Widget _buildTitle() => LocalizedText(
    AppLocalizations.topUpBalance,
    style: FlexTypography.headline.large.copyWith(color: AppColors.grayBlue),
  );

  Widget _buildSubtitle() => LocalizedText(
    AppLocalizations.enterAmountTopUpDescription,
    style: FlexTypography.label.medium.copyWith(color: AppColors.grayBlue),
  );

  Widget _buildFixSumButtons() =>
      BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
        builder: (context, state) {
          return Row(
            children:
                [1, 5, 15, 50, 100]
                    .map(
                      (sum) => FixSumButton(
                        sum: sum,
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

  Widget _buildTariffInfoCard(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    height: 183,
    decoration: BoxDecoration(
      color: AppColors.backgroundColorLight,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFD4D4D4), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocalizedText(
          AppLocalizations.flexTravelEsimWorksWorldwide,
          style: FlexTypography.paragraph.medium.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        LocalizedText(
          AppLocalizations.balance15Description,
          style: FlexTypography.paragraph.medium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const TariffScrollView(),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => openTariffsAndCountriesPage(context),
          child: LocalizedText(
            AppLocalizations.allCountriesAndTariffs,
            style: FlexTypography.paragraph.medium.copyWith(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildPaymentTitle() => LocalizedText(
    AppLocalizations.choosePaymentMethod,
    style: FlexTypography.headline.medium.copyWith(fontWeight: FontWeight.bold),
  );

  Widget _buildAutoTopUpCard() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    height: 100,
    decoration: BoxDecoration(
      color: AppColors.containerGray,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LocalizedText(
                AppLocalizations.autoTopUp,
                style: FlexTypography.paragraph.medium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              LocalizedText(
                AppLocalizations.autoTopUpDescription,
                style: FlexTypography.paragraph.small,
              ),
            ],
          ),
        ),
        BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
          builder: (context, state) {
            return CupertinoSwitch(
              value: state.autoTopUpEnabled,
              onChanged:
                  (value) => context.read<TopUpBalanceBloc>().add(
                    ToggleAutoTopUp(value),
                  ),
              activeTrackColor: CupertinoColors.systemBlue,
            );
          },
        ),
      ],
    ),
  );
}