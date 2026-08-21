import 'package:core/packages/dartz/dartz.dart';
import 'package:failures/failures.dart';
import '../entities/currency_details/currency_details_entity.dart';
import '../../data/models/currency_details/request/currency_details_request_model.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

abstract class CurrencyDetailsRepository {
  Future<Either<Failure, CurrencyDetailsEntity>> currencyDetails({
    required CurrencyDetailsRequestModel requestModel,
  });
  // [Adding_new_repo_method_here_dont_remove_this_command_!!!]
}
