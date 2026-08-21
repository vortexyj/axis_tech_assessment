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

  CurrencyDetailsResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, (data) => CurrencyDetailsResponseModel.fromJson(data));
}
