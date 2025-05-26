import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/feature/auth_screen/widgets/registration_container.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/pin_code_field.dart';
import 'package:flex_travel_sim/feature/welcome_screen/widgets/resend_code_timer.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class OtpTile extends StatelessWidget {
  final VoidCallback? onTap;
  const OtpTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Введите код',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: AppColors.backgroundColorLight,
            ),
          ),
          SizedBox(height: 10),
          const Text(
            'Мы отправили сообщение с кодом на номер',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.backgroundColorLight,
            ),
          ),
          const Text(
            '+7 (700) 000 000',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.backgroundColorLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          const Text(
            'ВВедите код в поле ниже',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.backgroundColorLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          PinCodeField(),
          const SizedBox(height: 20),
          RegistrationContainer(
            onTap: () => openMainFlowScreen(context),
            buttonText: 'Подтвердить код',
            buttonTextColor: AppColors.textColorDark,
            color: const Color(0xFFB3F242),
          ),
          const SizedBox(height: 20),
          ResendCodeTimer(),
          Spacer(),
          Center(
            child: Container(
              height: 40,
              width: 231,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  'Войти другим способом',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textColorLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
