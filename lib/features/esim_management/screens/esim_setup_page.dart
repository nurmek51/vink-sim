import 'package:flex_travel_sim/components/widgets/go_back_arrow.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/esim_management/cubit/esim_setup_cubit.dart';
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
    AppLocalization.fastSelectedRow,
    AppLocalization.qrCodeSelectedRow,
    AppLocalization.manualSelectedRow,
    AppLocalization.toAnotherDeviceSelectedRow,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EsimSetupCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE7EFF7),
        body: SingleChildScrollView(
          child: SafeArea(
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
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoBackArrow(
                          width: 15,
                          height: 19,
                          onTap: () => NavigationService.pop(context),
                        ),
                        const SizedBox(height: 20),
                        HelveticaneueFont(
                          text: AppLocalization.installESim,
                          fontSize: 28,
                          letterSpacing: -1,
                          height: 1.1,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF363C45),
                        ),
                        const SizedBox(height: 20),
                        // Scrollable element
                        BlocBuilder<EsimSetupCubit, EsimSetupState>(
                          builder: (context, state) {
                            return Center(
                              child: LazyRow(
                                selectedIndex: state.selectedIndex,
                                options: rowOptions,
                                onSelectedIndex: (index) {
                                  context.read<EsimSetupCubit>().selectOption(
                                    index,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        // BODY
                        BlocBuilder<EsimSetupCubit, EsimSetupState>(
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
                // end line
                const SizedBox(height: 20),
                const BottomSetupContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
