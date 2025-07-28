import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/esim_management/bloc/esim_setup_bloc.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/another_device_selected_body.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/bottom_setup_container.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/lazy_row.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/fast_selected_body.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/manual_selected_body.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/qr_code_selected_body.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EsimSetupPage extends StatelessWidget {
  const EsimSetupPage({super.key});

  static const List<String> rowOptions = [
    AppLocalizations.fastSelectedRow,
    AppLocalizations.qrCodeSelectedRow,
    AppLocalizations.manualSelectedRow,
    AppLocalizations.toAnotherDeviceSelectedRow,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EsimSetupBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xFFD0DEEB),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // body
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: safePaddingArea(context),
                    bottom: 40,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(-12, 0),
                        child: BackButton(
                          color: Colors.black,
                          onPressed: () => NavigationService.pop(context),
                        ),
                      ),

                      const SizedBox(height: 20),
                      HelveticaneueFont(
                        text: AppLocalizations.installEsim,
                        fontSize: 28,
                        letterSpacing: -1,
                        height: 1.1,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF363C45),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<EsimSetupBloc, EsimSetupState>(
                        builder: (context, state) {
                          return Center(
                            child: LazyRow(
                              selectedIndex: state.selectedIndex,
                              options: rowOptions,
                              onSelectedIndex: (index) {
                                context.read<EsimSetupBloc>().add(
                                  SelectOption(index),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      // BODY
                      BlocBuilder<EsimSetupBloc, EsimSetupState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              const SizedBox(height: 25),
                              if (state.selectedIndex == 0)
                                const FastSelectedBody()
                              else if (state.selectedIndex == 1)
                                const QrCodeSelectedBody()
                              else if (state.selectedIndex == 2)
                                const ManualSelectedBody()
                              else if (state.selectedIndex == 3)
                                const AnotherDeviceSelectedBody(),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const BottomSetupContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
