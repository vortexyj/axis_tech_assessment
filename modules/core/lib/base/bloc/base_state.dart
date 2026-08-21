part of 'base_bloc.dart';

enum PageState {
  idle,
  init,
  success,
  failure,
  loading,
  shimmerLoading,
  fetchComplete,
  empty,
  errorWithDialog,
  errorWithSheet,
}

class BaseState extends Equatable {
  final PageState pageState;
  final Failure? failure;

  const BaseState({this.pageState = PageState.idle, this.failure});

  BaseState copyWith({PageState? pageState, Failure? failure}) {
    return BaseState(
      pageState: pageState ?? this.pageState,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [pageState, failure];
}
