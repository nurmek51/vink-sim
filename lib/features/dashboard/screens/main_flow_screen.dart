import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/dashboard/bloc/main_flow_bloc.dart';
import 'package:flex_travel_sim/features/dashboard/utils/progress_color_utils.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/add_esim_circle.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/expanded_container.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/percentage_widget.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';
import 'package:flex_travel_sim/shared/widgets/header.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainFlowScreen extends StatefulWidget {
  const MainFlowScreen({super.key});

  @override
  State<MainFlowScreen> createState() => _MainFlowScreenState();
}

class _MainFlowScreenState extends State<MainFlowScreen> {
  final PageController _pageController = PageController(viewportFraction: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Выберите уровень'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Low — 0 GB'),
                  onTap: () {
                    context.read<MainFlowBloc>().add(
                      const AddCircleEvent(BalanceLevel.low),
                    );
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Medium — 0.6 GB'),
                  onTap: () {
                    context.read<MainFlowBloc>().add(
                      const AddCircleEvent(BalanceLevel.medium),
                    );
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('High — 15 GB'),
                  onTap: () {
                    context.read<MainFlowBloc>().add(
                      const AddCircleEvent(BalanceLevel.high),
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    context.read<MainFlowBloc>().add(ShowBottomSheetEvent());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              child: BottomSheetContent(),
            ),
          ),
    ).then((_) {
      context.read<MainFlowBloc>().add(HideBottomSheetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainFlowBloc, MainFlowState>(
      builder: (context, state) {
        final actualCount = state.progressValues.length;
        final canAdd =
            state.progressValues.length < MainFlowBloc.maxCircles - 1;
        final itemCount = actualCount + 1;
        final isSmall = isSmallScreen(context);
        final isSmallOrDesktop = isSmallScreen(context) || isDesktop(context);

        return Scaffold(
          backgroundColor: AppColors.backgroundColorLight,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 50,
                left: 30,
                right: 30,
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
                          final value = state.progressValues[index];
                          final isYellow = value > 0 && value <= 1.0;
                          return AnimatedScale(
                            scale: state.currentPage == index ? 1.0 : 0.9,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                            child: PercentageWidget(
                              progressValue: value,
                              color: ProgressColorUtils.getProgressColor(value),
                              isYellow: isYellow,
                              backgroundColor:
                                  ProgressColorUtils.getProgressBackgroundColor(
                                    value,
                                  ),
                            ),
                          );
                        } else {
                          return AddEsimCircle(
                            canAdd: canAdd,
                            onAddButtonPressed: () => _showAddDialog(context),
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
                              state.currentPage == index
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
                        onTap: () => _showBottomSheet(context),
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
                  SizedBox(height: 15),

                  const Spacer(),

                  BlueGradientButton(
                    onTap: () => openTopUpBalanceScreen(context),
                    title: AppLocalizations.topUpBalance,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
