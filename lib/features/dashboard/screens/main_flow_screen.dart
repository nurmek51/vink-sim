// ignore_for_file: use_build_context_synchronously

import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/dashboard/bloc/main_flow_bloc.dart';
import 'package:flex_travel_sim/features/dashboard/utils/progress_color_utils.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_event.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/core/models/imsi_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/add_esim_circle.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/expanded_container.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/percentage_widget.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/percentage_shimmer_widget.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';
import 'package:flex_travel_sim/shared/widgets/header.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainFlowDataProcessor {
  static double calculateAvailableGB(double balance, double rate) {
    if (rate == 0) return 0.0;
    final gb = balance / rate / 1024;
    return gb;
  }

  static List<ImsiModel> processImsiList(SubscriberState state) {
    final loadedImsiList =
        state is SubscriberLoaded ? state.subscriber.imsiList : <ImsiModel>[];

    final subscriberBalance =
        state is SubscriberLoaded ? state.subscriber.balance : 0.0;

    final isLoading = state is SubscriberLoading;
    final hasError = state is SubscriberError;

    return loadedImsiList.isNotEmpty
        ? loadedImsiList
        : [
          ImsiModel(
            imsi: 'default',
            balance: subscriberBalance,
            country:
                isLoading
                    ? AppLocalizations.loading
                    : (hasError ? AppLocalizations.error : 'N/A'),
            rate: 1024.0,
          ),
        ];
  }

  static bool isLoadingWithNoData(SubscriberState state, List<ImsiModel> list) {
    return state is SubscriberLoading && list.isEmpty;
  }
}

class MainFlowScreen extends StatefulWidget {
  const MainFlowScreen({super.key});

  @override
  State<MainFlowScreen> createState() => _MainFlowScreenState();
}

class _MainFlowScreenState extends State<MainFlowScreen> {
  final PageController _pageController = PageController(viewportFraction: 1);

  @override
  void initState() {
    super.initState();
    _loadSubscriberDataIfNeeded();
  }

  void _loadSubscriberDataIfNeeded() async {
    final authDataSource = sl.get<AuthLocalDataSource>();
    try {
      final token = await authDataSource.getToken();
      if (token != null && mounted) {
        context.read<SubscriberBloc>().add(
          LoadSubscriberInfoEvent(token: token),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('MainFlowScreen: Error loading token: $e');
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainFlowBloc, MainFlowState>(
      builder: (context, mainFlowState) {
        return BlocBuilder<SubscriberBloc, SubscriberState>(
          builder: (context, subscriberState) {
            final loadedImsiList =
                subscriberState is SubscriberLoaded
                    ? subscriberState.subscriber.imsiList
                    : <ImsiModel>[];

            final subscriberBalance =
                subscriberState is SubscriberLoaded
                    ? subscriberState.subscriber.balance
                    : 0.0;
            final isLoading =
                subscriberState is SubscriberLoading ||
                subscriberState is SubscriberInitial;
            final hasError = subscriberState is SubscriberError;
            final displayList =
                loadedImsiList.isNotEmpty
                    ? loadedImsiList
                    : [
                      ImsiModel(
                        imsi: 'default',
                        balance: subscriberBalance,
                        country:
                            isLoading
                                ? AppLocalizations.loading
                                : (hasError ? AppLocalizations.error : 'N/A'),
                        rate: 1024.0,
                      ),
                    ];

            final actualCount = displayList.length;
            final canAdd = actualCount < MainFlowBloc.maxCircles - 1;
            final itemCount = actualCount + 1;
            final isSmall = isSmallScreen(context);
            final isSmallOrDesktop =
                isSmallScreen(context) || isDesktop(context);

            double calculateAvailableGB(double balance, double rate) {
              if (rate == 0) return 0.0;
              final gb = balance / rate / 1024;
              return gb;
            }

            return Scaffold(
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ).copyWith(bottom: 30, top: 12),
                child: BlueGradientButton(
                  onTap: () => openTopUpBalanceScreen(context),
                  title: AppLocalizations.topUpBalance,
                ),
              ),
              backgroundColor: AppColors.backgroundColorLight,
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 50,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Header(
                          color: AppColors.grayBlue,
                          faqOnTap: () => openGuidePage(context),
                          avatarOnTap: () => openMyAccountScreen(context),
                        ),
                        SizedBox(height: isSmallOrDesktop ? 0 : 15),
                        SizedBox(
                          height: isSmall ? 309 : 320,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: itemCount,
                            onPageChanged: (index) {
                              context.read<MainFlowBloc>().add(
                                PageChangedEvent(index),
                              );
                            },
                            itemBuilder: (context, index) {
                              if (index < actualCount) {
                                if (isLoading && loadedImsiList.isEmpty) {
                                  return AnimatedScale(
                                    scale:
                                        mainFlowState.currentPage == index
                                            ? 1.0
                                            : 0.9,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                    child: const PercentageShimmerWidget(),
                                  );
                                }

                                final imsi = displayList[index];
                                final availableGB = calculateAvailableGB(
                                  imsi.balance,
                                  imsi.rate ?? 1024.0,
                                );
                                final isYellow =
                                    availableGB > 0 && availableGB <= 1.0;

                                return AnimatedScale(
                                  scale:
                                      mainFlowState.currentPage == index
                                          ? 1.0
                                          : 0.9,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                  child: PercentageWidget(
                                  imsi: imsi.imsi,
                                  progressValue: availableGB,
                                  color: ProgressColorUtils.getProgressColor(
                                    availableGB,
                                  ),
                                  isYellow: isYellow,
                                  backgroundColor:
                                      ProgressColorUtils.getProgressBackgroundColor(
                                        availableGB,
                                      ),
                                  balance: imsi.balance,
                                  country: imsi.country,
                                  rate: imsi.rate, 
                                ),
                                );
                              } else {
                                return AddEsimCircle(
                                  canAdd: canAdd,
                                  onAddButtonPressed:
                                      () =>
                                          NavigationService.openTopUpBalanceScreen(
                                            context,
                                          ),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: isSmallOrDesktop ? 2 : 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            itemCount,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color:
                                    mainFlowState.currentPage == index
                                        ? Colors.blue
                                        : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: isSmallOrDesktop ? 3 : 16),
                        Row(
                          children: [
                            ExpandedContainer(
                              title: AppLocalizations.howToInstallEsim2,
                              icon: Assets.icons.simIcon.path,
                              onTap: () => openEsimSetupPage(context),
                            ),
                            const SizedBox(width: 16),
                            ExpandedContainer(
                              title: AppLocalizations.supportChat,
                              icon: Assets.icons.telegramIcon.path,
                              onTap: () => BottomSheetContent(),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            ExpandedContainer(
                              title: AppLocalizations.questionsAndAnswers,
                              icon: Assets.icons.faqIconFull.path,
                              onTap: () => openGuidePage(context),
                            ),
                            const SizedBox(width: 16),
                            ExpandedContainer(
                              title: AppLocalizations.countriesAndRates,
                              icon: Assets.icons.globus.path,
                              onTap: () => openTariffsAndCountriesPage(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
