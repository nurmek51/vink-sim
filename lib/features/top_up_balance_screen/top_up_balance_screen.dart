import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/counter_widget.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/fix_sum_button.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/payment_type_selector.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/tariff_scroll_view.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';

class TopUpBalanceScreen extends StatelessWidget {
  const TopUpBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopUpBalanceBloc(),
      child: const _TopUpBalanceView(),
    );
  }
}

class _TopUpBalanceView extends StatelessWidget {
  const _TopUpBalanceView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
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
                    onIncrement: () => context.read<TopUpBalanceBloc>().add(const IncrementAmount()),
                    onDecrement: () => context.read<TopUpBalanceBloc>().add(const DecrementAmount()),
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
              const SizedBox(height: 16),
              BlueGradientButton(
                title: AppLocalization.topUpBalance,
                onTap: () => openActivatedEsimScreen(context),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() => Text(
    'Пополнить баланс',
    style: FlexTypography.headline.large.copyWith(
      color: AppColors.grayBlue,
    ),
  );

  Widget _buildSubtitle() => Text(
    'Введите сумму, чтобы подключить \nFlex Travel eSIM',
    style: FlexTypography.label.medium.copyWith(
      color: AppColors.grayBlue,
    ),
  );

  Widget _buildFixSumButtons() => BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
    builder: (context, state) {
      return Row(
        children: [1, 5, 15, 50, 100]
            .map((sum) => FixSumButton(
                  sum: sum,
                  onTap: (value) => context.read<TopUpBalanceBloc>().add(SetAmount(value)),
                ))
            .toList(),
      );
    },
  );

  Widget _buildTariffInfoCard(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    height: 211,
    decoration: BoxDecoration(
      color: AppColors.backgroundColorLight,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFD4D4D4), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: 'Flex Travel eSIM работает ',
            style: FlexTypography.paragraph.medium.copyWith(color: Colors.black),
            children: [
              TextSpan(
                text: 'по всему миру.\n',
                style: FlexTypography.paragraph.medium.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'согласно тарифам страны присутствия.\n',
                style: FlexTypography.paragraph.medium.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '15\$ на балансе, это:',
          style: FlexTypography.paragraph.medium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const TariffScrollView(),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => openTariffsAndCountriesPage(context),
          child: Text(
            'Все страны и тарифы',
            style: FlexTypography.paragraph.medium.copyWith(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildPaymentTitle() => Text(
    'Выберите способ оплаты',
    style: FlexTypography.headline.medium.copyWith(
      fontWeight: FontWeight.bold,
    ),
  );

  Widget _buildAutoTopUpCard() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    height: 100,
    decoration: BoxDecoration(
      color: const Color(0xFFD4D4D4),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Автопополение',
                style: FlexTypography.paragraph.medium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Баланс будет пополняться автоматически \nна 15\$, чтобы вы не потеряли доступ во \nвремя путешествияы',
                style: FlexTypography.paragraph.small,
              ),
            ],
          ),
        ),
        BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
          builder: (context, state) {
            return CupertinoSwitch(
              value: state.autoTopUpEnabled,
              onChanged: (value) => context.read<TopUpBalanceBloc>().add(ToggleAutoTopUp(value)),
              activeColor: CupertinoColors.systemBlue,
            );
          },
        ),
      ],
    ),
  );
}
