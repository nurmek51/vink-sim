import 'package:equatable/equatable.dart';

abstract class OtpAuthState extends Equatable {
  const OtpAuthState();

  @override
  List<Object?> get props => [];
}

class OtpAuthInitial extends OtpAuthState {
  const OtpAuthInitial();
}

class OtpSmsLoading extends OtpAuthState {
  const OtpSmsLoading();
}

class OtpSmsSent extends OtpAuthState {
  final String phone;

  const OtpSmsSent({required this.phone});

  @override
  List<Object> get props => [phone];
}

class OtpVerificationLoading extends OtpAuthState {
  const OtpVerificationLoading();
}

class OtpVerificationSuccess extends OtpAuthState {
  final String token;
  final String phone;

  const OtpVerificationSuccess({
    required this.token,
    required this.phone,
  });

  @override
  List<Object> get props => [token, phone];
}

class OtpAuthError extends OtpAuthState {
  final String message;

  const OtpAuthError({required this.message});

  @override
  List<Object> get props => [message];
}