import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/otp_auth_data_source.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/otp_auth_event.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/otp_auth_state.dart';

class OtpAuthBloc extends Bloc<OtpAuthEvent, OtpAuthState> {
  final OtpAuthDataSource _otpAuthDataSource;

  OtpAuthBloc({
    required OtpAuthDataSource otpAuthDataSource,
  })  : _otpAuthDataSource = otpAuthDataSource,
        super(const OtpAuthInitial()) {
    on<SendOtpSmsEvent>(_onSendOtpSms);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResetOtpStateEvent>(_onResetOtpState);
  }

  Future<void> _onSendOtpSms(
    SendOtpSmsEvent event,
    Emitter<OtpAuthState> emit,
  ) async {
    emit(const OtpSmsLoading());

    try {
      await _otpAuthDataSource.sendOtpSms(event.phone);
      emit(OtpSmsSent(phone: event.phone));
    } catch (e) {
      emit(OtpAuthError(message: e.toString()));
    }
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<OtpAuthState> emit,
  ) async {
    emit(const OtpVerificationLoading());

    try {
      final response = await _otpAuthDataSource.verifyOtp(
        event.phone,
        event.code,
      );
      emit(OtpVerificationSuccess(
        token: response.token,
        phone: event.phone,
      ));
    } catch (e) {
      emit(OtpAuthError(message: e.toString()));
    }
  }

  void _onResetOtpState(
    ResetOtpStateEvent event,
    Emitter<OtpAuthState> emit,
  ) {
    emit(const OtpAuthInitial());
  }
}