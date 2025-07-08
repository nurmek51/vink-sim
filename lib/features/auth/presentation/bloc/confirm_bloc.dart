import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/confirm_use_case.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter/foundation.dart';

// STATE 
abstract class ConfirmState {}

class ConfirmInitial extends ConfirmState {}

class ConfirmLoading extends ConfirmState {}

class ConfirmSuccess extends ConfirmState {}

class ConfirmFailure extends ConfirmState {
  final String message;
  ConfirmFailure(this.message);
}

// EVENT
abstract class ConfirmEvent {}

class ConfirmSubmitted extends ConfirmEvent {
  final ConfirmMethod method;
  final String ticketCode;

  ConfirmSubmitted({
    required this.method,
    required this.ticketCode,
  });
}

// BLOC
class ConfirmBloc extends Bloc<ConfirmEvent, ConfirmState> {
  final ConfirmUseCase confirmUseCase;
  final AuthLocalDataSource localDataSource;

  ConfirmBloc({
    required this.confirmUseCase,
    required this.localDataSource,
  }) : super(ConfirmInitial()) {
    on<ConfirmSubmitted>((event, emit) async {
      emit(ConfirmLoading());
      
      if (kDebugMode) {
        print('ConfirmBloc: Confirmation requested');
        print('Method: ${event.method}');
        print('Ticket code: ${event.ticketCode}');
      }
      
      try {
        final token = await localDataSource.getToken();
        if (token == null) {
          if (kDebugMode) {
            print('ConfirmBloc: No token found in local storage');
          }
          throw Exception('Token not found in local storage');
        }

        if (kDebugMode) {
          print('ConfirmBloc: Found token: $token');
        }

        await confirmUseCase(
          method: event.method,
          token: token,
          ticketCode: event.ticketCode,
        );

        if (kDebugMode) {
          print('ConfirmBloc: Confirmation successful');
        }
        emit(ConfirmSuccess());
      } catch (e) {
        if (kDebugMode) {
          print('ConfirmBloc: Confirmation error: $e');
        }
        emit(ConfirmFailure('Confirmation failed: $e'));
      }
    });
  }
}
