import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/otp_auth_bloc.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/otp_auth_event.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/otp_auth_state.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/registration_container.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/otp_auth_data_source.dart';

class OtpTile extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback? onTap;
  final VoidCallback? appBarPop;
  final VoidCallback? onSuccess;

  const OtpTile({
    super.key,
    required this.onTap,
    required this.appBarPop,
    required this.phoneNumber,
    this.onSuccess,
  });

  @override
  State<OtpTile> createState() => _OtpTileState();
}

class _OtpTileState extends State<OtpTile> {
  final TextEditingController _pinController = TextEditingController();
  String _otpCode = '';
  late OtpAuthBloc _otpAuthBloc;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: AppColors.backgroundColorLight,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.textColorLight.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(12),
      color: Colors.transparent,
    ),
  );

  bool get _isValidCode => _otpCode.length == 6;

  void _verifyOtp() {
    if (_otpCode.length == 6) {
      _otpAuthBloc.add(
        VerifyOtpEvent(phone: widget.phoneNumber, code: _otpCode),
      );
    }
  }

  void _resendOtp() {
    _otpAuthBloc.add(SendOtpSmsEvent(phone: widget.phoneNumber));
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _otpAuthBloc = OtpAuthBloc(
          otpAuthDataSource: sl.get<OtpAuthDataSource>(),
        );
        return _otpAuthBloc;
      },
      child: Scaffold(
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
        body: BlocConsumer<OtpAuthBloc, OtpAuthState>(
          listener: (context, state) {
            if (state is OtpVerificationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('OTP verified successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              // Call success callback or navigate
              if (widget.onSuccess != null) {
                widget.onSuccess!();
              } else {
                openMainFlowScreen(context);
              }
            } else if (state is OtpAuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is OtpSmsSent) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('OTP resent successfully!'),
                  backgroundColor: Colors.blue,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is OtpVerificationLoading;

            return Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 5,
                bottom: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Введите код подтверждения',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: AppColors.backgroundColorLight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Мы отправили 6-значный код на ${widget.phoneNumber}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textColorLight,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Pinput(
                      controller: _pinController,
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(color: AppColors.accentBlue),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(color: AppColors.accentBlue),
                          color: AppColors.accentBlue.withOpacity(0.1),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _otpCode = value;
                        });
                      },
                      onCompleted: (value) {
                        setState(() {
                          _otpCode = value;
                        });
                        _verifyOtp();
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.accentBlue,
                      ),
                    ),
                  const SizedBox(height: 20),
                  RegistrationContainer(
                    onTap: _isValidCode && !isLoading ? _verifyOtp : null,
                    buttonText: isLoading ? 'Проверка...' : 'Подтвердить код',
                    buttonTextColor:
                        _isValidCode && !isLoading
                            ? AppColors.textColorDark
                            : const Color(0x4DFFFFFF),
                    color:
                        _isValidCode && !isLoading
                            ? const Color(0xFFB3F242)
                            : const Color(0x4D808080),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Не получили код? ",
                        style: TextStyle(
                          color: AppColors.textColorLight,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: state is OtpSmsLoading ? null : _resendOtp,
                        child: Text(
                          'Отправить заново',
                          style: TextStyle(
                            color:
                                state is OtpSmsLoading
                                    ? AppColors.textColorLight.withOpacity(0.5)
                                    : AppColors.accentBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
      ),
    );
  }
}
