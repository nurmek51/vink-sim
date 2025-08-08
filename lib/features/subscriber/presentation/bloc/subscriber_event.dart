import 'package:equatable/equatable.dart';

abstract class SubscriberEvent extends Equatable {
  const SubscriberEvent();

  @override
  List<Object> get props => [];
}

class LoadSubscriberInfoEvent extends SubscriberEvent {
  final String token;

  const LoadSubscriberInfoEvent({required this.token});

  @override
  List<Object> get props => [token];
}

class RefreshSubscriberInfoEvent extends SubscriberEvent {
  final String token;

  const RefreshSubscriberInfoEvent({required this.token});

  @override
  List<Object> get props => [token];
}

class ResetSubscriberStateEvent extends SubscriberEvent {
  const ResetSubscriberStateEvent();
}
