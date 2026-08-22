import 'dart:convert';

import 'package:core/core.dart';
import '../../domain/entities/currency_details/currency_details_entity.dart';
import '../models/currency_details/request/currency_details_request_model.dart';
import '../models/currency_details/response/currency_details_response_model.dart';

/// Backs the offline fallback for a given day's EGP snapshot. Uses the same
/// storage keys as the exchange list screen's cache — both fetch the exact
/// same `egp.json` resource per date, so a day already cached by the list
/// screen is a free hit here too, and vice versa.
abstract class CurrencyDetailsLocalDataSource {
  Future<void> cacheCurrency(
    CurrencyDetailsRequestModel requestModel,
    CurrencyDetailsEntity entity,
  );

  Future<CurrencyDetailsEntity?> getCachedCurrency(
    CurrencyDetailsRequestModel requestModel,
  );
}

class CurrencyDetailsLocalDataSourceImpl
    implements CurrencyDetailsLocalDataSource {
  final LocalStorage localStorage;
  CurrencyDetailsLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> cacheCurrency(
    CurrencyDetailsRequestModel requestModel,
    CurrencyDetailsEntity entity,
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
  Future<CurrencyDetailsEntity?> getCachedCurrency(
    CurrencyDetailsRequestModel requestModel,
  ) async {
    final dataKey = _dataKey(requestModel);
    if (!await localStorage.containsKey(key: dataKey)) return null;

    final raw = await localStorage.getValue(key: dataKey);
    final map = jsonDecode(raw.value as String) as Map<String, dynamic>;
    final parsed = CurrencyDetailsResponseModel.fromJson(map);

    DateTime? cachedAt;
    final atKey = _cachedAtKey(requestModel);
    if (await localStorage.containsKey(key: atKey)) {
      final atRaw = await localStorage.getValue(key: atKey);
      cachedAt = DateTime.tryParse(atRaw.value as String);
    }

    return CurrencyDetailsEntity(
      date: parsed.date,
      egp: parsed.egp,
      isFromCache: true,
      cachedAt: cachedAt,
    );
  }

  String _dataKey(CurrencyDetailsRequestModel requestModel) =>
      '${StorageKeys.exchangeRatesCache}_${requestModel.date ?? 'latest'}';

  String _cachedAtKey(CurrencyDetailsRequestModel requestModel) =>
      '${StorageKeys.exchangeRatesCachedAt}_${requestModel.date ?? 'latest'}';
}
