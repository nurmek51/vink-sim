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

class SetSubscriberDataEvent extends SubscriberEvent {
  final dynamic
  subscriber; // Using dynamic or exact type to avoid circular dep if needed, but preferably SubscriberModel
  const SetSubscriberDataEvent(this.subscriber);

  @override
  List<Object> get props => [subscriber];
}
