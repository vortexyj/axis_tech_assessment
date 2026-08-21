part of 'currency_details_cubit.dart';

class CurrencyDetailsState extends BaseState {
  const CurrencyDetailsState({
    super.failure,
    super.pageState,
    this.currency,
    this.rate,
    this.previousRate,
    this.history,
    this.lastUpdated,
    this.isOffline = false,
    this.cachedAt,
  });

  final CurrencyEnums? currency;

  /// 1 [currency] = [rate] EGP, as of today.
  final num? rate;

  /// 1 [currency] = [previousRate] EGP, as of yesterday.
  final num? previousRate;

  final List<CurrencyHistoryPoint>? history;
  final DateTime? lastUpdated;

  /// True when the data being shown was built from a cached response rather
  /// than a live fetch — drives the offline banner over the loaded content.
  final bool isOffline;

  /// When the cached data being shown was originally fetched. Only
  /// meaningful when [isOffline] is true.
  final DateTime? cachedAt;

  num? get absoluteChange =>
      rate == null || previousRate == null ? null : rate! - previousRate!;

  num? get percentChange {
    if (rate == null || previousRate == null || previousRate == 0) return null;
    return (absoluteChange! / previousRate!) * 100;
  }

  @override
  CurrencyDetailsState copyWith({
    Failure? failure,
    PageState? pageState,
    CurrencyEnums? currency,
    num? rate,
    num? previousRate,
    List<CurrencyHistoryPoint>? history,
    DateTime? lastUpdated,
    bool? isOffline,
    DateTime? cachedAt,
  }) {
    return CurrencyDetailsState(
      failure: failure ?? super.failure,
      pageState: pageState ?? super.pageState,
      currency: currency ?? this.currency,
      rate: rate ?? this.rate,
      previousRate: previousRate ?? this.previousRate,
      history: history ?? this.history,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isOffline: isOffline ?? this.isOffline,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  @override
  List<Object?> get props => [
    pageState,
    failure,
    currency,
    rate,
    previousRate,
    history,
    lastUpdated,
    isOffline,
    cachedAt,
  ];
}
