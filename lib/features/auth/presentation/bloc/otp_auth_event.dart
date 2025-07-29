import 'package:equatable/equatable.dart';

abstract class OtpAuthEvent extends Equatable {
  const OtpAuthEvent();

  @override
  List<Object> get props => [];
}

class SendOtpSmsEvent extends OtpAuthEvent {
  final String phone;

  const SendOtpSmsEvent({required this.phone});

  @override
  List<Object> get props => [phone];
}

class VerifyOtpEvent extends OtpAuthEvent {
  final String phone;
  final String code;

  const VerifyOtpEvent({
    required this.phone,
    required this.code,
  });

  @override
  List<Object> get props => [phone, code];
}

class ResetOtpStateEvent extends OtpAuthEvent {
  const ResetOtpStateEvent();
}