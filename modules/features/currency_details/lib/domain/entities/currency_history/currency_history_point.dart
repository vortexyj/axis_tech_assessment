import 'package:core/packages/equatable/equatable.dart';

/// One day's rate for the currency being viewed on the detail screen —
/// the chart's x/y pair. Like [ExchangeRateItem] on the list screen, this is
/// a display DTO computed client-side; the API only ever returns one day's
/// snapshot per call.
class CurrencyHistoryPoint extends Equatable {
  const CurrencyHistoryPoint({required this.date, required this.rate});

  final DateTime date;

  /// 1 unit of the viewed currency = [rate] EGP, on [date].
  final num rate;

  @override
  List<Object?> get props => [date, rate];
}
