import 'package:core/core.dart';
import '../models/currency_details/request/currency_details_request.dart';
import '../models/currency_details/request/currency_details_request_model.dart';
import '../models/currency_details/response/currency_details_response.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

abstract class CurrencyDetailsRemoteDataSource {
  Future<CurrencyDetailsResponse> currencyDetails(
    CurrencyDetailsRequestModel currencyDetailsdata,
  );
  // [Adding_new_datasource_method_here_dont_remove_this_command_!!!]
}

class CurrencyDetailsRemoteDataSourceImpl
    implements CurrencyDetailsRemoteDataSource {
  final Network network;
  CurrencyDetailsRemoteDataSourceImpl({required this.network});

  @override
  Future<CurrencyDetailsResponse> currencyDetails(
    CurrencyDetailsRequestModel currencyDetailsdata,
  ) async {
    final apiRequest = CurrencyDetailsRequest(currencyDetailsdata);
    final result = await network.send(
      request: apiRequest,
      responseFromMap: (map) => CurrencyDetailsResponse.fromJson(map),
    );
    return result;
  }

  // [Adding_new_datasource_impl_method_here_dont_remove_this_command_!!!]
}
