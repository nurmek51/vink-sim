import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/credentials.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/mobile_number_field.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/registration_container.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/country.dart';
import 'package:flex_travel_sim/features/auth/data/country_data.dart';
import 'package:flex_travel_sim/features/auth/utils/phone_utils.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter_svg/svg.dart';

class WhatsappTile extends StatefulWidget {
  final void Function(String, ConfirmMethod) onNext;
  final VoidCallback appBarPop;
  final VoidCallback onEmailTap;

  const WhatsappTile({
    super.key,
    required this.onNext,
    required this.appBarPop,
    required this.onEmailTap,
  });

  @override
  State<WhatsappTile> createState() => _WhatsappTileState();
}

class _WhatsappTileState extends State<WhatsappTile> {
  String _phoneDigits = '';
  String _formattedPhone = '';
  Country _selectedCountry = CountryData.defaultCountry;

  bool get _isValidPhone {
    if (_phoneDigits.isEmpty) return false;
    return PhoneUtils.isValidPhoneNumber(_phoneDigits, _selectedCountry);
  }

  void _onPhoneChanged(String digits, String formatted) {
    setState(() {
      _phoneDigits = digits;
      _formattedPhone = formatted;
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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            widget.onNext(_formattedPhone, ConfirmMethod.byPhone);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

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
                const LocalizedText(
                  AppLocalizations.authWithTheHelpOf,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: AppColors.backgroundColorLight,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const LocalizedText(
                      AppLocalizations.whatsApp,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whatsAppColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      Assets.icons.whatsappIcon.path,
                      colorFilter: const ColorFilter.mode(
                        AppColors.whatsAppColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const LocalizedText(
                  AppLocalizations.mobileNumWhatsAppDescription,
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
                ),
                const SizedBox(height: 20),
                RegistrationContainer(
                  onTap:
                      !_isValidPhone || isLoading
                          ? null
                          : () {
                            final internationalNumber =
                                PhoneUtils.getInternationalNumber(
                                  _phoneDigits,
                                  _selectedCountry,
                                );
                            final credentials = PhoneCredentials(
                              phoneNumber: internationalNumber,
                            );
                            context.read<AuthBloc>().add(
                              AuthRequested(credentials),
                            );
                          },
                  buttonText: AppLocalizations.authAndRegistration,
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
                const Spacer(),
                RegistrationContainer(
                  onTap: widget.onEmailTap,
                  buttonText: AppLocalizations.continueWithEmail,
                  buttonTextColor: AppColors.textColorLight,
                  color: AppColors.babyBlue,
                  iconPath: Assets.icons.emailLogo.path,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
