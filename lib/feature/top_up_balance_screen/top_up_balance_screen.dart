import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/feature/screen142/views/tariffs_and_countries_page.dart';
import 'package:flex_travel_sim/feature/top_up_balance_screen/widgets/counter_widget.dart';
import 'package:flex_travel_sim/feature/top_up_balance_screen/widgets/fix_sum_button.dart';
import 'package:flex_travel_sim/feature/top_up_balance_screen/widgets/payment_type_selector.dart';
import 'package:flex_travel_sim/feature/top_up_balance_screen/widgets/scroll_container.dart';
import 'package:flex_travel_sim/feature/top_up_balance_screen/widgets/tariff_scroll_view.dart';
import 'package:flutter/material.dart';

class TopUpBalanceScreen extends StatefulWidget {
  const TopUpBalanceScreen({super.key});

  @override
  State<TopUpBalanceScreen> createState() => _TopUpBalanceScreenState();
}

class _TopUpBalanceScreenState extends State<TopUpBalanceScreen> {
  int amount = 0;

  void setAmount(int value) {
    setState(() {
      amount = value;
    });
  }

  void increment() {
    setState(() {
      amount++;
    });
  }

  void decrement() {
    setState(() {
      amount = amount > 0 ? amount - 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      appBar: AppBar(backgroundColor: AppColors.backgroundColorLight),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Пополнить баланс',
                style: TextStyle(
                  color: AppColors.grayBlue,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Введите сумму, чтобы подключить \nFlex Travel eSIM',
                style: TextStyle(
                  color: AppColors.grayBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16),
              CounterWidget(
                value: amount,
                onIncrement: increment,
                onDecrement: decrement,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  FixSumButton(sum: 1, onTap: setAmount),
                  FixSumButton(sum: 5, onTap: setAmount),
                  FixSumButton(sum: 15, onTap: setAmount),
                  FixSumButton(sum: 50, onTap: setAmount),
                  FixSumButton(sum: 100, onTap: setAmount),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                alignment: Alignment.topLeft,
                height: 211,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColorLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFFD4D4D4), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Flex Travel eSIM работает ',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        children: [
                          TextSpan(
                            text: 'по всему миру.\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: 'согласно тарифам страны присутствия.\n',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '15\$ на балансе, это:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TariffScrollView(),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const TariffsAndCountriesScreen(),
                          ),
                        );
                      },
                      child: Text(
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
              ),
              SizedBox(height: 30),
              Text(
                'Выберите способ оплаты',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              PaymentTypeSelector(),
              Container(
                width: 100,
                decoration: BoxDecoration(color: Colors.amber),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
