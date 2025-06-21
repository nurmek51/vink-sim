import 'package:flex_travel_sim/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:flex_travel_sim/features/authentication/domain/use_cases/confirm_number_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ConfirmNumberState {}
class ConfirmNumberInitial extends ConfirmNumberState {}
class ConfirmNumberLoading extends ConfirmNumberState {}
class ConfirmNumberSuccess extends ConfirmNumberState {}
class ConfirmNumberFailure extends ConfirmNumberState {
  final String message;
  ConfirmNumberFailure(this.message);
}

abstract class ConfirmNumberEvent {}
class ConfirmNumberSubmitted extends ConfirmNumberEvent {
  final String ticketCode;
  ConfirmNumberSubmitted(this.ticketCode);
}

class ConfirmNumberBloc extends Bloc<ConfirmNumberEvent, ConfirmNumberState> {
  final ConfirmNumberUseCase confirmNumberUseCase;
  final AuthLocalDataSource localDataSource;

  ConfirmNumberBloc({
    required this.confirmNumberUseCase,
    required this.localDataSource,
  }) : super(ConfirmNumberInitial()) {
    on<ConfirmNumberSubmitted>((event, emit) async {
      emit(ConfirmNumberLoading());

      try {
        final token = await localDataSource.getToken();
        if (token == null) throw Exception('Token not found');
        await confirmNumberUseCase(token, event.ticketCode);
        emit(ConfirmNumberSuccess());
      } catch (e) {
        emit(ConfirmNumberFailure('Confirmation failed: $e'));
      }
    });
  }
}
