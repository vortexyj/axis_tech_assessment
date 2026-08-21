import 'package:core/core.dart';
import 'package:exchange/data/models/get_currency/request/get_currency_request_model.dart';
import 'package:exchange/domain/entities/exchange_rate/exchange_rate_item.dart';
import 'package:exchange/domain/entities/get_currency/egp_entity.dart';
import 'package:exchange/domain/exchange_usecase/get_currency_usecase/get_currency_usecase.dart';
part 'exchange_state.dart';

class ExchangeCubit extends BaseCubit<ExchangeState> {
  final GetCurrencyUseCase _getCurrencyUseCase;
  ExchangeCubit(this._getCurrencyUseCase) : super(const ExchangeState());

  /// Fixed display order per the spec — not the API's key order.
  static const List<CurrencyEnums> currencyOrder = [
    CurrencyEnums.USD,
    CurrencyEnums.EUR,
    CurrencyEnums.GBP,
    CurrencyEnums.SAR,
    CurrencyEnums.JPY,
  ];

  @override
  Future<void> initState() async {
    await getExchangeRates();
  }

  /// Fetches today's and yesterday's EGP rates and derives the change/
  /// direction the list needs — the API only ever returns one day's
  /// snapshot, it never returns a diff itself.
  Future<void> getExchangeRates() async {
    emitIfNotClosed(state.copyWith(pageState: PageState.loading));

    final results = await Future.wait([
      _getCurrencyUseCase.call(GetCurrencyRequestModel(null, CurrencyEnums.EGP)),
      _getCurrencyUseCase.call(
        GetCurrencyRequestModel(_yesterdayDate, CurrencyEnums.EGP),
      ),
    ]);

    Failure? failure;
    EgpEntity? today;
    EgpEntity? yesterday;

    results[0].fold((f) => failure = f, (entity) => today = entity.egp);
    results[1].fold((f) => failure ??= f, (entity) => yesterday = entity.egp);

    if (failure != null) {
      emitIfNotClosed(
        state.copyWith(pageState: PageState.failure, failure: failure),
      );
      return;
    }

    final rates = _buildRates(today, yesterday);
    emitIfNotClosed(
      state.copyWith(
        pageState: rates.isEmpty ? PageState.empty : PageState.success,
        rates: rates,
        lastUpdated: DateTime.now(),
      ),
    );
  }

  List<ExchangeRateItem> _buildRates(EgpEntity? today, EgpEntity? yesterday) {
    if (today == null || yesterday == null) return const [];
    final items = <ExchangeRateItem>[];
    for (final currency in currencyOrder) {
      final todayRate = _rateFor(today, currency);
      final yesterdayRate = _rateFor(yesterday, currency);
      if (todayRate == null || yesterdayRate == null || todayRate == 0) {
        continue;
      }
      // API returns "FROM 1 EGP TO currency" — invert to "1 currency = X EGP".
      items.add(ExchangeRateItem(
        currency: currency,
        rate: 1 / todayRate,
        previousRate: yesterdayRate == 0 ? 1 / todayRate : 1 / yesterdayRate,
      ));
    }
    return items;
  }

  num? _rateFor(EgpEntity egp, CurrencyEnums currency) {
    switch (currency) {
      case CurrencyEnums.USD:
        return egp.usd;
      case CurrencyEnums.EUR:
        return egp.eur;
      case CurrencyEnums.GBP:
        return egp.gbp;
      case CurrencyEnums.SAR:
        return egp.sar;
      case CurrencyEnums.JPY:
        return egp.jpy;
      case CurrencyEnums.EGP:
        return null;
    }
  }

  String get _yesterdayDate {
    final d = DateTime.now().toUtc().subtract(const Duration(days: 1));
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return '${d.year}-$mm-$dd';
  }
}
