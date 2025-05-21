import 'package:flex_travel_sim/components/widgets/blue_button.dart';
import 'package:flex_travel_sim/components/widgets/go_back_arrow.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/feature/screen143/widgets/steps_container.dart';
import 'package:flutter/material.dart';

class SettingEsimPage extends StatelessWidget {
  const SettingEsimPage({super.key});

  @override
  Widget build(BuildContext context) {
    // FIGMA NUMBER - 143
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 70, 16, 8),
            child: Row(
              children: [
                GoBackArrow(
                  onTap: () => Navigator.pop(context),
                  width: 10,
                  height: 14,
                ),
                  
                Expanded(
                  child: Center(
                    child: HelveticaneueFont(
                      text: 'Гид по настройке eSIM',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      color: Color(0xFF363C45),
                    ),
                  ),
                ),                
              ],
            ),
          ),
      
          const Divider(thickness: 0),

          // body

          SizedBox(height:10),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              children: [
                StepsContainer(
                  iconPath: 'assets/icons/figma143/step1_icon.svg',
                  stepNum: '1',
                  description: 'Пополните баланс в приложении и активируйте eSIM карту',
                ),

                SizedBox(height: 7),

                StepsContainer(
                  iconPath: 'assets/icons/figma143/step2_icon.svg',
                  stepNum: '2',
                  description: 'Настройте профиль в настройках своего телефона',
                ),

                SizedBox(height: 7),

                StepsContainer(
                  iconPath: 'assets/icons/figma143/step3_icon.svg',
                  stepNum: '3',
                  description: 'Готово! Путешествуйте, не беспокоясь за свой интернет!',
                ),                                
              ],
            ),
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
            child: BlueButton(
              buttonText: 'Начать регистрацию',
            ),
          ),


        ],
      ),
    );
  }
}