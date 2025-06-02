import 'package:flex_travel_sim/components/widgets/go_back_arrow.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/screen112/widgets/body/another_device_selected_body.dart';
import 'package:flex_travel_sim/feature/screen112/widgets/bottom_setup_container.dart';
import 'package:flex_travel_sim/feature/screen112/widgets/lazy_row.dart';
import 'package:flex_travel_sim/feature/screen112/widgets/body/fast_selected_body.dart';
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
    // FIGMA NUMBER - 112
    return Scaffold(
      backgroundColor: Color(0xFFE7EFF7),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // body
              Container(
                decoration: BoxDecoration(
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
                        onTap: () => Navigator.pop(context),
                      ),

                      SizedBox(height: 20),

                      HelveticaneueFont(
                        text: AppLocalization.installESim,
                        fontSize: 28,
                        letterSpacing: -1,
                        height: 1.1,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF363C45),
                      ),

                      SizedBox(height: 20),

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
                        SizedBox(height: 25),
                        FastSelectedBody(),
                      ]
                      
                      else if (selectedIndex == 3) ...[
                        SizedBox(height: 25),
                        AnotherDeviceSelectedBody(),
                      ]                      

                       else ...[
                        Container(
                          height: 300,
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalization.comingSoon,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // end line
              SizedBox(height: 20),
              BottomSetupContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
