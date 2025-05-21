import 'package:flex_travel_sim/components/widgets/blue_button.dart';
import 'package:flex_travel_sim/components/widgets/go_back_arrow.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/feature/screen112/widgets/lazy_row.dart';
import 'package:flex_travel_sim/feature/screen112/widgets/setup_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EsimSetupPage extends StatefulWidget {
  const EsimSetupPage({super.key});

  @override
  State<EsimSetupPage> createState() => _EsimSetupPageState();
}

class _EsimSetupPageState extends State<EsimSetupPage> {
  String selected = 'Быстрая'; // по умолчанию

  @override
  Widget build(BuildContext context) {
    // FIGMA NUMBER - 112
    return Scaffold(
      backgroundColor: Color(0xFFE7EFF7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // body
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 70, 16, 40),
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
                      text: 'Установка eSIM',
                      fontSize: 28,
                      letterSpacing: -1,
                      height: 1.1,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF363C45),
                    ),
              
                    SizedBox(height: 20),
              
                    // Scrollable element
                    LazyRow(
                      selected: selected,
                      onSelected: (value) {
                        setState(() {
                          selected = value;
                        });
                      },
                    ),
              
                    // BODY
                    if (selected == 'Быстрая') ...[
                      SizedBox(height: 25),
                      SetupBody(),
                    ] else  ...[
                      Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: Text(
                          'Coming soon',
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

            if (selected == 'Быстрая') ...[
              SizedBox(height: 10),
              Container(
                height: 499,
                width: 395,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/figma112/success_icon.svg',
                          width: 45,
                          height: 52,
                        ),
                        SizedBox(height: 15),
                        HelveticaneueFont(
                          text: 'Готово!',
                          fontSize: 18, 
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: HelveticaneueFont(
                            text: 'Процесс подключения может\nдлиться от 1 минуты до часа.',
                            fontSize: 16, 
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20), 
                        Center(
                          child: HelveticaneueFont(
                            text: 'В случае проблем с подключением –\nвключите “Авиарежим ✈” на 10 секунд и\nпопробуйте еще раз.',
                            textAlign: TextAlign.center,
                            fontSize: 16, 
                            color: Color(0xFF7D7D7D),
                            fontWeight: FontWeight.w500,
                          ),
                        ), 
                        SizedBox(height: 30), 
                        BlueButton(buttonText: 'Закрыть'),  
                        SizedBox(height: 30),
                        Container(
                          width: 126,
                          height: 31,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFE7EFF7),
                          ),
                          child: Center(
                            child: HelveticaneueFont(
                              text: 'Чат поддержки',
                              fontSize: 14,
                              color: Color(0xFF1F6FFF),
                            ),
                          ),
                        ),                                          
                  
                      ],
                    ),
                  ),
                ),
              ),
            ],
            
          ],
        ),
      ),
    );
  }
}