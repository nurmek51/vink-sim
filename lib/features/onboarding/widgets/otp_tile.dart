import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/features/authentication/presentation/bloc/confirm_number_bloc.dart';
import 'package:flex_travel_sim/features/authentication/widgets/registration_container.dart';
import 'package:flex_travel_sim/features/onboarding/auth_by_email/presentation/bloc/confirm_email_bloc.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/pin_code_field.dart';
import 'package:flex_travel_sim/features/onboarding/widgets/resend_code_timer.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpTile extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback? onTap;
  final VoidCallback? appBarPop;

  const OtpTile({
    super.key,
    required this.onTap,
    required this.appBarPop,
    required this.phoneNumber,
  });

  @override
  State<OtpTile> createState() => _OtpTileState();
}

class _OtpTileState extends State<OtpTile> {
  String _pinCode = '';
  bool _isLoading = false;

  bool get _isValidCode => _pinCode.length == 6;

  void _onCodeChanged(String code) {
    setState(() {
      _pinCode = code;
    });
  }

  void _onCodeCompleted(String code) {
    setState(() {
      _pinCode = code;
    });
  }

  // To use it for confirm email uncode this !!!

  // void _confirmCode() {
  //   context.read<ConfirmEmailBloc>().add(ConfirmEmailSubmitted(_pinCode));
  // }


  // For confirm number use this !!!

  void _confirmCode() {
    context.read<ConfirmNumberBloc>().add(ConfirmNumberSubmitted(_pinCode));
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColorDark,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.backgroundColorLight,
          ),
          onPressed: widget.appBarPop,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      
      // ConfirmEmailBloc for email !!

      body: BlocConsumer<ConfirmNumberBloc, ConfirmNumberState>(
        listener: (context, state) {
          if (state is ConfirmNumberSuccess) {
            openMainFlowScreen(context);
          } else if (state is ConfirmNumberFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          // _isLoading = state is ConfirmEmailLoading;
          
          _isLoading = state is ConfirmNumberLoading;
          return Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 5,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Введите код',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: AppColors.backgroundColorLight,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Мы отправили сообщение с кодом на номер',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.backgroundColorLight,
                  ),
                ),
                Text(
                  widget.phoneNumber,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.backgroundColorLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Введите код в поле ниже',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.backgroundColorLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                PinCodeField(
                  onChanged: _onCodeChanged,
                  onCompleted: _onCodeCompleted,
                ),
                const SizedBox(height: 20),
                RegistrationContainer(
                  onTap: _isValidCode && !_isLoading ? _confirmCode : null,
                  buttonText: _isLoading ? 'Проверка...' : 'Подтвердить код',
                  buttonTextColor:
                      _isValidCode && !_isLoading
                          ? AppColors.textColorDark
                          : const Color(0x4DFFFFFF),
                  color:
                      _isValidCode && !_isLoading
                          ? const Color(0xFFB3F242)
                          : const Color(0x4D808080),
                ),
                const SizedBox(height: 20),
                const ResendCodeTimer(),
                const Spacer(),
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
                      child: const Text(
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
        },
      ),
    );
  }
}
