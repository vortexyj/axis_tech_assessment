import 'package:core/core.dart';
import '../models/get_currency/request/get_currency_request.dart';
import '../models/get_currency/request/get_currency_request_model.dart';
import '../models/get_currency/response/get_currency_response.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

abstract class ExchangeRemoteDataSource {
  Future<GetCurrencyResponse> getCurrency(GetCurrencyRequestModel requestModel);
  // [Adding_new_datasource_method_here_dont_remove_this_command_!!!]
}

class ExchangeRemoteDataSourceImpl implements ExchangeRemoteDataSource {
  final Network network;
  ExchangeRemoteDataSourceImpl({required this.network});

  @override
  Future<GetCurrencyResponse> getCurrency(
    GetCurrencyRequestModel requestModel,
  ) async {
    final apiRequest = GetCurrencyRequest(requestModel);
    final result = await network.send(
      request: apiRequest,
      responseFromMap: (map) => GetCurrencyResponse.fromJson(map),
    );
    return result;
  }

  // [Adding_new_datasource_impl_method_here_dont_remove_this_command_!!!]
}
