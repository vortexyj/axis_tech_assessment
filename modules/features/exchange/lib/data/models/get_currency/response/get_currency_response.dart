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

  GetCurrencyResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, (data) => GetCurrencyResponseModel.fromJson(data));
}
