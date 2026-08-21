import 'package:core/core.dart';
import 'package:core/packages/equatable/equatable.dart';

/// One currency row for the exchange rates list — today's rate against EGP,
/// paired with yesterday's so the UI can derive change/direction. This is a
/// display DTO computed client-side; the API never returns a diff itself.
class ExchangeRateItem extends Equatable {
  const ExchangeRateItem({
    required this.currency,
    required this.rate,
    required this.previousRate,
  });

  final CurrencyEnums currency;

  /// 1 [currency] = [rate] EGP, as of today.
  final num rate;

  /// 1 [currency] = [previousRate] EGP, as of yesterday.
  final num previousRate;

  num get absoluteChange => rate - previousRate;

  num get percentChange =>
      previousRate == 0 ? 0 : (absoluteChange / previousRate) * 100;

  @override
  List<Object?> get props => [currency, rate, previousRate];
}
