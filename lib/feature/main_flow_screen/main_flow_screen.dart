import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/main_flow_screen/bottom_sheet_content.dart';
import 'package:flex_travel_sim/feature/main_flow_screen/widgets/expanded_container.dart';
import 'package:flex_travel_sim/feature/main_flow_screen/widgets/percentage_widget.dart';
import 'package:flex_travel_sim/feature/my_account_screen/my_account_screen.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/header.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class MainFlowScreen extends StatefulWidget {
  const MainFlowScreen({super.key});

  @override
  State<MainFlowScreen> createState() => _MainFlowScreenState();
}

class _MainFlowScreenState extends State<MainFlowScreen> {
  int selectedIndex = -1;
  double progressValue = 0.40;

  void handleTap(int index) {
    setState(() {
      selectedIndex = selectedIndex == index ? -1 : index;
    });
  }

  Color _getProgressColor(double value) {
    if (value < 0.1) return Colors.red;
    if (value < 0.5) return Color(0xFF1F6FFF);
    if (value < 0.7) return Color(0xFF73BAE7);
    return Colors.green;
  }

  Color _getProgressBackgroundColor(double value) {
    if (value < 0.1) return Colors.purple;
    if (value < 0.5) return Color(0xFF1F6F12);
    if (value < 0.7) return Color(0xFF1F6FFF);
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final progressColor = _getProgressColor(progressValue);
    final getProgressBackgroundColor = _getProgressBackgroundColor(
      progressValue,
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
          child: Column(
            children: [
              Header(
                color: AppColors.grayBlue,
                avatarOnTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyAccountScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 17),
              PercentageWidget(
                progressValue: progressValue,
                color: progressColor,
                backgroundColor: getProgressBackgroundColor,
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  ExpandedContainer(
                    title: AppLocalization.howToInstallEsim,
                    icon: Assets.icons.simIcon.path,
                    onTap: () => handleTap(0),
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
                    onTap: () => openInitialPage(context), // временно меняю чтобы открывало вторую часть фронта 
                  ),
                  const SizedBox(width: 16),
                  ExpandedContainer(
                    title: AppLocalization.countriesAndRates,
                    icon: Assets.icons.globus.path,
                    onTap: () => handleTap(3),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  setState(() {
                    progressValue += 0.1;
                    if (progressValue > 1) progressValue = 0;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: AppColors.containerGradientPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    AppLocalization.topUpBalance,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
