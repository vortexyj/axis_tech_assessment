part of 'exchange_cubit.dart';

class ExchangeState extends BaseState {
  const ExchangeState({super.failure, super.pageState});

  @override
  ExchangeState copyWith({Failure? failure, PageState? pageState}) {
    return ExchangeState(
      failure: failure ?? super.failure,
      pageState: pageState ?? super.pageState,
    );
  }

  @override
  List<Object?> get props => [pageState, failure];
}
