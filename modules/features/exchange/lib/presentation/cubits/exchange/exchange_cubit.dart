import 'package:core/core.dart';
import 'package:exchange/data/models/get_currency/request/get_currency_request_model.dart';
import 'package:exchange/domain/entities/exchange_rate/exchange_rate_item.dart';
import 'package:exchange/domain/entities/get_currency/get_currency_entity.dart';
import 'package:exchange/domain/exchange_usecase/get_currency_usecase/get_currency_usecase.dart';
part 'exchange_state.dart';

class ExchangeCubit extends BaseCubit<ExchangeState> {
  final GetCurrencyUseCase _getCurrencyUseCase;
  ExchangeCubit(this._getCurrencyUseCase) : super(const ExchangeState());

  /// Every target currency except the base (EGP) — derived from the enum
  /// itself, so adding/removing a currency there doesn't need a change here.
  static final List<CurrencyEnums> currencyOrder =
      CurrencyEnums.values.where((c) => c != CurrencyEnums.EGP).toList();

  @override
  Future<void> initState() async {
    await getTodayRate();
    await getYesterdayRate();
    _buildRates();
  }

  Future<void> getTodayRate({CurrencyEnums? currency}) async {
    emitIfNotClosed(state.copyWith(pageState: PageState.loading));

    final result = await _getCurrencyUseCase.call(
      GetCurrencyRequestModel(null, currency),
    );
    result.fold(
      (failure) => emitIfNotClosed(
        state.copyWith(pageState: PageState.failure, failure: failure),
      ),
      (entity) => emitIfNotClosed(
        state.copyWith(
          pageState: PageState.success,
          todayCurrency: entity,
          lastUpdated: DateTime.now(),
        ),
      ),
    );
  }

  Future<void> getYesterdayRate({CurrencyEnums? currency}) async {
    emitIfNotClosed(state.copyWith(pageState: PageState.loading));
    final result = await _getCurrencyUseCase.call(
      GetCurrencyRequestModel(_yesterdayDate, currency),
    );
    result.fold(
      (failure) => emitIfNotClosed(
        state.copyWith(pageState: PageState.failure, failure: failure),
      ),
      (entity) => emitIfNotClosed(
        state.copyWith(pageState: PageState.success, yesterdayCurrency: entity),
      ),
    );
  }

  void _buildRates() {
    final today = state.todayCurrency!.egp;
    final yesterday = state.yesterdayCurrency!.egp;

    final rates = currencyOrder.map((currency) {
      final todayRate = today!.asMap[currency.responseKey]!;
      final yesterdayRate = yesterday!.asMap[currency.responseKey]!;
      return ExchangeRateItem(
        currency: currency,
        rate: 1 / todayRate,
        previousRate: 1 / yesterdayRate,
      );
    }).toList();

    final isOffline =
        state.todayCurrency!.isFromCache || state.yesterdayCurrency!.isFromCache;
    final cachedAt = state.todayCurrency!.cachedAt ?? state.yesterdayCurrency!.cachedAt;

    emitIfNotClosed(
      state.copyWith(
        pageState: rates.isEmpty ? PageState.empty : PageState.success,
        rates: rates,
        lastUpdated: DateTime.now(),
        isOffline: isOffline,
        cachedAt: cachedAt,
      ),
    );
  }

  String get _yesterdayDate {
    final d = DateTime.now().toUtc().subtract(const Duration(days: 1));
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return '${d.year}-$mm-$dd';
  }
}
