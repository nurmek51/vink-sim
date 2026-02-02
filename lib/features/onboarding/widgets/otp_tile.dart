import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/router/app_router.dart';
import 'package:vink_sim/features/auth/domain/repo/auth_repository.dart';
import 'package:vink_sim/shared/widgets/app_notifier.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_bloc.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_event.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_state.dart';
import 'package:vink_sim/features/auth/presentation/widgets/registration_container.dart';
import 'package:vink_sim/config/feature_config.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_event.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_state.dart';

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
  late SubscriberBloc _subscriberBloc;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: AppColors.backgroundColorLight,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.textColorLight.withValues(alpha: 0.3),
      ),
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
    _subscriberBloc = context.read<SubscriberBloc>();

    return BlocProvider(
      create: (context) {
        _otpAuthBloc = OtpAuthBloc(authRepository: sl.get<AuthRepository>());
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
        body: MultiBlocListener(
          listeners: [
            BlocListener<OtpAuthBloc, OtpAuthState>(
              listener: (context, state) async {
                if (state is OtpVerificationSuccess) {
                  AppNotifier.success(
                    SimLocalizations.of(context)!.otp_success,
                  ).showAppToast(context);

                  final authLocalDataSource = sl.get<AuthLocalDataSource>();

                  try {
                    await authLocalDataSource.saveToken(state.token);

                    if (sl.isRegistered<FeatureConfig>()) {
                      final config = sl.get<FeatureConfig>();
                      config.onAuthSuccess?.call(
                        state.token,
                        604800,
                      ); // 1 week default
                    }

                    if (kDebugMode) {
                      print('OTP_TILE: Token saved.');
                    }

                    _subscriberBloc.add(const LoadSubscriberInfoEvent());

                    if (widget.onSuccess != null) {
                      widget.onSuccess!();
                    } else {
                      if (context.mounted) {
                        context.go(AppRoutes.initial);
                      }
                    }
                  } catch (e) {
                    if (kDebugMode) {
                      print('OTP_TILE: Error saving token: $e');
                    }
                  }
                } else if (state is OtpAuthError) {
                  AppNotifier.error(
                    SimLocalizations.of(context)!.otp_fail,
                  ).showAppToast(context);
                  if (kDebugMode) print(state.message);
                } else if (state is OtpSmsSent) {
                  AppNotifier.info(
                    SimLocalizations.of(context)!.otp_resent,
                  ).showAppToast(context);
                }
              },
            ),
            BlocListener<SubscriberBloc, SubscriberState>(
              listener: (context, state) {
                if (state is SubscriberLoaded) {
                  if (kDebugMode) {
                    print(
                      'User info loaded! Balance: ${state.subscriber.balance}',
                    );
                  }
                } else if (state is SubscriberError) {
                  if (kDebugMode) {
                    print('Failed to load user info: ${state.message}');
                  }
                }
              },
            ),
          ],
          child: BlocBuilder<OtpAuthBloc, OtpAuthState>(
            builder: (context, otpState) {
              return BlocBuilder<SubscriberBloc, SubscriberState>(
                builder: (context, subscriberState) {
                  final isLoading =
                      otpState is OtpVerificationLoading ||
                      subscriberState is SubscriberLoading;

                  return _buildBody(context, otpState, isLoading);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    OtpAuthState otpState,
    bool isLoading,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          LocalizedText(
            SimLocalizations.of(context)!.enter_verification_code,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.backgroundColorLight,
            ),
          ),
          const SizedBox(height: 16),
          LocalizedText(
            SimLocalizations.of(
              context,
            )!.sended_six_digit_code(widget.phoneNumber),
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
                  color: AppColors.accentBlue.withValues(alpha: 0.1),
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
            const Center(child: CircularProgressIndicator(color: Colors.grey)),
          const SizedBox(height: 20),
          RegistrationContainer(
            onTap: _isValidCode && !isLoading ? _verifyOtp : null,
            buttonText:
                isLoading
                    ? SimLocalizations.of(context)!.loading
                    : SimLocalizations.of(context)!.confirm_code,
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
              LocalizedText(
                SimLocalizations.of(context)!.did_not_receive_the_code,
                style: TextStyle(color: AppColors.textColorLight, fontSize: 16),
              ),
              TextButton(
                onPressed: otpState is OtpSmsLoading ? null : _resendOtp,
                child: LocalizedText(
                  SimLocalizations.of(context)!.send_again,
                  style: TextStyle(
                    color:
                        otpState is OtpSmsLoading
                            ? AppColors.textColorLight.withValues(alpha: 0.5)
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
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: widget.onTap,
                child: LocalizedText(
                  SimLocalizations.of(context)!.login_another_way,
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
