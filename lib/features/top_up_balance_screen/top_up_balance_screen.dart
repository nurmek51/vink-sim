import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/features/screen142/views/tariffs_and_countries_page.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/counter_widget.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/fix_sum_button.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/payment_type_selector.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/tariff_scroll_view.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';

class TopUpBalanceScreen extends StatefulWidget {
  const TopUpBalanceScreen({super.key});

  @override
  State<TopUpBalanceScreen> createState() => _TopUpBalanceScreenState();
}

class _TopUpBalanceScreenState extends State<TopUpBalanceScreen> {
  int _amount = 0;

  void _setAmount(int value) => setState(() => _amount = value);
  void _increment() => setState(() => _amount++);
  void _decrement() => setState(() => _amount = _amount > 0 ? _amount - 1 : 0);

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
              CounterWidget(
                value: _amount,
                onIncrement: _increment,
                onDecrement: _decrement,
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
    style: TextStyle(
      color: AppColors.grayBlue,
      fontSize: 28,
      fontWeight: FontWeight.w500,
    ),
  );

  Widget _buildSubtitle() => Text(
    'Введите сумму, чтобы подключить \nFlex Travel eSIM',
    style: TextStyle(
      color: AppColors.grayBlue,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );

  Widget _buildFixSumButtons() => Row(
    children:
        [
          1,
          5,
          15,
          50,
          100,
        ].map((sum) => FixSumButton(sum: sum, onTap: _setAmount)).toList(),
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
            style: const TextStyle(color: Colors.black, fontSize: 15),
            children: const [
              TextSpan(
                text: 'по всему миру.\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: 'согласно тарифам страны присутствия.\n'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '15\$ на балансе, это:',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const TariffScrollView(),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => openTariffsAndCountriesPage(context),
          child: const Text(
            'Все страны и тарифы',
            style: TextStyle(
              fontSize: 15,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildPaymentTitle() => const Text(
    'Выберите способ оплаты',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Автопополение',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Баланс будет пополняться автоматически \nна 15\$, чтобы вы не потеряли доступ во \nвремя путешествияы',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
        const SwitchWidget(),
      ],
    ),
  );
}

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({super.key});

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: _value,
      onChanged: (v) => setState(() => _value = v),
      activeColor: CupertinoColors.systemBlue,
    );
  }
}
