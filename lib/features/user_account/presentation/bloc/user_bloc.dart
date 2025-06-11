import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_travel_sim/features/user_account/domain/entities/user.dart';
import 'package:flex_travel_sim/features/user_account/domain/use_cases/get_current_user_use_case.dart';
import 'package:flex_travel_sim/features/user_account/domain/use_cases/update_user_profile_use_case.dart';

// Events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadCurrentUserEvent extends UserEvent {
  final bool forceRefresh;

  const LoadCurrentUserEvent({this.forceRefresh = false});

  @override
  List<Object?> get props => [forceRefresh];
}

class UpdateUserProfileEvent extends UserEvent {
  final Map<String, dynamic> userData;

  const UpdateUserProfileEvent(this.userData);

  @override
  List<Object?> get props => [userData];
}

class RefreshUserEvent extends UserEvent {}

class LogoutUserEvent extends UserEvent {}

// States
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserUpdating extends UserState {
  final User user;

  const UserUpdating(this.user);

  @override
  List<Object?> get props => [user];
}

class UserUpdateSuccess extends UserState {
  final User user;
  final String message;

  const UserUpdateSuccess({required this.user, required this.message});

  @override
  List<Object?> get props => [user, message];
}

class UserError extends UserState {
  final String message;
  final User? user;

  const UserError({required this.message, this.user});

  @override
  List<Object?> get props => [message, user];
}

class UserLoggedOut extends UserState {}

// Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;

  UserBloc({
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required UpdateUserProfileUseCase updateUserProfileUseCase,
  }) : _getCurrentUserUseCase = getCurrentUserUseCase,
       _updateUserProfileUseCase = updateUserProfileUseCase,
       super(UserInitial()) {
    on<LoadCurrentUserEvent>(_onLoadCurrentUser);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<RefreshUserEvent>(_onRefreshUser);
    on<LogoutUserEvent>(_onLogoutUser);
  }

  Future<void> _onLoadCurrentUser(
    LoadCurrentUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    final result = await _getCurrentUserUseCase(
      forceRefresh: event.forceRefresh,
    );

    result.fold(
      (failure) => emit(UserError(message: failure.message)),
      (user) => emit(UserLoaded(user)),
    );
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state;
    User? currentUser;

    if (currentState is UserLoaded) {
      currentUser = currentState.user;
    } else if (currentState is UserError && currentState.user != null) {
      currentUser = currentState.user;
    }

    if (currentUser != null) {
      emit(UserUpdating(currentUser));
    } else {
      emit(UserLoading());
    }

    final result = await _updateUserProfileUseCase(event.userData);

    result.fold(
      (failure) => emit(UserError(message: failure.message, user: currentUser)),
      (updatedUser) => emit(
        UserUpdateSuccess(
          user: updatedUser,
          message: 'Profile updated successfully',
        ),
      ),
    );
  }

  Future<void> _onRefreshUser(
    RefreshUserEvent event,
    Emitter<UserState> emit,
  ) async {
    add(const LoadCurrentUserEvent(forceRefresh: true));
  }

  Future<void> _onLogoutUser(
    LogoutUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoggedOut());
  }
}
