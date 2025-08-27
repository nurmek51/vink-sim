import 'package:equatable/equatable.dart';

abstract class SubscriberEvent extends Equatable {
  const SubscriberEvent();

  @override
  List<Object> get props => [];
}

class LoadSubscriberInfoEvent extends SubscriberEvent {
  const LoadSubscriberInfoEvent();
}

class RefreshSubscriberInfoEvent extends SubscriberEvent {
  const RefreshSubscriberInfoEvent();
}

class ResetSubscriberStateEvent extends SubscriberEvent {
  const ResetSubscriberStateEvent();
}
