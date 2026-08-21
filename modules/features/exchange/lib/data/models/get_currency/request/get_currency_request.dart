import 'package:core/core.dart';
import './get_currency_request_model.dart';

class GetCurrencyRequest with Request, GetRequest {
  const GetCurrencyRequest(this.requestModel);
  @override
  final GetCurrencyRequestModel requestModel;

  @override
  String get baseUrl => requestModel.date != null
      ? 'https://${requestModel.date}.currency-api.pages.dev/v1/currencies/'
      : AppFlavor.instance.baseUrl;

  @override
  String get path =>
      '/${requestModel.currencyEnums?.responseKey ?? 'egp'}.json';
}
