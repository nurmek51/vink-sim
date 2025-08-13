import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/data/data_sources/tariffs_remote_data_source.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_bloc.dart';
import 'package:flex_travel_sim/features/tariffs_and_countries/presentation/bloc/tariffs_event.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/auto_top_up_container.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/fix_sum_button_widget.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/tariff_info_card_widget.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/top_up_balance_widget.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/counter_widget.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/payment_type_selector.dart';

class TopUpBalanceScreen extends StatelessWidget {
  final String? imsi;
  const TopUpBalanceScreen({
    super.key,
    this.imsi,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TopUpBalanceBloc()),
        BlocProvider(create: (_) => TariffsBloc(dataSource: TariffsRemoteDataSourceImpl())..add(const LoadTariffsEvent())),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: _TopUpBalanceView(imsi: imsi)),
    );
  }
}

class _TopUpBalanceView extends StatelessWidget {
  final String? imsi;
  const _TopUpBalanceView({this.imsi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ).copyWith(bottom: 30, top: 12),
        child: TopUpBalanceWidget(imsi: imsi),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColorLight,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            backgroundColor: AppColors.backgroundColorLight,
            surfaceTintColor: AppColors.backgroundColorLight,
            leading: Transform.translate(
              offset: const Offset(-12, 0),
              child: BackButton(
                color: Colors.black,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              expandedTitleScale: 1.4,
              title: HelveticaneueFont(
                text: AppLocalizations.topUpBalance,

                fontSize: 20,
                letterSpacing: -0.5,
                height: 1.1,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF363C45),
              ),
              background: Container(
                color: AppColors.backgroundColorLight,
                child: const SizedBox.shrink(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(child: TopUpBalanceContent(imsi: imsi)),
          ),
        ],
      ),
    );
  }
}

class TopUpBalanceContent extends StatelessWidget {
  final String? imsi;
  const TopUpBalanceContent({super.key, this.imsi});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocalizedText(
          AppLocalizations.enterAmountTopUpDescription,
          style: FlexTypography.label.medium.copyWith(
            color: AppColors.grayBlue,
          ),
        ),
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
        FixSumButtonWidget(),
        const SizedBox(height: 16),
        TariffInfoCardWidget(),
        const SizedBox(height: 30),
        LocalizedText(
          AppLocalizations.choosePaymentMethod,
          style: FlexTypography.headline.medium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const PaymentTypeSelector(),
        const SizedBox(height: 16),
        AutoTopUpContainer(),
      ],
    );
  }
}
