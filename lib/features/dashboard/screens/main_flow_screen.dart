import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/dashboard/bloc/main_flow_bloc.dart';
import 'package:flex_travel_sim/features/dashboard/utils/progress_color_utils.dart';
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

  void _showBottomSheet(BuildContext context) {
    context.read<MainFlowBloc>().add(ShowBottomSheetEvent());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) => Padding(
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
        return Scaffold(
          backgroundColor: AppColors.backgroundColorLight,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Header(
                    color: AppColors.grayBlue,
                    faqOnTap: () => openGuidePage(context),
                    avatarOnTap: () => openMyAccountScreen(context),
                  ),
                  const SizedBox(height: 15),
                  // Карусель кругов eSIM
                  SizedBox(
                    height: 320,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: state.progressValues.length,
                      onPageChanged: (index) {
                        context.read<MainFlowBloc>().add(PageChangedEvent(index));
                      },
                      itemBuilder: (context, index) {
                        final value = state.progressValues[index];
                        return AnimatedScale(
                          scale: state.currentPage == index ? 1.0 : 0.9,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: PercentageWidget(
                            progressValue: value,
                            color: ProgressColorUtils.getProgressColor(value),
                            backgroundColor: ProgressColorUtils.getProgressBackgroundColor(value),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Индикаторы страниц
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      state.progressValues.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: state.currentPage == index ? Colors.blue : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      ExpandedContainer(
                        title: AppLocalization.howToInstallEsim,
                        icon: Assets.icons.simIcon.path,
                        onTap: () => openEsimSetupPage(context),
                      ),
                      const SizedBox(width: 16),
                      ExpandedContainer(
                        title: AppLocalization.supportChat,
                        icon: Assets.icons.telegramIcon.path,
                        onTap: () => _showBottomSheet(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ExpandedContainer(
                        title: AppLocalization.questionsAndAnswers,
                        icon: Assets.icons.faqIconFull.path,
                        onTap: () => openGuidePage(context),
                      ),
                      const SizedBox(width: 16),
                      ExpandedContainer(
                        title: AppLocalization.countriesAndRates,
                        icon: Assets.icons.globus.path,
                        onTap: () => openTariffsAndCountriesPage(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  BlueGradientButton(
                    onTap: () => openTopUpBalanceScreen(context),
                    title: AppLocalization.topUpBalance,
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
