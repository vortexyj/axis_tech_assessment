import 'dart:convert';

import 'package:core/core.dart';
import '../../domain/entities/get_currency/get_currency_entity.dart';
import '../models/get_currency/request/get_currency_request_model.dart';
import '../models/get_currency/response/get_currency_response_model.dart';

/// Backs the offline fallback: the last successful response for a given
/// request (today's "latest" call, or a specific historical date) is cached
/// under its own key, so a later connection failure for that same request
/// can be answered from disk instead of failing outright.
abstract class ExchangeLocalDataSource {
  Future<void> cacheCurrency(
    GetCurrencyRequestModel requestModel,
    GetCurrencyEntity entity,
  );

  Future<GetCurrencyEntity?> getCachedCurrency(
    GetCurrencyRequestModel requestModel,
  );
}

class ExchangeLocalDataSourceImpl implements ExchangeLocalDataSource {
  final LocalStorage localStorage;
  ExchangeLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> cacheCurrency(
    GetCurrencyRequestModel requestModel,
    GetCurrencyEntity entity,
  ) async {
    final json = jsonEncode({'date': entity.date, 'egp': entity.egp?.asMap});
    await localStorage.setValue(
      key: _dataKey(requestModel),
      value: StringType(json),
    );
    await localStorage.setValue(
      key: _cachedAtKey(requestModel),
      value: StringType(DateTime.now().toIso8601String()),
    );
  }

  @override
  Future<GetCurrencyEntity?> getCachedCurrency(
    GetCurrencyRequestModel requestModel,
  ) async {
    final dataKey = _dataKey(requestModel);
    if (!await localStorage.containsKey(key: dataKey)) return null;

    final raw = await localStorage.getValue(key: dataKey);
    final map = jsonDecode(raw.value as String) as Map<String, dynamic>;
    final parsed = GetCurrencyResponseModel.fromJson(map);

    DateTime? cachedAt;
    final atKey = _cachedAtKey(requestModel);
    if (await localStorage.containsKey(key: atKey)) {
      final atRaw = await localStorage.getValue(key: atKey);
      cachedAt = DateTime.tryParse(atRaw.value as String);
    }

    return GetCurrencyEntity(
      date: parsed.date,
      egp: parsed.egp,
      isFromCache: true,
      cachedAt: cachedAt,
    );
  }

  String _dataKey(GetCurrencyRequestModel requestModel) =>
      '${StorageKeys.exchangeRatesCache}_${requestModel.date ?? 'latest'}';

  String _cachedAtKey(GetCurrencyRequestModel requestModel) =>
      '${StorageKeys.exchangeRatesCachedAt}_${requestModel.date ?? 'latest'}';
}
