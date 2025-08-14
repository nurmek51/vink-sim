import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/platform_device/platform_detector.dart';
import 'package:flex_travel_sim/features/esim_management/bloc/esim_setup_bloc.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/another_device_selected_body.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/bottom_setup_container.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/lazy_row.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/fast_selected_body.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/manual_selected_body.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/qr_code_selected_body.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EsimSetupPage extends StatelessWidget {
  const EsimSetupPage({super.key});

  List<String> getRowOptions() {
    if (PlatformDetector.isIos) {
      return [
        AppLocalizations.fastSelectedRow,
        AppLocalizations.qrCodeSelectedRow,
        AppLocalizations.manualSelectedRow,
        AppLocalizations.toAnotherDeviceSelectedRow,
      ];
    }
    return [
      AppLocalizations.qrCodeSelectedRow,
      AppLocalizations.manualSelectedRow,
      AppLocalizations.toAnotherDeviceSelectedRow,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final options = getRowOptions();
    // final showFast = PlatformDetector.isIos;

    if (kDebugMode) {
      print(PlatformDetector.platformLog);
    }
    return BlocProvider(
      create: (_) => EsimSetupBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xFFD0DEEB),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100,
              pinned: true,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              leading: Transform.translate(
                offset: const Offset(-12, 0),
                child: BackButton(
                  color: Colors.black,
                  onPressed: () => NavigationService.pop(context),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: const EdgeInsets.only(bottom: 16),
                expandedTitleScale: 1.4,
                title: HelveticaneueFont(
                  text: AppLocalizations.installEsim,
                  fontSize: 20,
                  letterSpacing: -0.5,
                  height: 1.1,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF363C45),
                ),
                background: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: safePaddingArea(context) + 56,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 40,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      BlocBuilder<EsimSetupBloc, EsimSetupState>(
                        builder: (context, state) {
                          return Center(
                            child: LazyRow(
                              selectedIndex: state.selectedIndex,
                              options: options,
                              onSelectedIndex: (index) {
                                context.read<EsimSetupBloc>().add(
                                  SelectOption(index),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      BlocBuilder<EsimSetupBloc, EsimSetupState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              const SizedBox(height: 25),
                              _buildSelectedBody(options[state.selectedIndex]),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Column(
                children: [SizedBox(height: 16), BottomSetupContainer()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSelectedBody(String option) {
  switch (option) {
    case AppLocalizations.fastSelectedRow:
      return const FastSelectedBody();
    case AppLocalizations.qrCodeSelectedRow:
      return const QrCodeSelectedBody();
    case AppLocalizations.manualSelectedRow:
      return const ManualSelectedBody();
    case AppLocalizations.toAnotherDeviceSelectedRow:
      return const AnotherDeviceSelectedBody();
    default:
      return const SizedBox.shrink();
  }
}