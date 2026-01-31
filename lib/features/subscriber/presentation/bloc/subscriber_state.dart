import 'package:equatable/equatable.dart';
import 'package:vink_sim/core/models/subscriber_model.dart';

abstract class SubscriberState extends Equatable {
  const SubscriberState();

  @override
  List<Object?> get props => [];
}

class SubscriberInitial extends SubscriberState {
  const SubscriberInitial();
}

class SubscriberLoading extends SubscriberState {
  const SubscriberLoading();
}

class SubscriberLoaded extends SubscriberState {
  final SubscriberModel subscriber;

  const SubscriberLoaded({required this.subscriber});

  @override
  List<Object> get props => [subscriber];
}

class SubscriberError extends SubscriberState {
  final String message;

  const SubscriberError({required this.message});

  @override
  List<Object> get props => [message];
}