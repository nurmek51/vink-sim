import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/core/layout/screen_utils.dart';
import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/features/dashboard/widgets/bottom_sheet_content.dart';
import 'package:vink_sim/features/dashboard/widgets/expanded_container.dart';
import 'package:vink_sim/features/onboarding/widgets/benefit_tile.dart';
import 'package:vink_sim/features/onboarding/widgets/pulsing_circle.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_event.dart';

class EsimEntryScreen extends StatefulWidget {
  const EsimEntryScreen({super.key});

  @override
  State<EsimEntryScreen> createState() => _EsimEntryScreenState();
}

class _EsimEntryScreenState extends State<EsimEntryScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  static const Duration _animationDuration = Duration(seconds: 3);
  static const double _circleSize = 600;

  @override
  void initState() {
    super.initState();
    // Load subscriber info to determine if the user needs to purchase or top-up
    final subscriberBloc = context.read<SubscriberBloc>();
    if (subscriberBloc.state is SubscriberInitial) {
      subscriberBloc.add(const LoadSubscriberInfoEvent());
    }

    _controller = AnimationController(vsync: this, duration: _animationDuration)
      ..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            right: -_circleSize / 2,
            top:
                MediaQuery.of(context).size.height * 0.25 / 2 - _circleSize / 2,
            child: PulsingCircle(animation: _scaleAnimation, size: _circleSize),
          ),
          Positioned(
            left: -_circleSize / 2,
            top: MediaQuery.of(context).size.height * 0.43 - _circleSize / 2,
            child: PulsingCircle(animation: _scaleAnimation, size: _circleSize),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 8),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      Row(
                        children: [
                          Transform.translate(
                            offset: const Offset(-10, 5),
                            child: Assets.icons.figma149.whiteLogo.image(
                              width: 66,
                              height: 50,
                              package: AssetUtils.package,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => openTariffsAndCountriesPage(context),
                            child: Assets.icons.figma149.moneyIcon.svg(
                              width: 28,
                              height: 30,
                            ),
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                            onTap: () => openMyAccountScreen(context),
                            child: Assets.icons.figma149.profileIcon.svg(
                              width: 28,
                              height: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: HelveticaneueFont(
                          text: SimLocalizations.of(context)!.frame_title,
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      BenefitTile(
                        icon: Assets.icons.figma149.column1.path,
                        title:
                            SimLocalizations.of(context)!.countries_in_one_esim,
                      ),
                      SizedBox(height: 12),
                      BenefitTile(
                        icon: Assets.icons.figma149.column2.path,
                        title: SimLocalizations.of(context)!.frame_check_title,
                      ),
                      SizedBox(height: 12),
                      BenefitTile(
                        icon: Assets.icons.figma149.column3.path,
                        title: SimLocalizations.of(context)!.infinity_title,
                      ),
                      SizedBox(height: 12),
                      BenefitTile(
                        icon: Assets.icons.figma149.column4.path,
                        title:
                            SimLocalizations.of(context)!.high_speed_low_cost,
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 450),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 5, 16, 30),
                      child: isEsimEntryScreenScrollable(context)
                          ? SingleChildScrollView(
                              child: BuildContainerBody(),
                            )
                          : BuildContainerBody(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BuildContainerBody extends StatelessWidget {
  const BuildContainerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final subscriberState = context.watch<SubscriberBloc>().state;
    final bool hasEsim = subscriberState is SubscriberLoaded &&
        subscriberState.subscriber.imsiList.isNotEmpty;

    return Column(
      children: [
        const SizedBox(height: 25),
        Row(
          children: [
            if (hasEsim) ...[
              ExpandedContainer(
                title: SimLocalizations.of(context)!.how_to_install_esim2,
                icon: Assets.icons.figma149.blueIcon11.path,
                onTap: () => openEsimSetupPage(context),
              ),
              const SizedBox(width: 16),
            ],
            ExpandedContainer(
              title: SimLocalizations.of(context)!.support_chat,
              icon: Assets.icons.figma149.blueIcon22.path,
              onTap: () {
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
                );
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            ExpandedContainer(
              title: SimLocalizations.of(context)!.how_does_it_work,
              icon: Assets.icons.figma149.blueIcon33.path,
              onTap: () => openGuidePage(context),
            ),
            const SizedBox(width: 16),
            ExpandedContainer(
              title: SimLocalizations.of(context)!.countries_and_rates,
              icon: Assets.icons.figma149.blueIcon44.path,
              onTap: () => openTariffsAndCountriesPage(context),
            ),
          ],
        ),
        isEsimEntryScreenScrollable(context)
            ? const SizedBox(height: 20)
            : Spacer(),
        GestureDetector(
          onTap: () {
            if (hasEsim) {
              // If user has eSIM, go to top-up with existing IMSI
              final firstImsi = (subscriberState as SubscriberLoaded)
                  .subscriber
                  .imsiList
                  .first
                  .imsi;
              openTopUpBalanceScreen(context, imsi: firstImsi);
            } else {
              // If user hasn't eSIM, go to top-up screen in "New eSIM" mode
              // which will trigger the /purchase API instead of /top-up
              openTopUpBalanceScreen(context, isNewEsim: true);
            }
          },
          child: Container(
            alignment: Alignment.center,
            height: 52,
            decoration: BoxDecoration(
              gradient: AppColors.containerGradientPrimary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: LocalizedText(
              SimLocalizations.of(context)!.activate_esim,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
