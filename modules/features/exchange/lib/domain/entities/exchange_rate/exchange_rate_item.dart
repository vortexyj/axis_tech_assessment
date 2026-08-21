import 'package:core/core.dart';
import 'package:core/packages/equatable/equatable.dart';

class ExchangeRateItem extends Equatable {
  const ExchangeRateItem({
    required this.currency,
    required this.rate,
    required this.previousRate,
  });

  final CurrencyEnums currency;

  final num rate;

  final num previousRate;

  num get absoluteChange => rate - previousRate;

  num get percentChange =>
      previousRate == 0 ? 0 : (absoluteChange / previousRate) * 100;

  @override
  List<Object?> get props => [currency, rate, previousRate];
}
