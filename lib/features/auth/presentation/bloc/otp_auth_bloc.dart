import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vink_sim/features/auth/domain/repo/auth_repository.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_event.dart';
import 'package:vink_sim/features/auth/presentation/bloc/otp_auth_state.dart';

class OtpAuthBloc extends Bloc<OtpAuthEvent, OtpAuthState> {
  final AuthRepository _authRepository;

  OtpAuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
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

    final result = await _authRepository.requestOtp(event.phone);

    result.fold(
      (error) => emit(OtpAuthError(message: error.toString())),
      (_) => emit(OtpSmsSent(phone: event.phone)),
    );
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<OtpAuthState> emit,
  ) async {
    emit(const OtpVerificationLoading());

    final result = await _authRepository.verifyOtp(event.phone, event.code);

    result.fold(
      (error) => emit(OtpAuthError(message: error.toString())),
      (authToken) => emit(
        OtpVerificationSuccess(token: authToken.token, phone: event.phone),
      ),
    );
  }

  void _onResetOtpState(ResetOtpStateEvent event, Emitter<OtpAuthState> emit) {
    emit(const OtpAuthInitial());
  }
}
