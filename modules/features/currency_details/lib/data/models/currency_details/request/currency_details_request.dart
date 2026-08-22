import 'package:core/core.dart';
import './currency_details_request_model.dart';

class CurrencyDetailsRequest with Request, GetRequest {
  const CurrencyDetailsRequest(this.requestModel);
  @override
  final CurrencyDetailsRequestModel requestModel;

  @override
  String get baseUrl => requestModel.date != null
      ? 'https://${requestModel.date}.currency-api.pages.dev/v1/currencies/'
      : AppFlavor.instance.baseUrl;

  @override
  String get path => '${requestModel.currencyEnums?.responseKey ?? 'egp'}.json';
}
