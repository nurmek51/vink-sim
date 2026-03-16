import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/features/tariffs_and_countries/data/data_sources/tariffs_remote_data_source.dart';
import 'package:vink_sim/features/tariffs_and_countries/presentation/bloc/tariffs_bloc.dart';
import 'package:vink_sim/features/tariffs_and_countries/presentation/bloc/tariffs_event.dart';
import 'package:vink_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/auto_top_up_container.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/fix_sum_button_widget.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/tariff_info_card_widget.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/top_up_balance_widget.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/counter_widget.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/payment_type_selector.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/saved_card_selection_modal.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/saved_card_selector.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/sim_card_selection_modal.dart';
import 'package:vink_sim/features/top_up_balance_screen/widgets/sim_card_shimmer_widget.dart';
import 'package:vink_sim/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:vink_sim/features/payment/domain/repositories/payment_repository.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_event.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/config/feature_config.dart';
import 'package:vink_sim/core/models/subscriber_model.dart';
import 'package:vink_sim/core/models/imsi_model.dart';
import 'package:vink_sim/features/subscriber/data/data_sources/subscriber_remote_data_source.dart';
import 'package:vink_sim/core/network/travel_sim_api_service.dart';
import 'package:vink_sim/core/network/api_client.dart';
import 'package:vink_sim/core/utils/asset_utils.dart';

class TopUpBalanceScreen extends StatelessWidget {
  final String? imsi;
  final bool isNewEsim;
  final SubscriberModel? subscriber;
  const TopUpBalanceScreen({
    super.key,
    this.imsi,
    this.isNewEsim = false,
    this.subscriber,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(
      '[DEBUG] [TopUpBalanceScreen] build imsi=$imsi isNewEsim=$isNewEsim featureConfigRegistered=${sl.isRegistered<FeatureConfig>()} paymentRepoRegistered=${sl.isRegistered<PaymentRepository>()} apiClientRegistered=${sl.isRegistered<ApiClient>()} travelServiceRegistered=${sl.isRegistered<TravelSimApiService>()}',
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TopUpBalanceBloc(
            paymentRepository: sl.get<PaymentRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) => TariffsBloc(
            dataSource: TariffsRemoteDataSourceImpl(
              apiClient: sl.get<ApiClient>(),
            ),
          )..add(const LoadTariffsEvent()),
        ),
        BlocProvider(
          create: (_) {
            final bloc = SubscriberBloc(
              subscriberRemoteDataSource: SubscriberRemoteDataSourceImpl(
                travelSimApiService: sl.get<TravelSimApiService>(),
              ),
            );

            if (subscriber != null) {
              bloc.add(SetSubscriberDataEvent(subscriber!));
            } else {
              bloc.add(const LoadSubscriberInfoEvent());
            }

            return bloc;
          },
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

class _TopUpBalanceView extends StatelessWidget {
  final String? imsi;
  final bool isNewEsim;
  const _TopUpBalanceView({this.imsi, this.isNewEsim = false});

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, paymentState) {
        final isStatusChecking = paymentState is PaymentStatusChecking;

        return Stack(
          children: [
            Scaffold(
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ).copyWith(
                  bottom: keyboardInset > 0 ? keyboardInset + 12 : 30,
                  top: 12,
                ),
                child: TopUpBalanceWidget(imsi: imsi, isNewEsim: isNewEsim),
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.backgroundColorLight,
              body: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: AppColors.backgroundColorLight,
                    surfaceTintColor: AppColors.backgroundColorLight,
                    elevation: 0,
                    leading: BackButton(
                      color: Colors.black,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(
                      child:
                          TopUpBalanceContent(imsi: imsi, isNewEsim: isNewEsim),
                    ),
                  ),
                ],
              ),
            ),
            if (isStatusChecking) const _PaymentStatusBlockingOverlay(),
          ],
        );
      },
    );
  }
}

class _PaymentStatusBlockingOverlay extends StatelessWidget {
  const _PaymentStatusBlockingOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            const ModalBarrier(
              dismissible: false,
              color: Color(0x66000000),
            ),
            Center(
              child: Container(
                constraints: const BoxConstraints(minHeight: 150),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.containerGray,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.accentBlue.withValues(alpha: 0.12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 34,
                      height: 34,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: AppColors.accentBlue,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      SimLocalizations.of(context)!
                          .processing_payment_please_wait,
                      textAlign: TextAlign.center,
                      style: FlexTypography.paragraph.medium.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      builder: (modalContext) => SimCardSelectionModal(
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

  void _showSavedCardSelectionModal(
    BuildContext context,
    List<SavedCard> savedCards,
    SavedCard? selectedCard,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => SavedCardSelectionModal(
        savedCards: savedCards,
        selectedCardId: selectedCard?.id,
        onCardSelected: (savedCard) {
          context.read<TopUpBalanceBloc>().add(SelectSavedCard(savedCard));
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
            final simCards = subscriberState is SubscriberLoaded
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

            if (!isNewEsim &&
                topUpState.selectedPaymentMethod == 'credit_card' &&
                !topUpState.hasSavedCardsLoaded &&
                !topUpState.isSavedCardsLoading) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<TopUpBalanceBloc>().add(const LoadSavedCards());
              });
            }

            final selectedSimCard = topUpState.selectedSimCard;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HelveticaneueFont(
                  text: SimLocalizations.of(context)!.top_up_balance,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                const SizedBox(height: 12),
                if (!isNewEsim) ...[
                  if (subscriberState is SubscriberLoading ||
                      subscriberState is SubscriberInitial)
                    const SimCardShimmerWidget()
                  else if (simCards.isNotEmpty) ...[
                    Text(
                      SimLocalizations.of(context)!.select_sim_card,
                      style: const TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _showSimCardSelectionModal(
                        context,
                        simCards,
                        selectedSimCard?.imsi ?? simCards.first.imsi,
                      ),
                      child: Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7EFF7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Assets.icons.simIcon.svg(
                              package: AssetUtils.package,
                              colorFilter: const ColorFilter.mode(
                                Colors.black,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              selectedSimCard?.country ??
                                  (simCards.isNotEmpty
                                      ? simCards.first.country
                                      : null) ??
                                  SimLocalizations.of(
                                    context,
                                  )!
                                      .sim_card_default,
                              style: const TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 24,
                              color: const Color(0xFF363C45)
                                  .withValues(alpha: 0.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ],
                Text(
                  SimLocalizations.of(context)!.enter_amount_top_up_description,
                  style: const TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
                  builder: (context, state) {
                    return CounterWidget(
                      value: state.amount,
                      onIncrement: () => context.read<TopUpBalanceBloc>().add(
                            const IncrementAmount(),
                          ),
                      onDecrement: () => context.read<TopUpBalanceBloc>().add(
                            const DecrementAmount(),
                          ),
                      onAmountChanged: (newAmount) =>
                          context.read<TopUpBalanceBloc>().add(
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
                Text(
                  SimLocalizations.of(context)!.choose_payment_method,
                  style: FlexTypography.headline.medium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const PaymentTypeSelector(),
                if (!isNewEsim &&
                    topUpState.selectedPaymentMethod == 'credit_card') ...[
                  const SizedBox(height: 16),
                  SavedCardSelector(
                    selectedCard: topUpState.selectedSavedCard,
                    isLoading: topUpState.isSavedCardsLoading,
                    onTap: () => _showSavedCardSelectionModal(
                      context,
                      topUpState.savedCards,
                      topUpState.selectedSavedCard,
                    ),
                  ),
                ],
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
