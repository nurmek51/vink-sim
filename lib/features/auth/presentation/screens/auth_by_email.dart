import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/credentials.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/email_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/registration_container.dart';


class AuthByEmail extends StatefulWidget {
  final VoidCallback appBarPop;
  final void Function(String, ConfirmMethod) onNext;

  const AuthByEmail({
    super.key,
    required this.onNext,
    required this.appBarPop,
  });

  @override
  State<AuthByEmail> createState() => _AuthByEmailState();
}

class _AuthByEmailState extends State<AuthByEmail> {
  String _email = '';

  bool get isValidEmail =>
    _email.length >= 10 &&
    _email.contains('@') &&
    !_email.startsWith('@') &&
    !_email.contains(' ') &&
    _email.contains('.');

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
            widget.onNext(_email, ConfirmMethod.byEmail);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  AppLocalization.authWithTheHelpOf,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: AppColors.backgroundColorLight,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  AppLocalization.email,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: AppColors.backgroundColorLight,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  AppLocalization.emailDescription,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.backgroundColorLight,
                  ),
                ),
                const SizedBox(height: 20),
                EmailContainer(
                  onChanged: (email) => setState(() => _email = email),
                ),
                const SizedBox(height: 20),
                RegistrationContainer(
                  onTap: !isValidEmail || isLoading
                      ? null
                      : () {
                          context.read<AuthBloc>().add(AuthRequested(EmailCredentials(_email))); 
                        },
                  buttonText: AppLocalization.authAndRegistration,
                  buttonTextColor: isValidEmail
                      ? AppColors.backgroundColorLight
                      : const Color(0x4DFFFFFF),
                  color: isValidEmail
                      ? AppColors.accentBlue
                      : const Color(0x4D808080),
                  arrowForward: isValidEmail,
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}