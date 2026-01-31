import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/features/onboarding/models/confirm_method.dart';
import 'package:vink_sim/features/auth/domain/repo/auth_repository.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_bloc.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_event.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_state.dart';
import 'package:vink_sim/shared/widgets/app_notifier.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/features/auth/presentation/widgets/mobile_number_field.dart';
import 'package:vink_sim/features/auth/presentation/widgets/registration_container.dart';
import 'package:vink_sim/features/auth/domain/entities/country.dart';
import 'package:vink_sim/features/auth/data/country_data.dart';
import 'package:vink_sim/features/auth/utils/phone_utils.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:flutter_svg/svg.dart';

class WhatsappTile extends StatefulWidget {
  final void Function(String, ConfirmMethod, [String?, Country?]) onNext;
  final VoidCallback appBarPop;
  final VoidCallback onEmailTap;
  final String? initialPhoneDigits;
  final Country? initialCountry;

  const WhatsappTile({
    super.key,
    required this.onNext,
    required this.appBarPop,
    required this.onEmailTap,
    this.initialPhoneDigits,
    this.initialCountry,
  });

  @override
  State<WhatsappTile> createState() => _WhatsappTileState();
}

class _WhatsappTileState extends State<WhatsappTile> {
  String _phoneDigits = '';
  String formattedPhone = '';
  Country _selectedCountry = CountryData.defaultCountry;

  @override
  void initState() {
    super.initState();
    if (widget.initialCountry != null) {
      _selectedCountry = widget.initialCountry!;
    }
    if (widget.initialPhoneDigits != null) {
      _phoneDigits = widget.initialPhoneDigits!;
      final phoneWithoutDialCode =
          _phoneDigits.startsWith(_selectedCountry.dialCode)
              ? _phoneDigits.substring(_selectedCountry.dialCode.length)
              : _phoneDigits;
      formattedPhone = phoneWithoutDialCode;
    }
  }

  bool get _isValidPhone {
    if (_phoneDigits.isEmpty) return false;
    return _phoneDigits.length >= 7;
  }

  void _onPhoneChanged(String digits, String formatted) {
    setState(() {
      _phoneDigits = digits;
      formattedPhone = formatted;
    });
  }

  void _onCountryChanged(Country country) {
    setState(() {
      _selectedCountry = country;
    });
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
      body: BlocProvider<OtpAuthBloc>(
        create:
            (context) => OtpAuthBloc(authRepository: sl.get<AuthRepository>()),
        child: BlocConsumer<OtpAuthBloc, OtpAuthState>(
          listener: (context, state) {
            if (state is OtpSmsSent) {
              widget.onNext(
                state.phone,
                ConfirmMethod.byPhone,
                _phoneDigits,
                _selectedCountry,
              );
            } else if (state is OtpAuthError) {
              AppNotifier.error(
                SimLocalizations.of(context)!.send_error,
              ).showAppToast(context);
              if (kDebugMode) print(state.message);
            }
          },
          builder: (context, state) {
            final isLoading = state is OtpSmsLoading;

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
                  LocalizedText(
                    SimLocalizations.of(context)!.auth_with_the_help_of,
                    style: FlexTypography.headline.large.copyWith(
                      color: AppColors.backgroundColorLight,
                    ),
                  ),
                  Row(
                    children: [
                      LocalizedText(
                        SimLocalizations.of(context)!.whats_app,

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
                    )!.mobile_num_whats_app_description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.backgroundColorLight,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MobileNumberField(
                    onChanged: _onPhoneChanged,
                    onCountryChanged: _onCountryChanged,
                    initialCountry: _selectedCountry,
                    initialPhone: formattedPhone,
                  ),
                  const SizedBox(height: 20),
                  RegistrationContainer(
                    onTap: () {
                      if (!_isValidPhone || isLoading) {
                        return;
                      }

                      final internationalNumber =
                          PhoneUtils.getInternationalNumber(
                            _phoneDigits,
                            _selectedCountry,
                          );
                      context.read<OtpAuthBloc>().add(
                        SendOtpSmsEvent(phone: internationalNumber),
                      );
                    },
                    buttonText:
                        SimLocalizations.of(context)!.auth_and_registration,
                    buttonTextColor:
                        _isValidPhone
                            ? AppColors.backgroundColorLight
                            : const Color(0x4DFFFFFF),
                    color:
                        _isValidPhone
                            ? AppColors.accentBlue
                            : const Color(0x4D808080),
                    arrowForward: _isValidPhone,
                  ),
                  // const Spacer(),
                  // RegistrationContainer(
                  //   onTap: widget.onEmailTap,
                  //   buttonText: AppLocalizations.continueWithEmail,
                  //   buttonTextColor: AppColors.textColorLight,
                  //   color: AppColors.babyBlue,
                  //   iconPath: Assets.icons.emailLogo.path,
                  // ),
                  // SizedBox(height: 35),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
