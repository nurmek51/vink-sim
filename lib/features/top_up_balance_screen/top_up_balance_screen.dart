import 'package:easy_localization/easy_localization.dart';
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
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/counter_widget.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/payment_type_selector.dart';
import 'package:flex_travel_sim/features/top_up_balance_screen/widgets/sim_card_selection_modal.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_event.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/core/models/imsi_model.dart';
import 'package:flex_travel_sim/features/subscriber/data/data_sources/subscriber_remote_data_source.dart';
import 'package:flex_travel_sim/core/network/travel_sim_api_service.dart';

class TopUpBalanceScreen extends StatelessWidget {
  final String? imsi;
  final bool isNewEsim;
  const TopUpBalanceScreen({super.key, this.imsi, this.isNewEsim = false});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TopUpBalanceBloc()),
        BlocProvider(
          create:
              (_) =>
                  TariffsBloc(dataSource: TariffsRemoteDataSourceImpl())
                    ..add(const LoadTariffsEvent()),
        ),
        BlocProvider(
          create:
              (_) => SubscriberBloc(
                subscriberRemoteDataSource: SubscriberRemoteDataSourceImpl(
                  travelSimApiService: sl.get<TravelSimApiService>(),
                ),
              ),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: _TopUpBalanceView(imsi: imsi, isNewEsim: isNewEsim),
      ),
    );
  }
}

class _TopUpBalanceView extends StatefulWidget {
  final String? imsi;
  final bool isNewEsim;
  const _TopUpBalanceView({this.imsi, this.isNewEsim = false});

  @override
  State<_TopUpBalanceView> createState() => _TopUpBalanceViewState();
}

class _TopUpBalanceViewState extends State<_TopUpBalanceView> {
  @override
  void initState() {
    super.initState();
    _loadSubscriberData();
  }

  void _loadSubscriberData() async {
    final authDataSource = sl.get<AuthLocalDataSource>();
    try {
      final token = await authDataSource.getToken();
      if (token != null && mounted) {
        context.read<SubscriberBloc>().add(
          LoadSubscriberInfoEvent(token: token),
        );
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ).copyWith(bottom: 30, top: 12),
        child: TopUpBalanceWidget(imsi: widget.imsi),
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
            sliver: SliverToBoxAdapter(
              child: TopUpBalanceContent(imsi: widget.imsi, isNewEsim: widget.isNewEsim),
            ),
          ),
        ],
      ),
    );
  }
}

class TopUpBalanceContent extends StatelessWidget {
  final String? imsi;
  final bool isNewEsim;
  const TopUpBalanceContent({super.key, this.imsi, this.isNewEsim = false});

  void _showSimCardSelectionModal(
    BuildContext context,
    List<ImsiModel> simCards,
    String? selectedImsi,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (modalContext) => SimCardSelectionModal(
            simCards: simCards,
            selectedImsi: selectedImsi,
            onSimCardSelected: (selectedSimCard) {
              context.read<TopUpBalanceBloc>().add(
                SelectSimCard(selectedSimCard),
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriberBloc, SubscriberState>(
      builder: (context, subscriberState) {
        return BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
          builder: (context, topUpState) {
            final simCards =
                subscriberState is SubscriberLoaded
                    ? subscriberState.subscriber.imsiList
                    : <ImsiModel>[];
            if (imsi != null &&
                simCards.isNotEmpty &&
                topUpState.selectedSimCard == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<TopUpBalanceBloc>().add(
                  InitializeWithImsi(imsi, simCards),
                );
              });
            }
            final selectedSimCard = topUpState.selectedSimCard;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (simCards.isNotEmpty && simCards.any((card) => card.balance > 0) && !isNewEsim) ...[
                  LocalizedText(
                    AppLocalizations.selectSimCard,
                    style: FlexTypography.label.medium,
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap:
                        () => _showSimCardSelectionModal(
                          context,
                          simCards,
                          selectedSimCard?.imsi ?? simCards.first.imsi,
                        ),
                    child: Container(
                      height: 52,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFE7EFF7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Assets.icons.simIcon.svg(
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            selectedSimCard?.country ??
                                (simCards.isNotEmpty
                                    ? simCards.first.country
                                    : null) ??
                                AppLocalizations.simCardDefault.tr(),
                          ),
                          Spacer(),
                          Assets.icons.arrowDown.svg(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
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
          },
        );
      },
    );
  }
}
