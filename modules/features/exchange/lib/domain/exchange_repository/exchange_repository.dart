import 'package:core/packages/dartz/dartz.dart';
import 'package:failures/failures.dart';
import '../entities/get_currency/get_currency_entity.dart';
import '../../data/models/get_currency/request/get_currency_request_model.dart';
// [Adding_new_model_import_here_dont_remove_this_command_!!!]

abstract class ExchangeRepository {
  Future<Either<Failure, GetCurrencyEntity>> getCurrency({required GetCurrencyRequestModel requestModel});
  // [Adding_new_repo_method_here_dont_remove_this_command_!!!]
}
