part of 'exchange_cubit.dart';

class ExchangeState extends BaseState {
  const ExchangeState({super.failure, super.pageState, this.getCurrencyEntity});
  final GetCurrencyEntity? getCurrencyEntity;
  @override
  ExchangeState copyWith({
    Failure? failure,
    PageState? pageState,
    GetCurrencyEntity? getCurrencyEntity,
  }) {
    return ExchangeState(
      failure: failure ?? super.failure,
      pageState: pageState ?? super.pageState,
      getCurrencyEntity: getCurrencyEntity ?? this.getCurrencyEntity,
    );
  }

  @override
  List<Object?> get props => [pageState, failure, getCurrencyEntity];
}
