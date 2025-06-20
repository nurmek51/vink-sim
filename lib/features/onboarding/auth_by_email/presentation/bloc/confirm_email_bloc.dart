import 'package:flex_travel_sim/features/onboarding/auth_by_email/data/data_sources/auth_by_email_local_data_source.dart';
import 'package:flex_travel_sim/features/onboarding/auth_by_email/domain/use_cases/confirm_email_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ConfirmEmailState {}
class ConfirmEmailInitial extends ConfirmEmailState {}
class ConfirmEmailLoading extends ConfirmEmailState {}
class ConfirmEmailSuccess extends ConfirmEmailState {}
class ConfirmEmailFailure extends ConfirmEmailState {
  final String message;
  ConfirmEmailFailure(this.message);
}

abstract class ConfirmEmailEvent {}
class ConfirmEmailSubmitted extends ConfirmEmailEvent {
  final String ticketCode;
  ConfirmEmailSubmitted(this.ticketCode);
}

class ConfirmEmailBloc extends Bloc<ConfirmEmailEvent, ConfirmEmailState> {
  final ConfirmEmailUseCase confirmEmailUseCase;
  final AuthByEmailLocalDataSource localDataSource;

  ConfirmEmailBloc({
    required this.confirmEmailUseCase,
    required this.localDataSource,
  }) : super(ConfirmEmailInitial()) {
    on<ConfirmEmailSubmitted>((event, emit) async {
      emit(ConfirmEmailLoading());

      try {
        final token = await localDataSource.getToken();
        if (token == null) throw Exception('Token not found');
        await confirmEmailUseCase(token, event.ticketCode);
        emit(ConfirmEmailSuccess());
      } catch (e) {
        emit(ConfirmEmailFailure('Confirmation failed: $e'));
      }
    });
  }
}
