import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/features/auth_screen/widgets/registration_container.dart';
import 'package:flex_travel_sim/features/welcome_screen/widgets/pin_code_field.dart';
import 'package:flex_travel_sim/features/welcome_screen/widgets/resend_code_timer.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class OtpTile extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback? onTap;
  final VoidCallback? appBarPop;
  const OtpTile({super.key, required this.onTap, required this.appBarPop, required this.phoneNumber});

  @override
  State<OtpTile> createState() => _OtpTileState();
}

class _OtpTileState extends State<OtpTile> {
  String _pinCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColorDark,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.backgroundColorLight),
          onPressed: widget.appBarPop,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 8),
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
            Text(
              widget.phoneNumber,
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
            PinCodeField(
              onChanged: (pinCode) {
                setState(() {
                  _pinCode = pinCode;
                });
              },
            ),
            const SizedBox(height: 20),
            RegistrationContainer(
              onTap: _pinCode.length == 6 ? () => openMainFlowScreen(context) : null, 
              buttonText: 'Подтвердить код',
              buttonTextColor: _pinCode.length == 6 ? AppColors.textColorDark : Color(0x4DFFFFFF),
              color:  _pinCode.length == 6 ? const Color(0xFFB3F242) : Color(0x4D808080),
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
                  onTap: widget.onTap,
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
      ),
    );
  }
}
