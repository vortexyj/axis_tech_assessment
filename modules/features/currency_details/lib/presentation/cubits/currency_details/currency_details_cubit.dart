import 'package:core/core.dart';
import 'package:currency_details/data/models/currency_details/request/currency_details_request_model.dart';
import 'package:currency_details/domain/entities/currency_details/egp_entity.dart';
import 'package:currency_details/domain/entities/currency_history/currency_history_point.dart';
import 'package:currency_details/domain/currency_details_usecase/currency_details_usecase/currency_details_usecase.dart';
part 'currency_details_state.dart';

class CurrencyDetailsCubit extends BaseCubit<CurrencyDetailsState> {
  final CurrencyDetailsUseCase _currencyDetailsUseCase;
  CurrencyDetailsCubit(this._currencyDetailsUseCase)
    : super(const CurrencyDetailsState());

  static const int historyDays = 7;

  final Map<String, EgpEntity> _ratesByDate = {};
  Failure? _fetchFailure;
  bool _sawCache = false;
  DateTime? _lastCachedAt;
  late CurrencyEnums _currency;

  @override
  Future<void> initState() async {}

  List<DateTime> get _last7Days => List.generate(
    historyDays,
    (i) => DateTime.now().toUtc().subtract(Duration(days: i)),
  ).reversed.toList();

  Future<void> getCurrencyDetails(CurrencyEnums currency) async {
    _currency = currency;
    _ratesByDate.clear();
    _fetchFailure = null;
    _sawCache = false;
    _lastCachedAt = null;
    emitIfNotClosed(state.copyWith(pageState: PageState.loading));

    final days = _last7Days;
    final today = days.last;
    final yesterday = days[days.length - 2];

    await getTodayRate(today);
    await getYesterdayRate(yesterday);
    _buildCurrentRate();

    for (final day in days.take(days.length - 2)) {
      await _fetchDay(day, isToday: false);
    }
    _buildHistory();
  }

  Future<void> getTodayRate(DateTime today) => _fetchDay(today, isToday: true);

  Future<void> getYesterdayRate(DateTime yesterday) =>
      _fetchDay(yesterday, isToday: false);

  Future<void> _fetchDay(DateTime day, {required bool isToday}) async {
    final result = await _currencyDetailsUseCase.call(
      CurrencyDetailsRequestModel(
        date: isToday ? null : _dateKey(day),
        currencyEnums: CurrencyEnums.EGP,
      ),
    );
    result.fold((failure) => _fetchFailure ??= failure, (entity) {
      final egp = entity.egp;
      if (egp != null) _ratesByDate[_dateKey(day)] = egp;
      if (entity.isFromCache) {
        _sawCache = true;
        _lastCachedAt ??= entity.cachedAt;
      }
    });
  }

  void _buildCurrentRate() {
    if (_fetchFailure != null) {
      emitIfNotClosed(
        state.copyWith(pageState: PageState.failure, failure: _fetchFailure),
      );
      return;
    }

    final days = _last7Days;
    final today = _ratesByDate[_dateKey(days.last)];
    final yesterday = _ratesByDate[_dateKey(days[days.length - 2])];
    final todayRate = today?.asMap[_currency.responseKey];
    final yesterdayRate = yesterday?.asMap[_currency.responseKey];

    if (todayRate == null || yesterdayRate == null) {
      emitIfNotClosed(
        state.copyWith(
          pageState: PageState.failure,
          failure: ValidationFailure(message: 'Missing exchange rate data.'),
        ),
      );
      return;
    }

    emitIfNotClosed(
      state.copyWith(
        pageState: PageState.shimmerLoading,
        currency: _currency,
        rate: 1 / todayRate,
        previousRate: 1 / yesterdayRate,
        lastUpdated: DateTime.now(),
        isOffline: _sawCache,
        cachedAt: _lastCachedAt,
      ),
    );
  }

  void _buildHistory() {
    if (_fetchFailure != null) {
      emitIfNotClosed(
        state.copyWith(pageState: PageState.failure, failure: _fetchFailure),
      );
      return;
    }

    final points = <CurrencyHistoryPoint>[];
    for (final day in _last7Days) {
      final egp = _ratesByDate[_dateKey(day)];
      final raw = egp?.asMap[_currency.responseKey];
      if (raw == null) continue;
      points.add(CurrencyHistoryPoint(date: day, rate: 1 / raw));
    }

    emitIfNotClosed(
      state.copyWith(
        pageState: points.isEmpty ? PageState.empty : PageState.success,
        history: points,
        isOffline: _sawCache,
        cachedAt: _lastCachedAt,
      ),
    );
  }

  String _dateKey(DateTime d) {
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return '${d.year}-$mm-$dd';
  }
}
