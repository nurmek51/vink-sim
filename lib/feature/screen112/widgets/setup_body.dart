import 'package:flex_travel_sim/components/widgets/blue_button.dart';
import 'package:flex_travel_sim/feature/screen112/widgets/body_container.dart';
import 'package:flutter/material.dart';

class SetupBody extends StatelessWidget {
  const SetupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyContainer(
          stepNum: '1', 
          description: 'Нажмите “Установить” и разрешите доступ к профилям на своем устройстве',
          widgth: 354,
          height: 220,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: BlueButton(buttonText: 'Установить'),
          ),
        ),
    
        SizedBox(height: 15),
    
        BodyContainer(
          stepNum: '2', 
          description: 'Выберите “Основной” для номера по умолчанию и для “iMessage и Facetime”',
          widgth: 354,
          height: 438,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/icons/figma112/step2_112_1.jpg',
                          width: 271.59,
                          height: 287.61,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/icons/figma112/step2_112_2.jpg',
                          width: 271.59,
                          height: 287.61,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),                      
                    ],
                  ),
                ),
              ),
            ),
        ),
    
        SizedBox(height: 15),
    
        BodyContainer(
          stepNum: '3', 
          description: 'Выберите недавно добавленный план eSIM для передачи сотовых данных',
          widgth: 354,
          height: 438,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/icons/figma112/step3_jpg_112.jpg',
                      width: 313,
                      height: 292,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    
        SizedBox(height: 15),
    
        BodyContainer(
          stepNum: '4', 
          description: 'Зайдите в Настройки > Сотовая связь > Flex eSIM.\n\nВключите “Роуминг данных”',
          widgth: 354,
          height: 470,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/icons/figma112/step4_jpg_112.jpg',
                  width: 274.8,
                  height: 291,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),
    
        SizedBox(height: 15),
                 
      ],
    );
  }
}