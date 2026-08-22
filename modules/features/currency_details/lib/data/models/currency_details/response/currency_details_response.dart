import 'package:core/core.dart';
import '../../../../domain/entities/currency_details/currency_details_entity.dart';
import './currency_details_response_model.dart';

class CurrencyDetailsResponse extends ResponseModel<CurrencyDetailsEntity> {
  CurrencyDetailsResponse({
    super.result,
    super.message,
    super.statusCode,
    super.statusName,
  });

  /// This third-party API has no `{result, statusCode, ...}` app envelope —
  /// it returns the entity's fields directly at the top level. Reaching this
  /// factory means Dio already got a 2xx (otherwise it would have thrown), so
  /// the app's success status is synthesized rather than read from the body.
  factory CurrencyDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyDetailsResponse(
      result: CurrencyDetailsResponseModel.fromJson(json),
      statusCode: AppValues.successCode,
    );
  }
}
