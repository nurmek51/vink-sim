import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class MainFlowEvent extends Equatable {
  const MainFlowEvent();

  @override
  List<Object?> get props => [];
}

class PageChangedEvent extends MainFlowEvent {
  final int pageIndex;

  const PageChangedEvent(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

class ShowBottomSheetEvent extends MainFlowEvent {}

class HideBottomSheetEvent extends MainFlowEvent {}

// States
class MainFlowState extends Equatable {
  final int currentPage;
  final List<double> progressValues;
  final bool isBottomSheetVisible;

  const MainFlowState({
    this.currentPage = 0,
    this.progressValues = const [0.40, 0],
    this.isBottomSheetVisible = false,
  });

  MainFlowState copyWith({
    int? currentPage,
    List<double>? progressValues,
    bool? isBottomSheetVisible,
  }) {
    return MainFlowState(
      currentPage: currentPage ?? this.currentPage,
      progressValues: progressValues ?? this.progressValues,
      isBottomSheetVisible: isBottomSheetVisible ?? this.isBottomSheetVisible,
    );
  }

  @override
  List<Object?> get props => [currentPage, progressValues, isBottomSheetVisible];
}

// Bloc
class MainFlowBloc extends Bloc<MainFlowEvent, MainFlowState> {
  MainFlowBloc() : super(const MainFlowState()) {
    on<PageChangedEvent>(_onPageChanged);
    on<ShowBottomSheetEvent>(_onShowBottomSheet);
    on<HideBottomSheetEvent>(_onHideBottomSheet);
  }

  void _onPageChanged(PageChangedEvent event, Emitter<MainFlowState> emit) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }

  void _onShowBottomSheet(ShowBottomSheetEvent event, Emitter<MainFlowState> emit) {
    emit(state.copyWith(isBottomSheetVisible: true));
  }

  void _onHideBottomSheet(HideBottomSheetEvent event, Emitter<MainFlowState> emit) {
    emit(state.copyWith(isBottomSheetVisible: false));
  }
}
