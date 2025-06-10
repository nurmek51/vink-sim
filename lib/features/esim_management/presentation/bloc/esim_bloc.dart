import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_travel_sim/features/esim_management/domain/entities/esim.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/activate_esim_use_case.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/get_esims_use_case.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/purchase_esim_use_case.dart';

// Events
abstract class EsimEvent extends Equatable {
  const EsimEvent();

  @override
  List<Object?> get props => [];
}

class LoadEsimsEvent extends EsimEvent {
  final bool forceRefresh;

  const LoadEsimsEvent({this.forceRefresh = false});

  @override
  List<Object?> get props => [forceRefresh];
}

class ActivateEsimEvent extends EsimEvent {
  final String esimId;
  final String activationCode;

  const ActivateEsimEvent({required this.esimId, required this.activationCode});

  @override
  List<Object?> get props => [esimId, activationCode];
}

class PurchaseEsimEvent extends EsimEvent {
  final String tariffId;
  final Map<String, dynamic> paymentData;

  const PurchaseEsimEvent({required this.tariffId, required this.paymentData});

  @override
  List<Object?> get props => [tariffId, paymentData];
}

class RefreshEsimsEvent extends EsimEvent {}

// States
abstract class EsimState extends Equatable {
  const EsimState();

  @override
  List<Object?> get props => [];
}

class EsimInitial extends EsimState {}

class EsimLoading extends EsimState {}

class EsimLoaded extends EsimState {
  final List<Esim> esims;

  const EsimLoaded(this.esims);

  @override
  List<Object?> get props => [esims];
}

class EsimOperationInProgress extends EsimState {
  final List<Esim> esims;
  final String operationType; // 'activating', 'purchasing'

  const EsimOperationInProgress({
    required this.esims,
    required this.operationType,
  });

  @override
  List<Object?> get props => [esims, operationType];
}

class EsimOperationSuccess extends EsimState {
  final List<Esim> esims;
  final String message;

  const EsimOperationSuccess({required this.esims, required this.message});

  @override
  List<Object?> get props => [esims, message];
}

class EsimError extends EsimState {
  final String message;
  final List<Esim>? esims;

  const EsimError({required this.message, this.esims});

  @override
  List<Object?> get props => [message, esims];
}

// Bloc
class EsimBloc extends Bloc<EsimEvent, EsimState> {
  final GetEsimsUseCase _getEsimsUseCase;
  final ActivateEsimUseCase _activateEsimUseCase;
  final PurchaseEsimUseCase _purchaseEsimUseCase;

  EsimBloc({
    required GetEsimsUseCase getEsimsUseCase,
    required ActivateEsimUseCase activateEsimUseCase,
    required PurchaseEsimUseCase purchaseEsimUseCase,
  }) : _getEsimsUseCase = getEsimsUseCase,
       _activateEsimUseCase = activateEsimUseCase,
       _purchaseEsimUseCase = purchaseEsimUseCase,
       super(EsimInitial()) {
    on<LoadEsimsEvent>(_onLoadEsims);
    on<ActivateEsimEvent>(_onActivateEsim);
    on<PurchaseEsimEvent>(_onPurchaseEsim);
    on<RefreshEsimsEvent>(_onRefreshEsims);
  }

  Future<void> _onLoadEsims(
    LoadEsimsEvent event,
    Emitter<EsimState> emit,
  ) async {
    emit(EsimLoading());

    final result = await _getEsimsUseCase(forceRefresh: event.forceRefresh);

    result.fold(
      (failure) => emit(EsimError(message: failure.message)),
      (esims) => emit(EsimLoaded(esims)),
    );
  }

  Future<void> _onActivateEsim(
    ActivateEsimEvent event,
    Emitter<EsimState> emit,
  ) async {
    final currentState = state;
    List<Esim> currentEsims = [];

    if (currentState is EsimLoaded) {
      currentEsims = currentState.esims;
    } else if (currentState is EsimError && currentState.esims != null) {
      currentEsims = currentState.esims!;
    }

    emit(
      EsimOperationInProgress(esims: currentEsims, operationType: 'activating'),
    );

    final result = await _activateEsimUseCase(
      event.esimId,
      event.activationCode,
    );

    result.fold(
      (failure) =>
          emit(EsimError(message: failure.message, esims: currentEsims)),
      (activatedEsim) {
        final updatedEsims =
            currentEsims.map((esim) {
              return esim.id == activatedEsim.id ? activatedEsim : esim;
            }).toList();

        emit(
          EsimOperationSuccess(
            esims: updatedEsims,
            message: 'eSIM activated successfully',
          ),
        );
      },
    );
  }

  Future<void> _onPurchaseEsim(
    PurchaseEsimEvent event,
    Emitter<EsimState> emit,
  ) async {
    final currentState = state;
    List<Esim> currentEsims = [];

    if (currentState is EsimLoaded) {
      currentEsims = currentState.esims;
    } else if (currentState is EsimError && currentState.esims != null) {
      currentEsims = currentState.esims!;
    }

    emit(
      EsimOperationInProgress(esims: currentEsims, operationType: 'purchasing'),
    );

    final result = await _purchaseEsimUseCase(
      event.tariffId,
      event.paymentData,
    );

    result.fold(
      (failure) =>
          emit(EsimError(message: failure.message, esims: currentEsims)),
      (purchasedEsim) {
        final updatedEsims = [...currentEsims, purchasedEsim];

        emit(
          EsimOperationSuccess(
            esims: updatedEsims,
            message: 'eSIM purchased successfully',
          ),
        );
      },
    );
  }

  Future<void> _onRefreshEsims(
    RefreshEsimsEvent event,
    Emitter<EsimState> emit,
  ) async {
    add(const LoadEsimsEvent(forceRefresh: true));
  }
}
