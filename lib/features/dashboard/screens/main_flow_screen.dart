import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/features/dashboard/widgets/expanded_container.dart';
import 'package:flex_travel_sim/features/main_flow_screen/bottom_sheet_content.dart';
import 'package:flex_travel_sim/features/main_flow_screen/widgets/percentage_widget.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';
import 'package:flex_travel_sim/shared/widgets/header.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class MainFlowScreen extends StatefulWidget {
  const MainFlowScreen({super.key});

  @override
  State<MainFlowScreen> createState() => _MainFlowScreenState();
}

class _MainFlowScreenState extends State<MainFlowScreen> {
  int currentPage = 0;
  final List<double> progressValues = [0.40, 0];
  final PageController _pageController = PageController(viewportFraction: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Color _getProgressColor(double value) {
    if (value < 0.1) return Colors.red;
    if (value < 0.5) return const Color(0xFF73BAE7);
    if (value < 0.7) return const Color(0xFF73BAE7);
    return Colors.green;
  }

  Color _getProgressBackgroundColor(double value) {
    if (value < 0.1) return Colors.red;
    if (value < 0.5) return const Color(0xFF1F6FFF);
    if (value < 0.7) return const Color(0xFF1F6FFF);
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
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
                  itemCount: progressValues.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final value = progressValues[index];
                    return AnimatedScale(
                      scale: currentPage == index ? 1.0 : 0.9,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: PercentageWidget(
                        progressValue: value,
                        color: _getProgressColor(value),
                        backgroundColor: _getProgressBackgroundColor(value),
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
                  progressValues.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index ? Colors.blue : Colors.grey,
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
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder:
                            (context) => Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: BottomSheetContent(),
                              ),
                            ),
                      );
                    },
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
  }
}
