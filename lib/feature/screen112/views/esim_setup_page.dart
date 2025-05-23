import 'package:flex_travel_sim/components/widgets/blue_button.dart';
import 'package:flex_travel_sim/components/widgets/go_back_arrow.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/main_flow_screen/bottom_sheet_content.dart';
import 'package:flex_travel_sim/feature/screen112/widgets/lazy_row.dart';
import 'package:flex_travel_sim/feature/screen112/widgets/setup_body.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EsimSetupPage extends StatefulWidget {
  const EsimSetupPage({super.key});

  @override
  State<EsimSetupPage> createState() => _EsimSetupPageState();
}

class _EsimSetupPageState extends State<EsimSetupPage> {
  String selected = AppLocalization.fastSelectedRow; // по умолчанию

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
                  borderRadius: BorderRadius.circular(16),
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
                          selected: selected,
                          onSelected: (value) {
                            setState(() {
                              selected = value;
                            });
                          },
                        ),
                      ),
                
                      // BODY
                      if (selected == AppLocalization.fastSelectedRow) ...[
                        SizedBox(height: 25),
                        SetupBody(),
                      ] else  ...[
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
              SizedBox(height:10),
          
              if (selected == AppLocalization.fastSelectedRow) ...[
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 20),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/figma112/success_icon.svg',
                          width: 45,
                          height: 52,
                        ),
                        SizedBox(height: 15),
                        HelveticaneueFont(
                          text: AppLocalization.successMessage,
                          fontSize: 18, 
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 20),
                        HelveticaneueFont(
                          text: AppLocalization.connectionWaitMessage,
                          fontSize: 16, 
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 20), 
                        HelveticaneueFont(
                          text: AppLocalization.connectionRetryInstruction,
                          textAlign: TextAlign.center,
                          fontSize: 16, 
                          color: Color(0xFF7D7D7D),
                          fontWeight: FontWeight.w500,
                        ), 
                        SizedBox(height: 30), 
                        GestureDetector(
                          onTap: () => openMainFlowScreen(context),
                          child: BlueButton(buttonText: AppLocalization.close),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
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
                                          MediaQuery.of(
                                            context,
                                          ).viewInsets.bottom,
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: BottomSheetContent(),
                                    ),
                                  ),
                            );
                          },
                          child: Container(
                            width: 126,
                            height: 31,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFE7EFF7),
                            ),
                            child: Center(
                              child: HelveticaneueFont(
                                text: AppLocalization.supportChat2,
                                fontSize: 14,
                                color: Color(0xFF1F6FFF),
                              ),
                            ),
                          ),
                        ),                                          
                  
                      ],
                    ),
                  ),
                ),
              ],
              
            ],
          ),
        ),
      ),
    );
  }
}