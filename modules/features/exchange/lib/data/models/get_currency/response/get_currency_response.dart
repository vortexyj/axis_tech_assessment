import 'package:core/core.dart';
import '../../../../domain/entities/get_currency/get_currency_entity.dart';
import './get_currency_response_model.dart';

class GetCurrencyResponse extends ResponseModel<GetCurrencyEntity> {
  GetCurrencyResponse({
    super.result,
    super.message,
    super.statusCode,
    super.statusName,
  });

  /// This third-party API has no `{result, statusCode, ...}` app envelope —
  /// it returns the entity's fields directly at the top level. Reaching this
  /// factory means Dio already got a 2xx (otherwise it would have thrown), so
  /// the app's success status is synthesized rather than read from the body.
  factory GetCurrencyResponse.fromJson(Map<String, dynamic> json) {
    return GetCurrencyResponse(
      result: GetCurrencyResponseModel.fromJson(json),
      statusCode: AppValues.successCode,
    );
  }
}
