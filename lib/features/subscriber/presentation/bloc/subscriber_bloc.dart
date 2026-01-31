import 'package:vink_sim/core/models/subscriber_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vink_sim/features/subscriber/data/data_sources/subscriber_remote_data_source.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_event.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:flutter/foundation.dart';

class SubscriberBloc extends Bloc<SubscriberEvent, SubscriberState> {
  final SubscriberRemoteDataSource _subscriberRemoteDataSource;

  SubscriberBloc({
    required SubscriberRemoteDataSource subscriberRemoteDataSource,
  }) : _subscriberRemoteDataSource = subscriberRemoteDataSource,
       super(const SubscriberInitial()) {
    on<LoadSubscriberInfoEvent>(_onLoadSubscriberInfo);
    on<RefreshSubscriberInfoEvent>(_onRefreshSubscriberInfo);
    on<ResetSubscriberStateEvent>(_onResetSubscriberState);
    on<SetSubscriberDataEvent>(_onSetSubscriberData);
  }

  void _onSetSubscriberData(
    SetSubscriberDataEvent event,
    Emitter<SubscriberState> emit,
  ) {
    if (event.subscriber is SubscriberModel) {
      emit(SubscriberLoaded(subscriber: event.subscriber as SubscriberModel));
    }
  }

  Future<void> _onLoadSubscriberInfo(
    LoadSubscriberInfoEvent event,
    Emitter<SubscriberState> emit,
  ) async {
    if (kDebugMode) {
      print('SubscriberBloc: Loading subscriber info');
    }

    emit(const SubscriberLoading());

    try {
      final subscriber = await _subscriberRemoteDataSource.getSubscriberInfo();

      if (kDebugMode) {
        print('SubscriberBloc: Successfully loaded subscriber info');
        print('SubscriberBloc: Balance: ${subscriber.balance}');
        print('SubscriberBloc: IMSI count: ${subscriber.imsiList.length}');
      }

      emit(SubscriberLoaded(subscriber: subscriber));
    } catch (e) {
      if (kDebugMode) {
        print('SubscriberBloc: Error loading subscriber info: $e');
        print('SubscriberBloc: Error type: ${e.runtimeType}');
      }

      emit(SubscriberError(message: e.toString()));
    }
  }

  Future<void> _onRefreshSubscriberInfo(
    RefreshSubscriberInfoEvent event,
    Emitter<SubscriberState> emit,
  ) async {
    try {
      final subscriber = await _subscriberRemoteDataSource.getSubscriberInfo();
      emit(SubscriberLoaded(subscriber: subscriber));
    } catch (e) {
      emit(SubscriberError(message: e.toString()));
    }
  }

  void _onResetSubscriberState(
    ResetSubscriberStateEvent event,
    Emitter<SubscriberState> emit,
  ) {
    emit(const SubscriberInitial());
  }
}
