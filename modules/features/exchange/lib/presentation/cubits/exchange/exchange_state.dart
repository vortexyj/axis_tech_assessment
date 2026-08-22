part of 'exchange_cubit.dart';

class ExchangeState extends BaseState {
  const ExchangeState({
    super.failure,
    super.pageState,
    this.rates,
    this.lastUpdated,
    this.todayCurrency,
    this.yesterdayCurrency,
    this.isOffline = false,
    this.cachedAt,
  });

  final List<ExchangeRateItem>? rates;
  final DateTime? lastUpdated;
  final GetCurrencyEntity? todayCurrency;
  final GetCurrencyEntity? yesterdayCurrency;

  /// True when [rates] were built from a cached response rather than a live
  /// fetch — drives the offline banner over the loaded list.
  final bool isOffline;

  /// When the cached data being shown was originally fetched. Only
  /// meaningful when [isOffline] is true.
  final DateTime? cachedAt;

  @override
  ExchangeState copyWith({
    Failure? failure,
    PageState? pageState,
    List<ExchangeRateItem>? rates,
    DateTime? lastUpdated,
    GetCurrencyEntity? todayCurrency,
    GetCurrencyEntity? yesterdayCurrency,
    bool? isOffline,
    DateTime? cachedAt,
  }) {
    return ExchangeState(
      failure: failure ?? super.failure,
      pageState: pageState ?? super.pageState,
      rates: rates ?? this.rates,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      todayCurrency: todayCurrency ?? this.todayCurrency,
      yesterdayCurrency: yesterdayCurrency ?? this.yesterdayCurrency,
      isOffline: isOffline ?? this.isOffline,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  @override
  List<Object?> get props => [
    pageState,
    failure,
    rates,
    lastUpdated,
    todayCurrency,
    yesterdayCurrency,
    isOffline,
    cachedAt,
  ];
}
