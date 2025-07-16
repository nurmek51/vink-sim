import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/firebase_auth_bloc.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/email_container.dart';
import 'package:flex_travel_sim/features/auth/domain/services/firebase_email_link_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/constants/localization.dart';
import 'package:flex_travel_sim/features/auth/presentation/widgets/registration_container.dart';
import 'dart:async';

class AuthByEmail extends StatefulWidget {
  final VoidCallback appBarPop;
  final void Function(String, ConfirmMethod) onNext;

  const AuthByEmail({super.key, required this.onNext, required this.appBarPop});

  @override
  State<AuthByEmail> createState() => _AuthByEmailState();
}

class _AuthByEmailState extends State<AuthByEmail> {
  String _email = '';
  bool _isLoading = false;
  bool _isEmailSent = false;
  Timer? _cooldownTimer;
  int _remainingSeconds = 0;

  bool get isValidEmail =>
      _email.length >= 10 &&
      _email.contains('@') &&
      !_email.startsWith('@') &&
      !_email.contains(' ') &&
      _email.contains('.');

  bool get canSendEmail => _remainingSeconds == 0;

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() {
      _remainingSeconds = 60;
    });

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
      });

      if (_remainingSeconds <= 0) {
        timer.cancel();
      }
    });
  }

  Future<void> _sendEmailLink() async {
    if (!isValidEmail || !canSendEmail) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseEmailLinkService.sendSignInLinkToEmail(_email.trim());

      setState(() {
        _isEmailSent = true;
      });

      _startCooldown();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ссылка для входа отправлена на вашу почту!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resendEmailLink() async {
    if (!isValidEmail || !canSendEmail) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseEmailLinkService.resendSignInLink(_email.trim());

      _startCooldown();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ссылка отправлена повторно!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
      body: BlocConsumer<FirebaseAuthBloc, FirebaseAuthState>(
        listener: (context, state) {
          if (state is FirebaseAuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
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
                Text(
                  _isEmailSent
                      ? 'Мы отправили ссылку для входа на ваш email. Проверьте почту и папку "Спам".'
                      : 'Введите ваш email – мы отправим ссылку для авторизации',
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        _isEmailSent
                            ? Colors.green
                            : AppColors.backgroundColorLight,
                  ),
                ),
                const SizedBox(height: 20),
                EmailContainer(
                  onChanged: (email) => setState(() => _email = email),
                ),
                const SizedBox(height: 20),
                RegistrationContainer(
                  onTap:
                      !isValidEmail || _isLoading || !canSendEmail
                          ? null
                          : (_isEmailSent ? _resendEmailLink : _sendEmailLink),
                  buttonText:
                      _isLoading
                          ? "Отправка..."
                          : (_isEmailSent
                              ? "Отправить повторно"
                              : "Отправить ссылку"),
                  buttonTextColor:
                      (isValidEmail && canSendEmail)
                          ? AppColors.backgroundColorLight
                          : const Color(0x4DFFFFFF),
                  color:
                      (isValidEmail && canSendEmail)
                          ? (_isEmailSent
                              ? Colors.orange
                              : AppColors.accentBlue)
                          : const Color(0x4D808080),
                  arrowForward: isValidEmail && !_isEmailSent && canSendEmail,
                ),

                // Отдельный таймер
                if (_remainingSeconds > 0) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.timer, color: Colors.orange, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Повторная отправка через ${_remainingSeconds} сек',
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
