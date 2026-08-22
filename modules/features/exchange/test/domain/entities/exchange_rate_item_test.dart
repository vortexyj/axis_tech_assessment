import 'package:core/core.dart';
import 'package:exchange/domain/entities/exchange_rate/exchange_rate_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeRateItem', () {
    test('absoluteChange is rate minus previousRate', () {
      const item = ExchangeRateItem(
        currency: CurrencyEnums.USD,
        rate: 50.878,
        previousRate: 50.652,
      );

      expect(item.absoluteChange, closeTo(0.226, 0.0001));
    });

    test('percentChange is the change relative to previousRate, as a percent', () {
      const item = ExchangeRateItem(
        currency: CurrencyEnums.USD,
        rate: 50.878,
        previousRate: 50.652,
      );

      expect(item.percentChange, closeTo(0.446, 0.01));
    });

    test('a rate decrease produces a negative change', () {
      const item = ExchangeRateItem(
        currency: CurrencyEnums.JPY,
        rate: 0.319,
        previousRate: 0.320,
      );

      expect(item.absoluteChange, lessThan(0));
      expect(item.percentChange, lessThan(0));
    });

    test('an unchanged rate produces zero change', () {
      const item = ExchangeRateItem(
        currency: CurrencyEnums.JPY,
        rate: 0.320,
        previousRate: 0.320,
      );

      expect(item.absoluteChange, 0);
      expect(item.percentChange, 0);
    });

    test('percentChange is 0, not NaN/infinity, when previousRate is 0', () {
      const item = ExchangeRateItem(
        currency: CurrencyEnums.USD,
        rate: 50,
        previousRate: 0,
      );

      expect(item.percentChange, 0);
    });
  });
}
