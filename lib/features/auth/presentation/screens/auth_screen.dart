import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/core/router/app_router.dart';
import 'package:vink_sim/features/auth/presentation/widgets/registration_container.dart';
import 'package:go_router/go_router.dart';
import 'package:vink_sim/features/auth/presentation/widgets/mobile_number_field.dart';
import 'package:vink_sim/features/onboarding/widgets/pulsing_circle.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_bloc.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_event.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  String _phoneNumber = '';
  final TextEditingController _otpController = TextEditingController();

  static const Duration _animationDuration = Duration(seconds: 3);
  static const double _circleSize = 600;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _animationDuration)
      ..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _showOtpInput(BuildContext blocContext, String phone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter OTP sent to $phone',
                  style: FlexTypography.headline.medium.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'OTP Code',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.accentBlue),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                RegistrationContainer(
                  buttonText: 'Verify',
                  color: AppColors.accentBlue,
                  buttonTextColor: AppColors.backgroundColorLight,
                  onTap: () {
                    blocContext.read<OtpAuthBloc>().add(
                      VerifyOtpEvent(phone: phone, code: _otpController.text),
                    );
                    Navigator.pop(context); // Close sheet
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => sl<OtpAuthBloc>(),
      child: BlocConsumer<OtpAuthBloc, OtpAuthState>(
        listener: (context, state) {
          if (state is OtpSmsSent) {
            _showOtpInput(context, state.phone);
          } else if (state is OtpVerificationSuccess) {
            context.go(AppRoutes.mainFlow);
          } else if (state is OtpAuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: [
                FrameContent(
                  circleSize: _circleSize,
                  mediaHeight: mediaHeight,
                  scaleAnimation: _scaleAnimation,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 10,
                    bottom: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(), // Push content down or adjust layout
                      const SizedBox(height: 30),
                      LocalizedText(
                        SimLocalizations.of(context)?.auth_with_the_help_of ??
                            'Login with:', // Safe fallback
                        style: FlexTypography.headline.large.copyWith(
                          color: AppColors.backgroundColorLight,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            SimLocalizations.of(context)?.whats_app ??
                                'WhatsApp',
                            style: FlexTypography.headline.large.copyWith(
                              color: AppColors.whatsAppColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            Assets.icons.whatsappIcon.path,
                            package: AssetUtils.package,
                            colorFilter: const ColorFilter.mode(
                              AppColors.whatsAppColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LocalizedText(
                        SimLocalizations.of(
                              context,
                            )?.mobile_num_whats_app_description ??
                            'We will send a code to your WhatsApp',
                        style: FlexTypography.paragraph.medium.copyWith(
                          color: AppColors.backgroundColorLight,
                        ),
                      ),

                      const SizedBox(height: 20),

                      MobileNumberField(
                        onChanged: (fullNumber, formatted) {
                          _phoneNumber = fullNumber;
                        },
                      ),

                      const SizedBox(height: 20),

                      if (state is OtpSmsLoading ||
                          state is OtpVerificationLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        RegistrationContainer(
                          onTap: () {
                            if (_phoneNumber.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter phone number'),
                                ),
                              );
                              return;
                            }
                            context.read<OtpAuthBloc>().add(
                              SendOtpSmsEvent(phone: _phoneNumber),
                            );
                          },
                          buttonText:
                              SimLocalizations.of(
                                context,
                              )?.auth_and_registration ??
                              'Continue',
                          buttonTextColor: AppColors.backgroundColorLight,
                          color: AppColors.accentBlue,
                          arrowForward: true,
                        ),

                      const SizedBox(height: 50),
                    ],
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

class FrameContent extends StatelessWidget {
  const FrameContent({
    super.key,
    required double circleSize,
    required this.mediaHeight,
    required Animation<double> scaleAnimation,
  }) : _circleSize = circleSize,
       _scaleAnimation = scaleAnimation;

  final double _circleSize;
  final double mediaHeight;
  final Animation<double> _scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -_circleSize / 2,
          top: mediaHeight / 2 - _circleSize / 2,
          child: PulsingCircle(animation: _scaleAnimation, size: _circleSize),
        ),

        Positioned(
          left: -_circleSize / 2,
          bottom: -_circleSize / 2,
          child: PulsingCircle(animation: _scaleAnimation, size: _circleSize),
        ),
      ],
    );
  }
}
