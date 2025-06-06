import 'package:flex_travel_sim/components/widgets/go_back_arrow.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/lazy_row.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/fast_selected_body.dart';
import 'package:flex_travel_sim/features/screen112/widgets/body/another_device_selected_body.dart';
import 'package:flex_travel_sim/features/screen112/widgets/body/manual_selected_body.dart';
import 'package:flex_travel_sim/features/screen112/widgets/body/qr_code_selected_body.dart';
import 'package:flex_travel_sim/features/screen112/widgets/bottom_setup_container.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class EsimSetupPage extends StatefulWidget {
  const EsimSetupPage({super.key});

  @override
  State<EsimSetupPage> createState() => _EsimSetupPageState();
}

class _EsimSetupPageState extends State<EsimSetupPage> {
  int selectedIndex = 0; // по умолчанию

  final List<String> rowOptions = [
    AppLocalization.fastSelectedRow,
    AppLocalization.qrCodeSelectedRow,
    AppLocalization.manualSelectedRow,
    AppLocalization.toAnotherDeviceSelectedRow,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Center(
                        child: LazyRow(
                          selectedIndex: selectedIndex,
                          options: rowOptions,
                          onSelectedIndex: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                      ),

                      // BODY
                      if (selectedIndex == 0) ...[
                        const SizedBox(height: 25),
                        const FastSelectedBody(),
                      ] else if (selectedIndex == 1) ...[
                        const SizedBox(height: 25),
                        const QrCodeSelectedBody(),
                      ] else if (selectedIndex == 2) ...[
                        const SizedBox(height: 25),
                        const ManualSelectedBody(),
                      ] else if (selectedIndex == 3) ...[
                        const SizedBox(height: 25),
                        const AnotherDeviceSelectedBody(),
                      ],
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
    );
  }
}
