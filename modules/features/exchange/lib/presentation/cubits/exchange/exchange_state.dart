part of 'exchange_cubit.dart';

class ExchangeState extends BaseState {
  const ExchangeState({
    super.failure,
    super.pageState,
    this.rates,
    this.lastUpdated,
  });

  final List<ExchangeRateItem>? rates;
  final DateTime? lastUpdated;

  @override
  ExchangeState copyWith({
    Failure? failure,
    PageState? pageState,
    List<ExchangeRateItem>? rates,
    DateTime? lastUpdated,
  }) {
    return ExchangeState(
      failure: failure ?? super.failure,
      pageState: pageState ?? super.pageState,
      rates: rates ?? this.rates,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [pageState, failure, rates, lastUpdated];
}
